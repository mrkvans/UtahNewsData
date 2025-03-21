//
//  ScrapeStory.swift
//  UtahNewsData
//
//  Created by Mark Evans on 11/26/24.
//

/*
 # ScrapeStory Model

 This file defines the ScrapeStory model and related response structures used for
 web scraping operations in the UtahNewsData system. These models represent the raw
 data extracted from news websites before it's processed into the system's domain models.

 ## Key Components:

 1. ScrapeStory: Raw story data extracted from a web page
 2. StoryExtract: Collection of scraped stories
 3. Response structures: Wrappers for API responses

 ## Usage:

 ```swift
 // Process a scraped story into an Article
 func processScrapedStory(story: ScrapeStory, baseURL: String) -> Article? {
     return Article(from: story, baseURL: baseURL)
 }

 // Handle a FirecrawlResponse from the scraping service
 func handleScrapingResponse(response: FirecrawlResponse) {
     if response.success {
         for story in response.data.extract.stories {
             if let article = processScrapedStory(story: story, baseURL: "https://example.com") {
                 dataStore.addArticle(article)
             }
         }
     } else {
         print("Scraping operation failed")
     }
 }
 ```

 The ScrapeStory model is designed to be a flexible container for raw scraped data,
 with optional properties to accommodate the varying information available from
 different news sources.
 */

import Foundation

/// Collection of scraped stories from a web source.
public struct StoryExtract: BaseEntity, Codable, Sendable {
    /// Unique identifier for the story extract
    public var id: String = UUID().uuidString

    /// The name or description of this story extract
    public var name: String = "Story Extract"

    /// Array of scraped stories
    public let stories: [ScrapeStory]

    /// Creates a new story extract with the specified stories.
    /// - Parameter stories: Array of scraped stories
    public init(stories: [ScrapeStory]) {
        self.stories = stories
    }
}

/// Represents raw story data extracted from a web page.
/// This is the initial data structure used before processing into domain models.
public struct ScrapeStory: BaseEntity, Codable, Sendable {
    /// Unique identifier for the scraped story
    public var id: String

    /// The name or title of this scraped story
    public var name: String {
        return title ?? "Untitled Story"
    }

    /// Title or headline of the story
    public var title: String?

    /// Main text content of the story
    public var textContent: String?

    /// URL where the story can be accessed
    public var url: String?

    /// URL to the main image for the story
    public var urlToImage: String?

    /// URLs to additional images in the story
    public var additionalImages: [String]?

    /// When the story was published (as a string, needs parsing)
    public var publishedAt: String?

    /// Author or creator of the story
    public var author: String?

    /// Category or section the story belongs to
    public var category: String?

    /// URL to video content associated with the story
    public var videoURL: String?
}

/// Response structure for a single story extraction API call.
public struct SingleStoryResponse: BaseEntity, Codable, Sendable {
    /// Unique identifier for the response
    public var id: String = UUID().uuidString

    /// The name or description of this response
    public var name: String = "Single Story Response"

    /// Whether the extraction was successful
    public let success: Bool

    /// The extracted data
    public let data: SingleStoryData
}

/// Container for a single extracted story.
public struct SingleStoryData: BaseEntity, Codable, Sendable {
    /// Unique identifier for the data container
    public var id: String = UUID().uuidString

    /// The name or description of this data container
    public var name: String = "Single Story Data"

    /// The extracted story
    public let extract: ScrapeStory
}

/// Response structure for a batch crawling API call.
public struct FirecrawlResponse: BaseEntity, Codable, Sendable {
    /// Unique identifier for the response
    public var id: String = UUID().uuidString

    /// The name or description of this response
    public var name: String = "Firecrawl Response"

    /// Whether the crawling operation was successful
    public let success: Bool

    /// The extracted data
    public let data: FirecrawlData
}

/// Container for batch extracted stories.
public struct FirecrawlData: BaseEntity, Codable, Sendable {
    /// Unique identifier for the data container
    public var id: String = UUID().uuidString

    /// The name or description of this data container
    public var name: String = "Firecrawl Data"

    /// Collection of extracted stories
    public let extract: StoryExtract
}
