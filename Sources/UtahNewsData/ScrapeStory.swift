//
//  File.swift
//  UtahNewsData
//
//  Created by Mark Evans on 11/26/24.
//

import Foundation


// MARK: - StoryExtract
public struct StoryExtract: Codable {
    let stories: [ScrapeStory]
}

// MARK: - ScrapeStory
public struct ScrapeStory: Codable {
//    var id: String
    public var title: String?
    public var textContent: String?
    public var url: String?
    public var urlToImage: String?
    public var additionalImages: [String]?
    public var publishedAt: String?
    public var author: String?
    public var category: String?
    public var videoURL: String?
}
