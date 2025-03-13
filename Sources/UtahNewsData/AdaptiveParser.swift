//
//  AdaptiveParser.swift
//  UtahNewsData
//
//  Created by Mark Evans on 3/21/24
//
//  Summary: Provides an adaptive HTML parser that can learn and adjust to different website structures.

import Foundation
import SwiftSoup

/// A parser that can adapt to different HTML structures and fall back to LLM extraction
@MainActor
public class AdaptiveParser: @unchecked Sendable {

    // MARK: - Types

    /// Represents a set of CSS selectors for parsing specific content types
    public struct SelectorSet: Codable {
        var title: String
        var content: String
        var author: String?
        var date: String?
        var image: String?
        var category: String?

        public init(
            title: String = "h1",
            content: String = "article",
            author: String? = nil,
            date: String? = nil,
            image: String? = nil,
            category: String? = nil
        ) {
            self.title = title
            self.content = content
            self.author = author
            self.date = date
            self.image = image
            self.category = category
        }
    }

    /// Result of a parsing attempt
    public enum ParsingResult<T: Sendable>: Sendable {
        case success(T, source: ParsingSource)
        case failure(Error)

        public var isSuccess: Bool {
            switch self {
            case .success: return true
            case .failure: return false
            }
        }
    }

    /// Source of the parsed content
    public enum ParsingSource: Sendable {
        case htmlParsing
        case llmExtraction
    }

    /// Errors that can occur during parsing
    public enum ParsingError: Error {
        case invalidType
        case invalidHTML
        case llmError(String)
        case llmExtractionFailed
    }

    // MARK: - Properties

    /// Cache of successful selector sets for different domains
    private var selectorCache: [String: SelectorSet] = [:]

    /// The LLM manager for fallback extraction
    private let llmManager: LocalLLMManager

    /// Whether to use LLM fallback when HTML parsing fails
    private let useLLMFallback: Bool

    // MARK: - Initialization

    /// Creates a new adaptive parser
    /// - Parameters:
    ///   - useLLMFallback: Whether to use LLM fallback when HTML parsing fails
    ///   - llmManager: The LLM manager to use for fallback (defaults to a new instance)
    public init(useLLMFallback: Bool = true, llmManager: LocalLLMManager? = nil) {
        self.useLLMFallback = useLLMFallback
        self.llmManager = llmManager ?? LocalLLMManager()
    }

    // MARK: - Parsing Methods

    /// Parse HTML content with fallback to LLM if needed
    /// - Parameters:
    ///   - html: The HTML content to parse
    ///   - url: The URL of the content
    ///   - type: The type to parse into
    /// - Returns: The parsing result, indicating success/failure and the source
    public func parseWithFallback<T: HTMLParsable>(
        html: String, from url: URL? = nil, as type: T.Type
    ) async throws -> ParsingResult<T> {
        do {
            print("🔍 Starting HTML parsing for type: \(T.self)")
            // First try HTML parsing with URL if available
            let document =
                try url.map { try SwiftSoup.parse(html, $0.absoluteString) }
                ?? SwiftSoup.parse(html)

            // Log the document structure for debugging
            print("📄 Document structure:")
            print("  - Title: \(try? document.title() ?? "No title")")
            print("  - Body content length: \(try document.body()?.text().count ?? 0) characters")

            let parsedContent = try T.parse(from: document)

            // Check for empty required properties
            var shouldUseLLM = false
            var emptyProperties: [String] = []

            // Check common properties based on type
            if let person = parsedContent as? Person {
                print("👤 Parsed Person - Name: \(person.name)")
                print("👤 Person details: \(person.details)")

                if person.name.isEmpty || person.details.isEmpty {
                    print("⚠️ Person has empty required fields, should trigger LLM")
                    shouldUseLLM = true
                    if person.name.isEmpty { emptyProperties.append("name") }
                    if person.details.isEmpty { emptyProperties.append("details") }
                }
            } else if let article = parsedContent as? Article {
                print("📄 Parsed Article - Title: \(article.title)")
                print(
                    "📄 Article textContent is: \(article.textContent == nil ? "nil" : "\(article.textContent!.isEmpty ? "empty string" : "has content")")"
                )

                if article.textContent?.isEmpty ?? true {
                    print("⚠️ Article content is empty or nil, should trigger LLM")
                    shouldUseLLM = true
                    emptyProperties.append("main content")
                }
            } else if let newsStory = parsedContent as? NewsStory {
                print("📰 Parsed NewsStory - Headline: \(newsStory.headline)")
                print(
                    "📰 NewsStory content is: \(newsStory.content == nil ? "nil" : "\(newsStory.content!.isEmpty ? "empty string" : "has content")")"
                )

                if newsStory.content?.isEmpty ?? true {
                    print("⚠️ NewsStory content is empty or nil, should trigger LLM")
                    shouldUseLLM = true
                    emptyProperties.append("main content")
                }
            }

            // If we have empty properties and LLM is enabled, extract them
            if shouldUseLLM && useLLMFallback {
                print("🤖 Attempting LLM extraction for empty properties: \(emptyProperties)")
                do {
                    var updatedContent = parsedContent

                    // Extract each missing property
                    for property in emptyProperties {
                        print("🤖 Extracting \(property) using LLM")
                        let extracted = try await llmManager.extractContent(
                            from: html, contentType: property)
                        print("🤖 LLM extracted content length: \(extracted.count) characters")

                        // Update the appropriate property
                        if var person = updatedContent as? Person {
                            switch property {
                            case "name":
                                person.name = extracted
                            case "details":
                                person.details = extracted
                            default:
                                break
                            }
                            updatedContent = person as! T
                        }
                    }

                    print("✅ Successfully updated content with LLM extraction")
                    return .success(updatedContent, source: .llmExtraction)
                } catch {
                    print("❌ LLM extraction failed: \(error)")
                    print("⚠️ Falling back to original parsed content")
                    return .success(parsedContent, source: .htmlParsing)
                }
            }

            print("✅ Returning HTML parsed content")
            return .success(parsedContent, source: .htmlParsing)

        } catch {
            print("❌ HTML parsing failed completely: \(error)")
            // If HTML parsing completely fails and LLM fallback is enabled, try LLM extraction
            if useLLMFallback {
                print("🤖 Attempting full LLM extraction after HTML parsing failure")
                do {
                    // Extract title and content using LLM
                    let title = try await llmManager.extractContent(
                        from: html, contentType: "title")
                    let content = try await llmManager.extractContent(
                        from: html, contentType: "main content")

                    // Create appropriate type based on extracted content
                    if let result = try? createInstance(
                        ofType: T.self, withTitle: title, content: content)
                    {
                        print("✅ Successfully created instance from LLM extraction")
                        return .success(result, source: .llmExtraction)
                    }

                    print("❌ Failed to create instance from LLM extraction")
                    throw ParsingError.llmExtractionFailed
                } catch {
                    print("❌ LLM extraction failed: \(error)")
                    throw ParsingError.llmExtractionFailed
                }
            } else {
                throw ParsingError.invalidHTML
            }
        }
    }

    /// Parses HTML content using stored selectors for the domain if available
    /// - Parameters:
    ///   - html: The HTML content to parse
    ///   - url: The URL of the content (used for domain-specific selectors)
    /// - Returns: A dictionary of extracted content
    public func parse(html: String, from url: URL) throws -> [String: String] {
        let document = try SwiftSoup.parse(html)
        let domain = url.host ?? ""

        // Get or create selector set for this domain
        let selectors = selectorCache[domain] ?? SelectorSet()

        var result: [String: String] = [:]

        // Extract content using selectors
        if let title = try document.select(selectors.title).first()?.text() {
            result["title"] = title
        }

        if let content = try document.select(selectors.content).first()?.text() {
            result["content"] = content
        }

        if let author = selectors.author.flatMap({ try? document.select($0).first()?.text() }) {
            result["author"] = author
        }

        if let date = selectors.date.flatMap({ try? document.select($0).first()?.text() }) {
            result["date"] = date
        }

        if let image = selectors.image.flatMap({ try? document.select($0).first()?.attr("src") }) {
            result["image"] = image
        }

        if let category = selectors.category.flatMap({ try? document.select($0).first()?.text() }) {
            result["category"] = category
        }

        return result
    }

    // MARK: - Learning Methods

    /// Updates the selector set for a specific domain based on successful parsing
    /// - Parameters:
    ///   - selectors: The successful selector set
    ///   - domain: The domain these selectors work for
    public func learn(selectors: SelectorSet, for domain: String) {
        selectorCache[domain] = selectors
    }

    /// Attempts to find optimal selectors for a given HTML structure
    /// - Parameter document: The parsed HTML document
    /// - Returns: A set of selectors that might work for this structure
    public func discoverSelectors(in document: Document) throws -> SelectorSet {
        var selectors = SelectorSet()

        // Try common title selectors
        let titleSelectors = ["h1", ".article-title", ".post-title", "[itemprop='headline']"]
        for selector in titleSelectors {
            if try !document.select(selector).isEmpty() {
                selectors.title = selector
                break
            }
        }

        // Try common content selectors
        let contentSelectors = [
            "article", ".article-content", ".post-content", "[itemprop='articleBody']",
        ]
        for selector in contentSelectors {
            if try !document.select(selector).isEmpty() {
                selectors.content = selector
                break
            }
        }

        // Try common author selectors
        let authorSelectors = [".author", "[rel='author']", "[itemprop='author']"]
        for selector in authorSelectors {
            if try !document.select(selector).isEmpty() {
                selectors.author = selector
                break
            }
        }

        return selectors
    }

    /// Clears the selector cache for testing or reset purposes
    public func clearCache() {
        selectorCache.removeAll()
    }

    // Helper method to create instances of different types
    private func createInstance<T>(ofType type: T.Type, withTitle title: String, content: String)
        throws -> T
    {
        if T.self == Article.self {
            let article = Article(
                title: title,
                url: "",  // Empty since we don't have it
                urlToImage: nil,
                additionalImages: nil,
                publishedAt: Date(),
                textContent: content,
                author: nil,
                category: nil
            )
            return article as! T
        }
        // Add other type handling as needed
        throw ParsingError.invalidType
    }
}
