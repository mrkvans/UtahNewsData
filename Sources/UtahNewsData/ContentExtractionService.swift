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
        let commonSelectors = [
            "section", ".person-section", ".council-member", ".member-section",
            ".staff-section", ".employee-section", ".official-section",
            ".elected-official", ".department-head", ".leadership",
        ]

        print("🔍 Trying common section selectors...")
        for selector in commonSelectors {
            let sections = try document.select(selector)
            if !sections.isEmpty() {
                print("✅ Found \(sections.size()) sections using selector: \(selector)")
                // Try parsing each section individually
                var items: [T] = []
                for section in sections {
                    do {
                        let sectionHtml = try section.outerHtml()
                        let result = try await parser.parseCollectionWithFallback(
                            html: sectionHtml,
                            from: url,
                            as: type
                        )
                        if case .success(let sectionItems, _) = result {
                            items.append(contentsOf: sectionItems)
                        }
                    } catch {
                        print("⚠️ Failed to parse section: \(error.localizedDescription)")
                        continue
                    }
                }

                if !items.isEmpty {
                    print("✅ Successfully parsed \(items.count) items from sections")
                    return items
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
