//
//  ContentExtractionService.swift
//  UtahNewsData
//
//  Created by Mark Evans on 3/21/24
//
//  Summary: Provides an abstraction layer for HTML content extraction and parsing into domain models.

import Foundation
import SwiftSoup

/// A service that loads HTML from a URL and maps it to a Swift object conforming to HTMLParsable.
@MainActor
public class ContentExtractionService: @unchecked Sendable {

    /// The shared instance of the content extraction service.
    public static let shared = ContentExtractionService()

    /// The adaptive parser instance used for content extraction.
    private let parser: AdaptiveParser

    /// Initialize with an optional parser
    public init() {
        self.parser = AdaptiveParser()
    }

    /// Initialize with a specific parser
    public init(parser: AdaptiveParser) {
        self.parser = parser
    }

    /// Extract content from a URL and parse it into a model.
    /// - Parameters:
    ///   - url: The URL to extract content from.
    ///   - type: The type of model to parse into.
    /// - Returns: The parsed model.
    public func extractContent<T: HTMLParsable & Sendable>(from url: URL, as type: T.Type)
        async throws -> T
    {
        let html = try await fetchHTML(from: url)

        // Create document with baseUri set to the source URL
        let document = try SwiftSoup.parse(html, url.absoluteString)
        let result = try await parser.parseWithFallback(html: html, from: url, as: type)

        switch result {
        case .success(let content, _):
            return content
        case .failure(let error):
            throw error
        }
    }

    /// Extract content as a collection from a URL and parse it into an array of models.
    /// - Parameters:
    ///   - url: The URL to extract content from.
    ///   - type: The type of model to parse into.
    /// - Returns: An array of parsed models.
    public func extractContentAsCollection<T: HTMLCollectionParsable & Sendable>(
        from url: URL, as type: T.Type
    ) async throws -> [T] {
        let html = try await fetchHTML(from: url)
        print("📄 Fetched HTML content length: \(html.count) characters")

        // Try parsing with common section selectors first
        let document = try SwiftSoup.parse(html, url.absoluteString)

        // First try to find a container that might hold all the people
        let containerSelectors = [
            ".council-members", "#council-members",
            ".elected-officials", "#elected-officials",
            ".staff-directory", "#staff-directory",
            ".directory-listing", "#directory-listing",
            "main", "#main-content", ".main-content",
            "article", ".article",
        ]

        print("🔍 Trying to find main container...")
        var mainContainer = document
        for selector in containerSelectors {
            if let container = try document.select(selector).first() {
                print("✅ Found main container using selector: \(selector)")
                mainContainer = try SwiftSoup.parse(container.outerHtml())
                break
            }
        }

        // Now look for individual person sections within the container
        let personSelectors = [
            // Generic person selectors
            ".person", ".member", ".official", ".staff-member",
            // Common grid/list item selectors
            ".directory-item", ".grid-item", ".list-item",
            // Specific to government sites
            ".council-member", ".elected-official", ".department-head",
            // Common card selectors
            ".card", ".profile-card", ".member-card",
            // Specific to Lehi City website
            ".official-card", ".staff-card", ".bio-card",
            // Fallback to any div with person-related classes
            "div[class*='person']", "div[class*='member']", "div[class*='official']",
        ]

        print("🔍 Trying to find person sections...")
        var allPeople: [T] = []

        for selector in personSelectors {
            let sections = try mainContainer.select(selector)
            if !sections.isEmpty() {
                print("✅ Found \(sections.size()) sections using selector: \(selector)")

                // Create a minimal HTML wrapper for each section
                for section in sections {
                    do {
                        let wrappedHtml = """
                            <!DOCTYPE html>
                            <html>
                            <head><title>\(try document.title() ?? "")</title></head>
                            <body>
                            \(try section.outerHtml())
                            </body>
                            </html>
                            """

                        let result = try await parser.parseCollectionWithFallback(
                            html: wrappedHtml,
                            from: url,
                            as: type
                        )

                        if case .success(let items, let source) = result {
                            print("✅ Parsed section using \(source)")
                            allPeople.append(contentsOf: items)
                        }
                    } catch {
                        print("⚠️ Failed to parse section: \(error.localizedDescription)")
                        continue
                    }
                }

                if !allPeople.isEmpty {
                    print("✅ Successfully parsed \(allPeople.count) people from sections")
                    return allPeople
                }
            }
        }

        // If section parsing failed, try parsing the whole document
        print("🔄 Trying to parse whole document...")
        let result = try await parser.parseCollectionWithFallback(html: html, from: url, as: type)

        switch result {
        case .success(let content, let source):
            print("✅ Successfully parsed \(content.count) items using \(source)")
            if content.isEmpty {
                throw ContentExtractionError.noItemsFound
            }
            return content
        case .failure(let error):
            print("❌ Failed to parse content: \(error.localizedDescription)")
            throw ContentExtractionError.parsingError(error.localizedDescription)
        }
    }

    /// Extract content from multiple URLs in parallel.
    /// - Parameters:
    ///   - urls: The URLs to extract content from.
    ///   - type: The type of model to parse into.
    /// - Returns: Array of successfully parsed models, in the same order as the input URLs.
    public func extractContent<T: HTMLParsable & Sendable>(from urls: [URL], as type: T.Type)
        async throws -> [T]
    {
        try await withThrowingTaskGroup(of: (Int, T?).self) { group in
            for (index, url) in urls.enumerated() {
                group.addTask {
                    do {
                        let content = try await self.extractContent(from: url, as: type)
                        return (index, content)
                    } catch {
                        return (index, nil)
                    }
                }
            }

            var results: [(Int, T?)] = []
            for try await result in group {
                results.append(result)
            }

            return
                results
                .sorted { $0.0 < $1.0 }
                .compactMap { $0.1 }
        }
    }

    /// Fetches HTML content from a URL
    private func fetchHTML(from url: URL) async throws -> String {
        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
            (200...299).contains(httpResponse.statusCode)
        else {
            throw ContentExtractionError.invalidResponse
        }

        guard let html = String(data: data, encoding: .utf8) else {
            throw ContentExtractionError.invalidEncoding
        }

        return html
    }
}

/// Errors that can occur during content extraction
public enum ContentExtractionError: Error {
    case invalidResponse
    case invalidEncoding
    case parsingError(String)
    case noItemsFound

    public var localizedDescription: String {
        switch self {
        case .invalidResponse:
            return "Failed to get a valid response from the server"
        case .invalidEncoding:
            return "Failed to decode the HTML content"
        case .parsingError(let message):
            return "Failed to parse content: \(message)"
        case .noItemsFound:
            return "No items were found in the content"
        }
    }
}
