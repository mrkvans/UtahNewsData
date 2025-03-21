// This file consolidates model definitions (commented out) from targeted files.
// Generated on Wed Mar 12 09:12:30 MDT 2025
// Current time: March 12, 2025 at 09:12:30 AM MDT
// Do NOT uncomment this file into your code base.

// File: Article.swift
// //
// //  Article.swift
// //  UtahNewsData
// //
// //  Created by Mark Evans on 11/18/24
// //
// //  Summary: Defines the Article model which represents a news article in the UtahNewsData system.
// //           Now conforms to JSONSchemaProvider to provide a static JSON schema for LLM responses.
// 
// import Foundation
// import SwiftUI
// 
// /// A struct representing an article in the news app.
// /// Articles are a type of news content that can maintain relationships with other entities.
// public struct Article: NewsContent, AssociatedData, JSONSchemaProvider, Sendable {
//     /// Unique identifier for the article
//     public var id: String
// 
//     /// Relationships to other entities in the system
//     public var relationships: [Relationship] = []
// 
//     /// Title or headline of the article
//     public var title: String
// 
//     /// URL where the article can be accessed
//     public var url: String
// 
//     /// URL to a featured image for the article
//     public var urlToImage: String?
// 
//     /// Additional images associated with the article
//     public var additionalImages: [String]?
// 
//     /// When the article was published
//     public var publishedAt: Date
// 
//     /// The main text content of the article
//     public var textContent: String?
// 
//     /// Author or writer of the article
//     public var author: String?
// 
//     /// Category or section the article belongs to
//     public var category: String?
// 
//     /// URL to a video associated with the article
//     public var videoURL: String?
// 
//     /// Geographic location associated with the article
//     public var location: Location?
// 
//     // MARK: - Initializers
// 
//     /// Creates a new article with the specified properties.
//     public init(
//         id: String = UUID().uuidString,
//         title: String,
//         url: String,
//         urlToImage: String? = nil,
//         additionalImages: [String]? = nil,
//         publishedAt: Date = Date(),
//         textContent: String? = nil,
//         author: String? = nil,
//         category: String? = nil,
//         videoURL: String? = nil,
//         location: Location? = nil,
//         relationships: [Relationship] = []
//     ) {
//         self.id = id
//         self.title = title
//         self.url = url
//         self.urlToImage = urlToImage
//         self.additionalImages = additionalImages
//         self.publishedAt = publishedAt
//         self.textContent = textContent
//         self.author = author
//         self.category = category
//         self.videoURL = videoURL
//         self.location = location
//         self.relationships = relationships
//     }
// 
//     // MARK: - Methods
// 
//     /// Determines the appropriate MediaType for this Article.
//     public func determineMediaType() -> MediaType {
//         return .text
//     }
// 
//     /// Converts this Article to a MediaItem with all relevant properties.
//     public func toMediaItem() -> MediaItem {
//         var mediaItem = MediaItem(
//             id: id,
//             title: title,
//             type: .text,
//             url: url,
//             textContent: textContent,
//             author: author,
//             publishedAt: publishedAt,
//             relationships: relationships
//         )
// 
//         // Add article-specific properties
//         if let category = category {
//             mediaItem.tags = [category]
//         }
// 
//         if let location = location {
//             mediaItem.location = location
//         }
// 
//         return mediaItem
//     }
// 
//     // MARK: - JSON Schema Provider
// 
//     /// Provides the JSON schema for Article.
//     public static var jsonSchema: String {
//         return """
//             {
//                 "type": "object",
//                 "properties": {
//                     "id": {"type": "string"},
//                     "title": {"type": "string"},
//                     "url": {"type": "string"},
//                     "urlToImage": {"type": ["string", "null"]},
//                     "additionalImages": {"type": ["array", "null"], "items": {"type": "string"}},
//                     "publishedAt": {"type": "string", "format": "date-time"},
//                     "textContent": {"type": ["string", "null"]},
//                     "author": {"type": ["string", "null"]},
//                     "category": {"type": ["string", "null"]},
//                     "videoURL": {"type": ["string", "null"]},
//                     "location": {"type": ["object", "null"]}
//                 },
//                 "required": ["id", "title", "url", "publishedAt"]
//             }
//             """
//     }
// }
// 
// /// Extension providing an example Article for previews and testing.
// extension Article {
//     /// An example instance of `Article` for previews and testing.
//     @MainActor public static let example = Article(
//         title: "Utah News App Launches Today: Get the Latest News, Sports, and Weather",
//         url: "https://www.utahnews.com",
//         urlToImage: "https://picsum.photos/800/1200",
//         textContent: """
//             Utah News is a news app for Utah. Get the latest news, sports, and weather from Utah News.
//             Stay informed about local events and stories that matter to you.
//             """,
//         author: "Mark Evans",
//         category: "News"
//     )
// }

// File: AssociatedData.swift
// //
// //  AssociatedData.swift
// //  UtahNewsData
// //
// //  Created by Mark Evans on 11/26/24.
// //
// 
// /*
//  # Entity Model Foundation
// 
//  This file defines the core protocols and relationship model for the UtahNewsData package.
//  It provides the foundation for all entity models and their relationships.
// 
//  ## Key Components:
// 
//  1. BaseEntity Protocol: The foundation protocol for all entities
//  2. AssociatedData Protocol: Extends BaseEntity with relationship capabilities
//  3. Relationship Struct: Defines connections between entities
//  4. RelationshipSource Enum: Tracks the origin of relationship information
//  5. EntityType Enum: Defines all supported entity types
// 
//  ## Usage:
// 
//  All entity models in the system implement at least the BaseEntity protocol,
//  and most implement the AssociatedData protocol for relationship tracking:
// 
//  ```swift
//  // Create a person entity
//  let person = Person(name: "Jane Doe", details: "Reporter")
// 
//  // Create an organization entity
//  let org = Organization(name: "Utah News Network")
// 
//  // Create a relationship from person to organization
//  let relationship = Relationship(
//      id: org.id,
//      type: .organization,
//      displayName: "Works at",
//      context: "Senior reporter since 2020"
//  )
// 
//  // Add the relationship to the person
//  var updatedPerson = person
//  updatedPerson.relationships.append(relationship)
//  ```
//  */
// 
// import Foundation
// import SwiftUI
// 
// /// The foundation protocol for all entities in the system.
// /// Provides consistent identification and naming.
// public protocol BaseEntity: Identifiable, Codable, Hashable {
//     /// Unique identifier for the entity
//     var id: String { get }
// 
//     /// The name or title of the entity, used for display and embedding generation
//     var name: String { get }
// }
// 
// /// The core protocol that all relational entity models in the system implement.
// /// Extends BaseEntity with relationship tracking capabilities.
// public protocol AssociatedData: BaseEntity {
//     /// Array of relationships to other entities
//     var relationships: [Relationship] { get set }
// }
// 
// /// Extension to provide default implementations for AssociatedData
// extension AssociatedData {
//     /// Generates text suitable for creating vector embeddings for RAG systems.
//     /// This text includes the entity's basic information and its relationships.
//     ///
//     /// - Returns: A string representation of the entity for embedding
//     public func toEmbeddingText() -> String {
//         let entityType = String(describing: type(of: self))
//         var text = "This is a \(entityType) with ID \(id) named \(name)."
// 
//         // Add relationship information
//         if !relationships.isEmpty {
//             text += " It has the following relationships: "
//             for relationship in relationships {
//                 text +=
//                     "A relationship of type \(relationship.type.rawValue) with entity ID \(relationship.id)"
//                 if let displayName = relationship.displayName {
//                     text += " (\(displayName))"
//                 }
//                 if let context = relationship.context {
//                     text += ". \(context)"
//                 }
//                 text += ". "
//             }
//         }
// 
//         return text
//     }
// }
// 
// /// Represents a relationship between two entities in the system.
// /// Relationships are directional but typically created in pairs to represent bidirectional connections.
// public struct Relationship: BaseEntity, Codable, Hashable, Sendable {
//     /// Unique identifier for the relationship
//     public var id: String = UUID().uuidString
// 
//     /// The name or description of this relationship
//     public var name: String {
//         return displayName ?? "Relationship to \(type.rawValue) \(id)"
//     }
// 
//     /// Unique identifier of the target entity
//     public let targetId: String
// 
//     /// Type of the target entity
//     public let type: EntityType
// 
//     /// Optional display name for the relationship (e.g., "Works at", "Located in")
//     public var displayName: String?
// 
//     /// When the relationship was created
//     public let createdAt: Date
// 
//     /// Optional additional context about the relationship
//     public var context: String?
// 
//     /// Creates a new relationship between entities.
//     ///
//     /// - Parameters:
//     ///   - id: Unique identifier of the target entity
//     ///   - type: Type of the target entity
//     ///   - displayName: Optional display name for the relationship
//     ///   - context: Optional additional context about the relationship
//     public init(id: String, type: EntityType, displayName: String? = nil, context: String? = nil) {
//         self.targetId = id
//         self.type = type
//         self.displayName = displayName
//         self.context = context
//         self.createdAt = Date()
//     }
// }
// 
// /// Source of relationship information
// /// Tracks where relationship data originated from
// public enum RelationshipSource: String, Codable {
//     /// Created by the system automatically
//     case system = "system"
// 
//     /// Entered by a human user
//     case userInput = "user_input"
// 
//     /// Inferred by an AI system
//     case aiInference = "ai_inference"
// 
//     /// Imported from an external data source
//     case dataImport = "data_import"
// }
// 
// /// Defines all entity types supported in the system
// /// Used to categorize entities and their relationships
// public enum EntityType: String, Codable, Sendable {
//     case person = "persons"
//     case organization = "organizations"
//     case location = "locations"
//     case category = "categories"
//     case source = "sources"
//     case mediaItem = "mediaItems"
//     case newsEvent = "newsEvents"
//     case newsStory = "newsStories"
//     case quote = "quotes"
//     case fact = "facts"
//     case statisticalData = "statisticalData"
//     case calendarEvent = "calendarEvents"
//     case legalDocument = "legalDocuments"
//     case socialMediaPost = "socialMediaPosts"
//     case expertAnalysis = "expertAnalyses"
//     case poll = "polls"
//     case alert = "alerts"
//     case jurisdiction = "jurisdictions"
//     case userSubmission = "userSubmissions"
//     // Add other types as needed
// 
//     /// Returns the singular name of this entity type
//     /// Useful for display and text generation
//     public var singularName: String {
//         switch self {
//         case .person: return "person"
//         case .organization: return "organization"
//         case .location: return "location"
//         case .category: return "category"
//         case .source: return "source"
//         case .mediaItem: return "media item"
//         case .newsEvent: return "news event"
//         case .newsStory: return "news story"
//         case .quote: return "quote"
//         case .fact: return "fact"
//         case .statisticalData: return "statistical data"
//         case .calendarEvent: return "calendar event"
//         case .legalDocument: return "legal document"
//         case .socialMediaPost: return "social media post"
//         case .expertAnalysis: return "expert analysis"
//         case .poll: return "poll"
//         case .alert: return "alert"
//         case .jurisdiction: return "jurisdiction"
//         case .userSubmission: return "user submission"
//         }
//     }
// }
// 
// // For backward compatibility
// public typealias AssociatedDataType = EntityType

// File: Audio.swift
// //
// //  Audio.swift
// //  UtahNewsData
// //
// //  Created by Mark Evans on 11/18/24.
// //
// //  Summary: Defines the Audio model which represents audio content in the UtahNewsData system.
// //           Now conforms to JSONSchemaProvider to provide a static JSON schema for LLM responses.
// //           (Changes: Added JSONSchemaProvider conformance and static jsonSchema property.)
// 
// import Foundation
// 
// // Updated to conform to JSONSchemaProvider and Sendable
// public struct Audio: NewsContent, BaseEntity, JSONSchemaProvider, Sendable {
//     /// Unique identifier for the audio clip
//     public var id: String
// 
//     /// The name of the entity (derived from the title)
//     public var name: String { title }
// 
//     /// Title or name of the audio clip
//     public var title: String
// 
//     /// URL where the audio can be accessed
//     public var url: String
// 
//     /// URL to an image representing the audio (e.g., podcast cover art)
//     public var urlToImage: String?
// 
//     /// When the audio was published
//     public var publishedAt: Date
// 
//     /// Description or transcript of the audio
//     public var textContent: String?
// 
//     /// Creator or producer of the audio
//     public var author: String?
// 
//     /// Length of the audio in seconds
//     public var duration: TimeInterval
// 
//     /// Audio quality in kilobits per second (kbps)
//     public var bitrate: Int
// 
//     /// Creates a new audio clip with the specified properties.
//     ///
//     /// - Parameters:
//     ///   - id: Unique identifier for the audio clip (defaults to a new UUID string)
//     ///   - title: Title or name of the audio clip
//     ///   - url: URL where the audio can be accessed
//     ///   - urlToImage: URL to an image representing the audio (defaults to a placeholder)
//     ///   - publishedAt: When the audio was published (defaults to current date)
//     ///   - textContent: Description or transcript of the audio
//     ///   - author: Creator or producer of the audio
//     ///   - duration: Length of the audio in seconds
//     ///   - bitrate: Audio quality in kilobits per second (kbps)
//     public init(
//         id: String = UUID().uuidString,
//         title: String,
//         url: String,
//         urlToImage: String? = "https://picsum.photos/800/1200",
//         publishedAt: Date = Date(),
//         textContent: String? = nil,
//         author: String? = nil,
//         duration: TimeInterval,
//         bitrate: Int
//     ) {
//         self.id = id
//         self.title = title
//         self.url = url
//         self.urlToImage = urlToImage
//         self.publishedAt = publishedAt
//         self.textContent = textContent
//         self.author = author
//         self.duration = duration
//         self.bitrate = bitrate
//     }
// 
//     /// Returns a formatted duration string in minutes and seconds.
//     ///
//     /// - Returns: A string in the format "MM:SS"
//     public func formattedDuration() -> String {
//         let minutes = Int(duration) / 60
//         let seconds = Int(duration) % 60
//         return String(format: "%d:%02d", minutes, seconds)
//     }
// 
//     /// Returns a formatted bitrate string.
//     ///
//     /// - Returns: A string in the format "X kbps"
//     public func formattedBitrate() -> String {
//         return "\(bitrate) kbps"
//     }
// 
//     // MARK: - JSON Schema Provider
//     // Provides the JSON schema for Audio.
//     public static var jsonSchema: String {
//         return """
//             {
//                 "type": "object",
//                 "properties": {
//                     "id": {"type": "string"},
//                     "title": {"type": "string"},
//                     "url": {"type": "string"},
//                     "urlToImage": {"type": ["string", "null"]},
//                     "publishedAt": {"type": "string", "format": "date-time"},
//                     "textContent": {"type": ["string", "null"]},
//                     "author": {"type": ["string", "null"]},
//                     "duration": {"type": "number"},
//                     "bitrate": {"type": "integer"}
//                 },
//                 "required": ["id", "title", "url", "publishedAt", "duration", "bitrate"]
//             }
//             """
//     }
// }
// 
// extension Audio {
//     /// An example instance of `Audio` for previews and testing.
//     @MainActor public static let example = Audio(
//         title: "Utah News Podcast Episode 1",
//         url: "https://www.utahnews.com/podcast-episode-1",
//         urlToImage: "https://picsum.photos/800/600",
//         textContent: "Listen to the first episode of the Utah News podcast.",
//         author: "Mark Evans",
//         duration: 1800,  // Duration in seconds
//         bitrate: 256  // Bitrate in kbps
//     )
// }

// File: CalEvent.swift
// //
// //  CalEvent.swift
// //  UtahNewsData
// //
// //  Created by Mark Evans on 2/12/25.
// //
// 
// /*
//  # CalEvent Model
// 
//  This file defines the CalEvent model, which represents calendar events
//  in the UtahNewsData system. CalEvents can be used to track scheduled events
//  such as press conferences, meetings, hearings, and other time-based occurrences
//  relevant to news coverage.
// 
//  ## Key Features:
// 
//  1. Core event information (title, description, date/time range)
//  2. Location data
//  3. Organizer and attendee information
//  4. Recurrence rules
//  5. Related entities
// 
//  ## Usage:
// 
//  ```swift
//  // Create a basic calendar event
//  let basicEvent = CalEvent(
//      title: "City Council Meeting",
//      startDate: Date(), // March 15, 2023, 19:00
//      endDate: Date().addingTimeInterval(7200) // 2 hours later
//  )
// 
//  // Create a detailed calendar event
//  let detailedEvent = CalEvent(
//      title: "Public Hearing on Downtown Development",
//      description: "Public hearing to discuss proposed downtown development project",
//      startDate: Date(), // April 10, 2023, 18:30
//      endDate: Date().addingTimeInterval(5400), // 1.5 hours later
//      location: cityHall, // Location entity
//      organizer: planningDepartment, // Organization entity
//      attendees: [mayorOffice, developerCorp, communityCouncil], // Organization entities
//      isPublic: true,
//      url: "https://example.gov/hearings/downtown-dev",
//      recurrenceRule: nil, // One-time event
//      relatedEntities: [downtownProject] // Other entities
//  )
// 
//  // Access event information
//  let eventTitle = detailedEvent.title
//  let eventDuration = Calendar.current.dateComponents([.minute], from: detailedEvent.startDate, to: detailedEvent.endDate).minute
// 
//  // Generate context for RAG
//  let context = detailedEvent.generateContext()
//  ```
// 
//  The CalEvent model implements EntityDetailsProvider, allowing it to generate
//  rich text descriptions for RAG (Retrieval Augmented Generation) systems.
//  */
// 
// import Foundation
// 
// /// Represents a recurrence rule for repeating calendar events
// public struct RecurrenceRule: BaseEntity, Codable, Hashable, Equatable, Sendable {
//     /// Unique identifier for the recurrence rule
//     public var id: String
// 
//     /// The name or description of this recurrence rule
//     public var name: String
// 
//     /// Frequency of recurrence (daily, weekly, monthly, yearly)
//     public var frequency: String
// 
//     /// Interval between occurrences (e.g., every 2 weeks)
//     public var interval: Int
// 
//     /// When the recurrence ends (specific date or after a number of occurrences)
//     public var endDate: Date?
// 
//     /// Number of occurrences after which the recurrence ends
//     public var occurrences: Int?
// 
//     /// Days of the week when the event occurs (for weekly recurrence)
//     public var daysOfWeek: [Int]?
// 
//     /// Creates a new RecurrenceRule with the specified properties.
//     ///
//     /// - Parameters:
//     ///   - id: Unique identifier for the recurrence rule (defaults to a new UUID string)
//     ///   - name: The name or description of this recurrence rule
//     ///   - frequency: Frequency of recurrence (daily, weekly, monthly, yearly)
//     ///   - interval: Interval between occurrences (e.g., every 2 weeks)
//     ///   - endDate: When the recurrence ends (specific date)
//     ///   - occurrences: Number of occurrences after which the recurrence ends
//     ///   - daysOfWeek: Days of the week when the event occurs (for weekly recurrence)
//     public init(
//         id: String = UUID().uuidString,
//         name: String? = nil,
//         frequency: String,
//         interval: Int = 1,
//         endDate: Date? = nil,
//         occurrences: Int? = nil,
//         daysOfWeek: [Int]? = nil
//     ) {
//         self.id = id
//         self.name = name ?? "\(frequency) (every \(interval))"
//         self.frequency = frequency
//         self.interval = interval
//         self.endDate = endDate
//         self.occurrences = occurrences
//         self.daysOfWeek = daysOfWeek
//     }
// }
// 
// /// Represents a calendar event in the UtahNewsData system.
// /// CalEvents can be used to track scheduled events such as press conferences,
// /// meetings, hearings, and other time-based occurrences relevant to news coverage.
// public struct CalEvent: AssociatedData, EntityDetailsProvider, JSONSchemaProvider, BaseEntity,
//     Sendable
// {
//     /// Unique identifier for the calendar event
//     public var id: String = UUID().uuidString
// 
//     /// The name of the entity (required by BaseEntity)
//     public var name: String { title }
// 
//     /// Relationships to other entities in the system
//     public var relationships: [Relationship] = []
// 
//     /// The title of the event
//     public var title: String
// 
//     /// Detailed description of the event
//     public var description: String?
// 
//     /// When the event begins
//     public var startDate: Date
// 
//     /// When the event ends
//     public var endDate: Date
// 
//     /// Where the event takes place
//     public var location: Location?
// 
//     /// Person or organization organizing the event
//     public var organizer: (any EntityDetailsProvider)?
// 
//     /// People or organizations attending the event
//     public var attendees: [any EntityDetailsProvider]?
// 
//     /// Whether the event is open to the public
//     public var isPublic: Bool?
// 
//     /// URL with more information about the event
//     public var url: String?
// 
//     /// Rule for recurring events
//     public var recurrenceRule: RecurrenceRule?
// 
//     /// Entities related to this event
//     public var relatedEntities: [any EntityDetailsProvider]?
// 
//     /// Creates a new CalEvent with the specified properties.
//     ///
//     /// - Parameters:
//     ///   - title: The title of the event
//     ///   - description: Detailed description of the event
//     ///   - startDate: When the event begins
//     ///   - endDate: When the event ends
//     ///   - location: Where the event takes place
//     ///   - organizer: Person or organization organizing the event
//     ///   - attendees: People or organizations attending the event
//     ///   - isPublic: Whether the event is open to the public
//     ///   - url: URL with more information about the event
//     ///   - recurrenceRule: Rule for recurring events
//     ///   - relatedEntities: Entities related to this event
//     public init(
//         title: String,
//         description: String? = nil,
//         startDate: Date,
//         endDate: Date,
//         location: Location? = nil,
//         organizer: (any EntityDetailsProvider)? = nil,
//         attendees: [any EntityDetailsProvider]? = nil,
//         isPublic: Bool? = nil,
//         url: String? = nil,
//         recurrenceRule: RecurrenceRule? = nil,
//         relatedEntities: [any EntityDetailsProvider]? = nil
//     ) {
//         self.title = title
//         self.description = description
//         self.startDate = startDate
//         self.endDate = endDate
//         self.location = location
//         self.organizer = organizer
//         self.attendees = attendees
//         self.isPublic = isPublic
//         self.url = url
//         self.recurrenceRule = recurrenceRule
//         self.relatedEntities = relatedEntities
//     }
// 
//     // Implement Equatable manually since we have properties that don't conform to Equatable
//     public static func == (lhs: CalEvent, rhs: CalEvent) -> Bool {
//         return lhs.id == rhs.id && lhs.title == rhs.title && lhs.startDate == rhs.startDate
//             && lhs.endDate == rhs.endDate
//     }
// 
//     // Implement Hashable manually
//     public func hash(into hasher: inout Hasher) {
//         hasher.combine(id)
//         hasher.combine(title)
//         hasher.combine(startDate)
//         hasher.combine(endDate)
//     }
// 
//     // Implement Codable manually
//     public init(from decoder: Decoder) throws {
//         let container = try decoder.container(keyedBy: CodingKeys.self)
// 
//         id = try container.decode(String.self, forKey: .id)
//         title = try container.decode(String.self, forKey: .title)
//         description = try container.decodeIfPresent(String.self, forKey: .description)
//         startDate = try container.decode(Date.self, forKey: .startDate)
//         endDate = try container.decode(Date.self, forKey: .endDate)
//         location = try container.decodeIfPresent(Location.self, forKey: .location)
//         isPublic = try container.decodeIfPresent(Bool.self, forKey: .isPublic)
//         url = try container.decodeIfPresent(String.self, forKey: .url)
//         recurrenceRule = try container.decodeIfPresent(RecurrenceRule.self, forKey: .recurrenceRule)
//         relationships =
//             try container.decodeIfPresent([Relationship].self, forKey: .relationships) ?? []
// 
//         // Skip decoding organizer, attendees, and relatedEntities as they use protocol types
//         organizer = nil
//         attendees = nil
//         relatedEntities = nil
//     }
// 
//     public func encode(to encoder: Encoder) throws {
//         var container = encoder.container(keyedBy: CodingKeys.self)
// 
//         try container.encode(id, forKey: .id)
//         try container.encode(title, forKey: .title)
//         try container.encodeIfPresent(description, forKey: .description)
//         try container.encode(startDate, forKey: .startDate)
//         try container.encode(endDate, forKey: .endDate)
//         try container.encodeIfPresent(location, forKey: .location)
//         try container.encodeIfPresent(isPublic, forKey: .isPublic)
//         try container.encodeIfPresent(url, forKey: .url)
//         try container.encodeIfPresent(recurrenceRule, forKey: .recurrenceRule)
//         try container.encode(relationships, forKey: .relationships)
// 
//         // Skip encoding organizer, attendees, and relatedEntities as they use protocol types
//     }
// 
//     private enum CodingKeys: String, CodingKey {
//         case id, title, description, startDate, endDate, location, isPublic, url, recurrenceRule,
//             relationships
//     }
// 
//     /// Generates a detailed text description of the calendar event for use in RAG systems.
//     /// The description includes the title, date/time, location, and other event details.
//     ///
//     /// - Returns: A formatted string containing the calendar event's details
//     public func getDetailedDescription() -> String {
//         var description = "CALENDAR EVENT: \(title)"
// 
//         if let eventDescription = self.description {
//             description += "\nDescription: \(eventDescription)"
//         }
// 
//         let dateFormatter = DateFormatter()
//         dateFormatter.dateStyle = .medium
//         dateFormatter.timeStyle = .short
// 
//         description += "\nStart: \(dateFormatter.string(from: startDate))"
//         description += "\nEnd: \(dateFormatter.string(from: endDate))"
// 
//         if let location = location {
//             description += "\nLocation: \(location.name)"
//             if let address = location.address {
//                 description += " (\(address))"
//             }
//         }
// 
//         if let organizer = organizer {
//             if let person = organizer as? Person {
//                 description += "\nOrganizer: \(person.name)"
//             } else if let organization = organizer as? Organization {
//                 description += "\nOrganizer: \(organization.name)"
//             }
//         }
// 
//         if let attendees = attendees, !attendees.isEmpty {
//             description += "\nAttendees:"
//             for attendee in attendees {
//                 if let person = attendee as? Person {
//                     description += "\n- \(person.name)"
//                 } else if let organization = attendee as? Organization {
//                     description += "\n- \(organization.name)"
//                 }
//             }
//         }
// 
//         if let isPublic = isPublic {
//             description += "\nPublic Event: \(isPublic ? "Yes" : "No")"
//         }
// 
//         if let url = url {
//             description += "\nMore Information: \(url)"
//         }
// 
//         if let recurrenceRule = recurrenceRule {
//             description +=
//                 "\nRecurrence: Every \(recurrenceRule.interval) \(recurrenceRule.frequency)"
//             if let occurrences = recurrenceRule.occurrences {
//                 description += " for \(occurrences) occurrences"
//             } else if let endDate = recurrenceRule.endDate {
//                 let formatter = DateFormatter()
//                 formatter.dateStyle = .medium
//                 formatter.timeStyle = .none
//                 description += " until \(formatter.string(from: endDate))"
//             }
//         }
// 
//         return description
//     }
// 
//     /// JSON schema for LLM responses
//     public static var jsonSchema: String {
//         """
//         {
//             "type": "object",
//             "properties": {
//                 "id": {"type": "string"},
//                 "title": {"type": "string"},
//                 "description": {"type": "string", "optional": true},
//                 "startDate": {"type": "string", "format": "date-time"},
//                 "endDate": {"type": "string", "format": "date-time"},
//                 "location": {"$ref": "#/definitions/Location", "optional": true},
//                 "organizer": {"$ref": "#/definitions/Organization", "optional": true},
//                 "attendees": {
//                     "type": "array",
//                     "items": {
//                         "oneOf": [
//                             {"$ref": "#/definitions/Organization"},
//                             {"$ref": "#/definitions/Person"}
//                         ]
//                     },
//                     "optional": true
//                 },
//                 "isPublic": {"type": "boolean", "optional": true},
//                 "url": {"type": "string", "format": "uri", "optional": true},
//                 "recurrenceRule": {
//                     "type": "object",
//                     "properties": {
//                         "id": {"type": "string"},
//                         "name": {"type": "string"},
//                         "frequency": {"type": "string", "enum": ["daily", "weekly", "monthly", "yearly"]},
//                         "interval": {"type": "integer", "minimum": 1},
//                         "endDate": {"type": "string", "format": "date-time", "optional": true},
//                         "count": {"type": "integer", "minimum": 1, "optional": true}
//                     },
//                     "required": ["id", "name", "frequency", "interval"],
//                     "optional": true
//                 },
//                 "status": {"type": "string", "enum": ["scheduled", "cancelled", "postponed", "completed"], "optional": true},
//                 "tags": {
//                     "type": "array",
//                     "items": {"type": "string"},
//                     "optional": true
//                 }
//             },
//             "required": ["id", "title", "startDate", "endDate"],
//             "definitions": {
//                 "Location": {"$ref": "Location.jsonSchema"},
//                 "Organization": {"$ref": "Organization.jsonSchema"},
//                 "Person": {"$ref": "Person.jsonSchema"}
//             }
//         }
//         """
//     }
// }

// File: Category.swift
// //
// //  Category.swift
// //  UtahNewsData
// //
// //  Created by Mark Evans on 2/12/25.
// //
// 
// /*
//  # Category Model
// 
//  This file defines the Category model, which represents content categories in the UtahNewsData system.
//  Categories provide a way to organize and classify content such as articles, media items, and other
//  news-related entities.
// 
//  ## Key Features:
// 
//  1. Core identification (id, name)
//  2. Hierarchical structure (parent category, subcategories)
//  3. Descriptive information
// 
//  ## Usage:
// 
//  ```swift
//  // Create a parent category
//  let newsCategory = Category(
//      name: "News",
//      description: "General news content"
//  )
// 
//  // Create subcategories
//  let politicsCategory = Category(
//      name: "Politics",
//      description: "Political news and analysis",
//      parentCategory: newsCategory
//  )
// 
//  let localPoliticsCategory = Category(
//      name: "Local Politics",
//      description: "Utah state and local political news",
//      parentCategory: politicsCategory
//  )
// 
//  // Add subcategories to parent
//  newsCategory.subcategories = [politicsCategory]
//  politicsCategory.subcategories = [localPoliticsCategory]
// 
//  // Use with an Article
//  let article = Article(
//      title: "Utah Legislature Passes New Bill",
//      body: ["The Utah State Legislature passed a new bill today..."],
//      categories: [localPoliticsCategory]
//  )
//  ```
// 
//  The Category model implements EntityDetailsProvider, allowing it to generate
//  rich text descriptions for RAG (Retrieval Augmented Generation) systems.
//  */
// 
// import Foundation
// 
// /// Represents a content category in the UtahNewsData system.
// /// Categories provide a way to organize and classify content such as articles,
// /// media items, and other news-related entities.
// public struct Category: AssociatedData, EntityDetailsProvider, BaseEntity, JSONSchemaProvider,
//     Sendable
// {
//     /// Unique identifier for the category
//     public var id: String = UUID().uuidString
// 
//     /// Relationships to other entities in the system
//     public var relationships: [Relationship] = []
// 
//     /// The name of the category
//     public var name: String
// 
//     /// Detailed description of what the category encompasses
//     public var description: String?
// 
//     /// Parent category reference (using id instead of direct reference)
//     public var parentCategoryId: String?
// 
//     /// Child category references (using ids instead of direct references)
//     public var subcategoryIds: [String]?
// 
//     /// Creates a new Category with the specified properties.
//     ///
//     /// - Parameters:
//     ///   - name: The name of the category
//     ///   - description: Detailed description of what the category encompasses
//     ///   - parentCategoryId: ID of parent category if this is a subcategory
//     ///   - subcategoryIds: IDs of child categories if this category has subcategories
//     public init(
//         name: String,
//         description: String? = nil,
//         parentCategoryId: String? = nil,
//         subcategoryIds: [String]? = nil
//     ) {
//         self.name = name
//         self.description = description
//         self.parentCategoryId = parentCategoryId
//         self.subcategoryIds = subcategoryIds
//     }
// 
//     /// Convenience initializer that takes Category instances for parent and subcategories
//     ///
//     /// - Parameters:
//     ///   - name: The name of the category
//     ///   - description: Detailed description of what the category encompasses
//     ///   - parentCategory: Parent category if this is a subcategory
//     ///   - subcategories: Child categories if this category has subcategories
//     public init(
//         name: String,
//         description: String? = nil,
//         parentCategory: Category? = nil,
//         subcategories: [Category]? = nil
//     ) {
//         self.name = name
//         self.description = description
//         self.parentCategoryId = parentCategory?.id
//         self.subcategoryIds = subcategories?.map { $0.id }
//     }
// 
//     /// Generates a detailed text description of the category for use in RAG systems.
//     /// The description includes the category name, description, and hierarchical information.
//     ///
//     /// - Returns: A formatted string containing the category's details
//     public func getDetailedDescription() -> String {
//         var description = "CATEGORY: \(name)"
// 
//         if let categoryDescription = self.description {
//             description += "\nDescription: \(categoryDescription)"
//         }
// 
//         if let parentCategoryId = parentCategoryId {
//             description += "\nParent Category ID: \(parentCategoryId)"
//         }
// 
//         if let subcategoryIds = subcategoryIds, !subcategoryIds.isEmpty {
//             description += "\nSubcategory IDs: \(subcategoryIds.joined(separator: ", "))"
//         }
// 
//         return description
//     }
// 
//     /// JSON schema for LLM responses
//     public static var jsonSchema: String {
//         """
//         {
//             "type": "object",
//             "properties": {
//                 "id": {"type": "string"},
//                 "name": {"type": "string"},
//                 "description": {"type": "string", "optional": true},
//                 "parentCategory": {
//                     "$ref": "#/definitions/Category",
//                     "optional": true
//                 },
//                 "subcategories": {
//                     "type": "array",
//                     "items": {"$ref": "#/definitions/Category"},
//                     "optional": true
//                 },
//                 "metadata": {
//                     "type": "object",
//                     "additionalProperties": true,
//                     "optional": true
//                 }
//             },
//             "required": ["id", "name"],
//             "definitions": {
//                 "Category": {
//                     "type": "object",
//                     "properties": {
//                         "id": {"type": "string"},
//                         "name": {"type": "string"}
//                     },
//                     "required": ["id", "name"]
//                 }
//             }
//         }
//         """
//     }
// }

// File: ExpertAnalysis.swift
// //
// //  ExpertAnalysis.swift
// //  NewsCapture
// //
// //  Created by Mark Evans on 10/25/24.
// //
// //  Summary: Defines the ExpertAnalysis model which represents expert opinions,
// //           analyses, and commentary in the UtahNewsData system. Now conforms to JSONSchemaProvider
// //           to provide a static JSON schema for LLM responses.
// 
// import Foundation
// import SwiftUI
// 
// /// Represents an expert's analysis or commentary on a topic or news event.
// /// Expert analyses provide authoritative perspectives from qualified individuals.
// public struct ExpertAnalysis: AssociatedData, Codable, JSONSchemaProvider, Sendable {
//     /// Unique identifier for the expert analysis
//     public var id: String
// 
//     /// Relationships to other entities in the system
//     public var relationships: [Relationship] = []
// 
//     /// The expert providing the analysis
//     public var expert: Person
// 
//     /// When the analysis was provided
//     public var date: Date
// 
//     /// Categories or topics covered in the analysis
//     public var topics: [Category] = []
// 
//     /// Professional credentials of the expert relevant to this analysis
//     public var credentials: [Credential] = []
// 
//     /// The name property required by the AssociatedData protocol.
//     /// Returns a descriptive name based on the expert and date.
//     public var name: String {
//         let formatter = DateFormatter()
//         formatter.dateStyle = .medium
//         return "Analysis by \(expert.name) on \(formatter.string(from: date))"
//     }
// 
//     /// Creates a new expert analysis with the specified properties.
//     ///
//     /// - Parameters:
//     ///   - id: Unique identifier for the analysis (defaults to a new UUID string)
//     ///   - expert: The expert providing the analysis
//     ///   - date: When the analysis was provided
//     public init(id: String = UUID().uuidString, expert: Person, date: Date) {
//         self.id = id
//         self.expert = expert
//         self.date = date
//     }
// 
//     // MARK: - JSON Schema Provider
//     /// Provides the JSON schema for ExpertAnalysis.
//     public static var jsonSchema: String {
//         return """
//             {
//                 "type": "object",
//                 "properties": {
//                     "id": {"type": "string"},
//                     "relationships": {
//                         "type": "array",
//                         "items": {"type": "object"}
//                     },
//                     "expert": {"type": "object"},
//                     "date": {"type": "string", "format": "date-time"},
//                     "topics": {
//                         "type": "array",
//                         "items": {"type": "object"}
//                     },
//                     "credentials": {
//                         "type": "array",
//                         "items": {"type": "string"}
//                     }
//                 },
//                 "required": ["id", "expert", "date"]
//             }
//             """
//     }
// }
// 
// /// Represents professional credentials, degrees, and certifications.
// /// Used to establish the qualifications and expertise of individuals
// /// providing expert analysis.
// public enum Credential: String, Codable, Sendable {
//     // Academic Degrees
//     case PhD = "Doctor of Philosophy"
//     case MD = "Doctor of Medicine"
//     case JD = "Juris Doctor"
//     case DDS = "Doctor of Dental Surgery"
//     case DVM = "Doctor of Veterinary Medicine"
//     case MS = "Master of Science"
//     case MA = "Master of Arts"
//     case MBA = "Master of Business Administration"
//     case BS = "Bachelor of Science"
//     case BA = "Bachelor of Arts"
//     case BBA = "Bachelor of Business Administration"
//     case BEng = "Bachelor of Engineering"
//     case BFA = "Bachelor of Fine Arts"
//     case BCom = "Bachelor of Commerce"
//     case BArch = "Bachelor of Architecture"
//     case BBA_Marketing = "Bachelor of Business Administration in Marketing"
//     case BBA_Finance = "Bachelor of Business Administration in Finance"
// 
//     // Professional Certifications
//     case CPA = "Certified Public Accountant"
//     case CFA = "Chartered Financial Analyst"
//     case PMP = "Project Management Professional"
//     case CISM = "Certified Information Security Manager"
//     case CISSP = "Certified Information Systems Security Professional"
//     case CISA = "Certified Information Systems Auditor"
//     case CCSP = "Certified Cloud Security Professional"
//     case CEH = "Certified Ethical Hacker"
//     case CCNA = "Cisco Certified Network Associate"
//     case CCNP = "Cisco Certified Network Professional"
//     case AWS_SA = "AWS Certified Solutions Architect"
//     case AWS_DevOps = "AWS Certified DevOps Engineer"
//     case GCA = "Google Cloud Professional Cloud Architect"
//     case AZ_Admin = "Microsoft Certified: Azure Administrator Associate"
//     case ITIL = "Information Technology Infrastructure Library"
//     case SHRM_CP = "Society for Human Resource Management Certified Professional"
//     case SHRM_SCP = "Society for Human Resource Management Senior Certified Professional"
//     case LSSBB = "Lean Six Sigma Black Belt"
//     case LSSGB = "Lean Six Sigma Green Belt"
//     case PRINCE2 = "PRINCE2 Practitioner"
//     case TOGAF = "The Open Group Architecture Framework"
// 
//     // Scrum Certifications
//     case CSM = "Certified ScrumMaster (CSM)"
//     case CSPO = "Certified Scrum Product Owner"
// 
//     // Information Technology
//     case CompTIA_A = "CompTIA A+"
//     case CompTIA_Network = "CompTIA Network+"
//     case CompTIA_Security = "CompTIA Security+"
//     case CCIE = "Cisco Certified Internetwork Expert"
//     case Microsoft_Solutions_Expert = "Microsoft Certified: Solutions Expert"
//     case Oracle_Professional = "Oracle Certified Professional"
//     case RHCE = "Red Hat Certified Engineer"
//     case CKA = "Certified Kubernetes Administrator"
//     case CAI_E = "Certified Artificial Intelligence Engineer"
//     case CDS = "Certified Data Scientist"
//     case CMLP = "Certified Machine Learning Professional"
//     case CBlockchain_Dev = "Certified Blockchain Developer"
//     case CVirtualization_Prof = "Certified Virtualization Professional"
//     case CIoT_Specialist = "Certified Internet of Things Specialist"
// 
//     // Healthcare Certifications
//     case RN = "Registered Nurse"
//     case NP = "Nurse Practitioner"
//     case CRNA = "Certified Registered Nurse Anesthetist"
//     case DNP = "Doctor of Nursing Practice"
//     case CPHQ = "Certified Professional in Healthcare Quality"
//     case CHC = "Certified in Healthcare Compliance"
//     case CPM = "Certified Project Manager"
//     case CCC = "Certificate of Clinical Competence"
// 
//     // Finance and Accounting
//     case CPA_CGMA = "Certified Public Accountant - Chartered Global Management Accountant"
//     case CFE = "Certified Fraud Examiner"
//     case CMA = "Certified Management Accountant"
//     case CFP = "Certified Financial Planner"
//     case FRM = "Financial Risk Manager"
//     case CAIA = "Chartered Alternative Investment Analyst"
//     case CFA_I = "Chartered Financial Analyst Level I"
//     case CFA_II = "Chartered Financial Analyst Level II"
//     case CFA_III = "Chartered Financial Analyst Level III"
// 
//     // Marketing and Sales
//     case CMO = "Chief Marketing Officer Certification"
//     case CSMM = "Certified Social Media Marketing"
//     case CSEO = "Certified SEO Professional"
//     case CPPM = "Certified Product Marketing Manager"
//     case CPIM = "Certified Product Information Manager"
//     case CSEM = "Certified Sales and Marketing Professional"
// 
//     // Human Resources
//     case PHR = "Professional in Human Resources"
//     case SPHR = "Senior Professional in Human Resources"
//     case GPHR = "Global Professional in Human Resources"
//     case aPHR = "Associate Professional in Human Resources"
// 
//     // Legal Certifications
//     case LLM = "Master of Law"
//     case BCL = "Bachelor of Civil Law"
//     case JD_Specialization = "Juris Doctor - Specialization"
// 
//     // Engineering Certifications
//     case PE = "Professional Engineer"
//     case CEng = "Chartered Engineer"
//     case CPEng = "Certified Professional Engineer"
// 
//     // Additional Certifications
//     case CMC = "Certified Management Consultant"
//     case ASQ_CQE = "Certified Quality Engineer"
//     case CSD = "Chartered Scientist"
//     case MRICS = "Member of the Royal Institution of Chartered Surveyors"
//     case IFSP = "International Fire Safety Professional"
//     case CFRE = "Certified Fund Raising Executive"
//     case CTP = "Certified Treasury Professional"
//     case APICS = "Certified in Planning and Inventory Management"
//     case CCEP = "Certified Compliance and Ethics Professional"
//     case CPP = "Certified Protection Professional"
//     case AICPA = "American Institute of Certified Public Accountants"
// 
//     // Emerging and Specialized Fields
//     case CDMP = "Certified Digital Marketing Professional"
//     case CSM_Manager = "Certified Social Media Manager"
//     case CCM = "Certified Content Marketer"
//     case CPP_Specialist = "Certified Pay-Per-Click Specialist"
//     case CEMP = "Certified Email Marketing Specialist"
//     case CGAS = "Certified Google Ads Specialist"
//     case CFAS = "Certified Facebook Ads Specialist"
//     case CTAS = "Certified Twitter Ads Specialist"
//     case CLAS = "Certified LinkedIn Ads Specialist"
//     case CIM_Specialist = "Certified Instagram Marketing Specialist"
//     case CYM_Specialist = "Certified YouTube Marketing Specialist"
//     case CTM_Specialist = "Certified TikTok Marketing Specialist"
//     case CSL_Admin = "Certified Slack Administrator"
//     case CZoom_Admin = "Certified Zoom Administrator"
//     case CMC365_Admin = "Certified Microsoft 365 Administrator"
//     case CGWS_Admin = "Certified Google Workspace Administrator"
//     case CAWS_Admin = "Certified Amazon Web Services Administrator"
//     case CIBM_Cloud_Prof = "Certified IBM Cloud Professional"
//     case CSAP_HANA_Prof = "Certified SAP HANA Professional"
// 
//     // Research and Academia
//     case CRA = "Clinical Research Associate"
//     case CCRA = "Certified Clinical Research Associate"
//     case CAPM = "Certified Associate in Project Management"
//     case PgMP = "Program Management Professional"
// 
//     // Miscellaneous
//     case CLC = "Certified Life Coach"
//     case CLU = "Chartered Life Underwriter"
//     case CHRL = "Certified Human Resources Leader"
//     case SANS = "Security Awareness Training"
//     case DPO = "Data Protection Officer"
// }

// File: Extensions.swift
// //
// //  Extensions.swift
// //  UtahNewsData
// //
// //  Created by Mark Evans on 11/26/24.
// //
// 
// /*
//  # Extensions
//  
//  This file contains extensions to standard Swift types that provide additional
//  functionality specific to the UtahNewsData system. These extensions enhance
//  the capabilities of built-in types to better support the needs of news data
//  processing and management.
//  
//  ## Key Extensions:
//  
//  1. String Extensions:
//     - URL construction and validation
//     - Text processing utilities
//  
//  ## Usage:
//  
//  ```swift
//  // Using the constructValidURL extension
//  let relativeURL = "articles/utah-economy.html"
//  let baseURL = "https://www.utahnews.com"
//  
//  if let fullURL = relativeURL.constructValidURL(baseURL: baseURL) {
//      // Use the fully qualified URL: "https://www.utahnews.com/articles/utah-economy.html"
//      fetchArticle(from: fullURL)
//  } else {
//      // Handle invalid URL
//      print("Could not construct a valid URL")
//  }
//  ```
//  
//  These extensions are designed to simplify common operations in the UtahNewsData
//  system and provide consistent behavior across the codebase.
//  */
// 
// import Foundation
// 
// /// Extensions to the String type for URL handling and text processing.
// extension String {
//     /// Constructs a fully qualified URL using the base URL if needed.
//     /// This method handles both absolute URLs (which are returned as-is if valid)
//     /// and relative URLs (which are combined with the base URL).
//     ///
//     /// - Parameter baseURL: The base URL to use if the URL string is relative.
//     /// - Returns: A fully qualified URL string if valid, else `nil`.
//     ///
//     /// - Example:
//     ///   ```swift
//     ///   // Absolute URL (returned as-is)
//     ///   "https://example.com/page.html".constructValidURL(baseURL: "https://base.com")
//     ///   // Returns: "https://example.com/page.html"
//     ///
//     ///   // Relative URL (combined with base URL)
//     ///   "page.html".constructValidURL(baseURL: "https://example.com")
//     ///   // Returns: "https://example.com/page.html"
//     ///   ```
//     func constructValidURL(baseURL: String?) -> String? {
//         // If the string is already a valid absolute URL, return it as-is
//         if let url = URL(string: self), url.scheme != nil, url.host != nil {
//             return self
//         }
//         
//         // If we have a base URL, try to combine it with this string as a relative path
//         if let baseURL = baseURL, let base = URL(string: baseURL) {
//             if let fullURL = URL(string: self, relativeTo: base)?.absoluteURL {
//                 return fullURL.absoluteString
//             }
//         }
//         
//         // If we couldn't construct a valid URL, return nil
//         return nil
//     }
// }

// File: Fact.swift
// //
// //  Fact.swift
// //  UtahNewsData
// //
// //  Created by Mark Evans on 2/12/25.
// //
// //  Summary: Defines the Fact model which represents verified pieces of information
// //           in the UtahNewsData system. Now conforms to JSONSchemaProvider to provide a static JSON schema for LLM responses.
// 
// import Foundation
// 
// /// Represents the verification status of a fact
// public enum VerificationStatus: String, Codable, Sendable {
//     case verified
//     case unverified
//     case disputed
//     case retracted
// }
// 
// /// Represents the confidence level in a fact's accuracy
// public enum ConfidenceLevel: String, Codable, Sendable {
//     case high
//     case medium
//     case low
// }
// 
// /// Represents a verified piece of information in the UtahNewsData system.
// /// Facts can be associated with articles, news events, and other content types,
// /// providing verified data points with proper attribution.
// public struct Fact: AssociatedData, EntityDetailsProvider, BaseEntity, JSONSchemaProvider, Sendable
// {  // Added JSONSchemaProvider and Sendable conformance
//     /// Unique identifier for the fact
//     public var id: String = UUID().uuidString
// 
//     /// The name of the entity (required by BaseEntity)
//     public var name: String {
//         let truncatedStatement = statement.count > 50 ? statement.prefix(50) + "..." : statement
//         return String(truncatedStatement)
//     }
// 
//     /// Relationships to other entities in the system
//     public var relationships: [Relationship] = []
// 
//     /// The factual statement
//     public var statement: String
// 
//     /// Organizations or persons that are the source of this fact
//     public var sources: [any EntityDetailsProvider]?
// 
//     /// Current verification status of the fact
//     public var verificationStatus: VerificationStatus?
// 
//     /// Confidence level in the fact's accuracy
//     public var confidenceLevel: ConfidenceLevel?
// 
//     /// When the fact was established or reported
//     public var date: Date?
// 
//     /// Subject areas or keywords related to the fact
//     public var topics: [String]?
// 
//     /// Category ID the fact belongs to (instead of direct reference)
//     public var categoryId: String?
// 
//     /// Entities (people, organizations, locations) related to this fact
//     public var relatedEntities: [any EntityDetailsProvider]?
// 
//     /// Creates a new Fact with the specified properties.
//     ///
//     /// - Parameters:
//     ///   - statement: The factual statement
//     ///   - sources: Organizations or persons that are the source of this fact
//     ///   - verificationStatus: Current verification status of the fact
//     ///   - confidenceLevel: Confidence level in the fact's accuracy
//     ///   - date: When the fact was established or reported
//     ///   - topics: Subject areas or keywords related to the fact
//     ///   - categoryId: ID of the category the fact belongs to
//     ///   - relatedEntities: Entities (people, organizations, locations) related to this fact
//     public init(
//         statement: String,
//         sources: [any EntityDetailsProvider]? = nil,
//         verificationStatus: VerificationStatus? = nil,
//         confidenceLevel: ConfidenceLevel? = nil,
//         date: Date? = nil,
//         topics: [String]? = nil,
//         categoryId: String? = nil,
//         relatedEntities: [any EntityDetailsProvider]? = nil
//     ) {
//         self.statement = statement
//         self.sources = sources
//         self.verificationStatus = verificationStatus
//         self.confidenceLevel = confidenceLevel
//         self.date = date
//         self.topics = topics
//         self.categoryId = categoryId
//         self.relatedEntities = relatedEntities
//     }
// 
//     /// Convenience initializer that takes a Category instance
//     ///
//     /// - Parameters:
//     ///   - statement: The factual statement
//     ///   - sources: Organizations or persons that are the source of this fact
//     ///   - verificationStatus: Current verification status of the fact
//     ///   - confidenceLevel: Confidence level in the fact's accuracy
//     ///   - date: When the fact was established or reported
//     ///   - topics: Subject areas or keywords related to the fact
//     ///   - category: Category the fact belongs to
//     ///   - relatedEntities: Entities (people, organizations, locations) related to this fact
//     public init(
//         statement: String,
//         sources: [any EntityDetailsProvider]? = nil,
//         verificationStatus: VerificationStatus? = nil,
//         confidenceLevel: ConfidenceLevel? = nil,
//         date: Date? = nil,
//         topics: [String]? = nil,
//         category: Category? = nil,
//         relatedEntities: [any EntityDetailsProvider]? = nil
//     ) {
//         self.statement = statement
//         self.sources = sources
//         self.verificationStatus = verificationStatus
//         self.confidenceLevel = confidenceLevel
//         self.date = date
//         self.topics = topics
//         self.categoryId = category?.id
//         self.relatedEntities = relatedEntities
//     }
// 
//     // Implement Equatable manually since we have properties that don't conform to Equatable
//     public static func == (lhs: Fact, rhs: Fact) -> Bool {
//         return lhs.id == rhs.id && lhs.statement == rhs.statement
//     }
// 
//     // Implement Hashable manually
//     public func hash(into hasher: inout Hasher) {
//         hasher.combine(id)
//         hasher.combine(statement)
//     }
// 
//     // Implement Codable manually
//     public init(from decoder: Decoder) throws {
//         let container = try decoder.container(keyedBy: CodingKeys.self)
// 
//         id = try container.decode(String.self, forKey: .id)
//         statement = try container.decode(String.self, forKey: .statement)
//         verificationStatus = try container.decodeIfPresent(
//             VerificationStatus.self, forKey: .verificationStatus)
//         confidenceLevel = try container.decodeIfPresent(
//             ConfidenceLevel.self, forKey: .confidenceLevel)
//         date = try container.decodeIfPresent(Date.self, forKey: .date)
//         topics = try container.decodeIfPresent([String].self, forKey: .topics)
//         categoryId = try container.decodeIfPresent(String.self, forKey: .categoryId)
//         relationships =
//             try container.decodeIfPresent([Relationship].self, forKey: .relationships) ?? []
// 
//         // Skip decoding sources and relatedEntities as they use protocol types
//         sources = nil
//         relatedEntities = nil
//     }
// 
//     public func encode(to encoder: Encoder) throws {
//         var container = encoder.container(keyedBy: CodingKeys.self)
// 
//         try container.encode(id, forKey: .id)
//         try container.encode(statement, forKey: .statement)
//         try container.encodeIfPresent(verificationStatus, forKey: .verificationStatus)
//         try container.encodeIfPresent(confidenceLevel, forKey: .confidenceLevel)
//         try container.encodeIfPresent(date, forKey: .date)
//         try container.encodeIfPresent(topics, forKey: .topics)
//         try container.encodeIfPresent(categoryId, forKey: .categoryId)
//         try container.encode(relationships, forKey: .relationships)
// 
//         // Skip encoding sources and relatedEntities as they use protocol types
//     }
// 
//     private enum CodingKeys: String, CodingKey {
//         case id, statement, verificationStatus, confidenceLevel, date, topics, categoryId,
//             relationships
//     }
// 
//     /// Generates a detailed text description of the fact for use in RAG systems.
//     /// The description includes the statement, verification status, sources, and contextual information.
//     ///
//     /// - Returns: A formatted string containing the fact's details
//     public func getDetailedDescription() -> String {
//         var description = "FACT: \(statement)"
// 
//         if let verificationStatus = verificationStatus {
//             description += "\nVerification Status: \(verificationStatus.rawValue)"
//         }
// 
//         if let confidenceLevel = confidenceLevel {
//             description += "\nConfidence Level: \(confidenceLevel.rawValue)"
//         }
// 
//         if let sources = sources, !sources.isEmpty {
//             description += "\nSources:"
//             for source in sources {
//                 description += "\n- \(source.name)"
//             }
//         }
// 
//         if let date = date {
//             let formatter = DateFormatter()
//             formatter.dateStyle = .medium
//             description += "\nDate: \(formatter.string(from: date))"
//         }
// 
//         if let categoryId = categoryId {
//             description += "\nCategory ID: \(categoryId)"
//         }
// 
//         if let topics = topics, !topics.isEmpty {
//             description += "\nTopics: \(topics.joined(separator: ", "))"
//         }
// 
//         return description
//     }
// 
//     // MARK: - JSON Schema Provider
//     /// Provides the JSON schema for Fact.
//     public static var jsonSchema: String {
//         """
//         {
//             "type": "object",
//             "properties": {
//                 "id": {"type": "string"},
//                 "statement": {"type": "string"},
//                 "sources": {
//                     "type": "array",
//                     "items": {
//                         "oneOf": [
//                             {"$ref": "#/definitions/Organization"},
//                             {"$ref": "#/definitions/Person"}
//                         ]
//                     },
//                     "optional": true
//                 },
//                 "verificationStatus": {
//                     "type": "string",
//                     "enum": ["verified", "unverified", "disputed", "retracted"],
//                     "optional": true
//                 },
//                 "confidenceLevel": {
//                     "type": "string",
//                     "enum": ["high", "medium", "low"],
//                     "optional": true
//                 },
//                 "date": {"type": "string", "format": "date-time", "optional": true},
//                 "topics": {
//                     "type": "array",
//                     "items": {"type": "string"},
//                     "optional": true
//                 },
//                 "categoryId": {"type": "string", "optional": true},
//                 "relatedEntities": {
//                     "type": "array",
//                     "items": {
//                         "oneOf": [
//                             {"$ref": "#/definitions/Organization"},
//                             {"$ref": "#/definitions/Person"},
//                             {"$ref": "#/definitions/Location"}
//                         ]
//                     },
//                     "optional": true
//                 },
//                 "metadata": {
//                     "type": "object",
//                     "additionalProperties": true,
//                     "optional": true
//                 }
//             },
//             "required": ["id", "statement"],
//             "definitions": {
//                 "Organization": {"$ref": "Organization.jsonSchema"},
//                 "Person": {"$ref": "Person.jsonSchema"},
//                 "Location": {"$ref": "Location.jsonSchema"}
//             }
//         }
//         """
//     }
// }

// File: Jurisdiction.swift
// //
// //  Jurisdiction.swift
// //  UtahNewsData
// //
// //  Created by Mark Evans on 12/10/24.
// //
// //  Summary: Defines the Jurisdiction model which represents governmental jurisdictions
// //           in the UtahNewsData system. Now conforms to JSONSchemaProvider to provide a static JSON schema for LLM responses.
// 
// import SwiftUI
// import Foundation
// import SwiftSoup
// 
// /// Represents the type of governmental jurisdiction.
// /// Used to categorize jurisdictions by their administrative level.
// public enum JurisdictionType: String, Codable, CaseIterable, Sendable {
//     /// City or municipal government
//     case city
//     
//     /// County government
//     case county
//     
//     /// State government
//     case state
// 
//     /// Returns a human-readable label for the jurisdiction type.
//     public var label: String {
//         switch self {
//         case .city: return "City"
//         case .county: return "County"
//         case .state: return "State"
//         }
//     }
// }
// 
// /// Represents a governmental jurisdiction such as a city, county, or state.
// /// Jurisdictions are important entities for categorizing and organizing news
// /// content by geographic and administrative boundaries.
// public struct Jurisdiction: AssociatedData, Identifiable, Codable, JSONSchemaProvider, Sendable {
//     /// Unique identifier for the jurisdiction
//     public var id: String
//     
//     /// Relationships to other entities in the system
//     public var relationships: [Relationship] = []
//     
//     /// Type of jurisdiction (city, county, state)
//     public var type: JurisdictionType
//     
//     /// Name of the jurisdiction
//     public var name: String
//     
//     /// Geographic location associated with the jurisdiction
//     public var location: Location?
//     
//     /// Official website URL for the jurisdiction
//     public var website: String?
//     
//     /// Creates a new jurisdiction with the specified properties.
//     ///
//     /// - Parameters:
//     ///   - id: Unique identifier for the jurisdiction (defaults to a new UUID string)
//     ///   - type: Type of jurisdiction (city, county, state)
//     ///   - name: Name of the jurisdiction
//     ///   - location: Geographic location associated with the jurisdiction
//     public init(id: String = UUID().uuidString, type: JurisdictionType, name: String, location: Location? = nil) {
//         self.id = id
//         self.type = type
//         self.name = name
//         self.location = location
//     }
// 
//     /// CodingKeys for custom encoding and decoding
//     enum CodingKeys: String, CodingKey {
//         case id
//         case relationships
//         case type
//         case name
//         case location
//         case website
//     }
// 
//     /// Custom decoder to handle optional location data safely.
//     /// This ensures that if location data is missing or malformed in the stored data,
//     /// the location property will be set to nil rather than causing a decoding error.
//     ///
//     /// - Parameter decoder: The decoder to read data from
//     /// - Throws: DecodingError if required properties cannot be decoded
//     public init(from decoder: Decoder) throws {
//         let container = try decoder.container(keyedBy: CodingKeys.self)
// 
//         self.id = try container.decode(String.self, forKey: .id)
//         self.relationships = (try? container.decode([Relationship].self, forKey: .relationships)) ?? []
//         self.type = try container.decode(JurisdictionType.self, forKey: .type)
//         self.name = try container.decode(String.self, forKey: .name)
//         // Use decodeIfPresent for location so it's nil if field is missing or can't decode
//         self.location = try? container.decodeIfPresent(Location.self, forKey: .location)
//         self.website = try? container.decodeIfPresent(String.self, forKey: .website)
//     }
//     
//     // MARK: - JSON Schema Provider
//     /// Provides the JSON schema for Jurisdiction.
//     public static var jsonSchema: String {
//         """
//         {
//             "type": "object",
//             "properties": {
//                 "id": { "type": "string", "format": "uuid" },
//                 "name": { "type": "string" },
//                 "level": { "type": "string" },
//                 "details": { "type": "string" }
//             },
//             "required": ["id", "name"]
//         }
//         """
//     }
// }
// 
// // MARK: - Sendable Implementation
// 
// extension Jurisdiction: @unchecked Sendable {} // Complex type with thread-safe properties

// File: LegalDocument.swift
// //
// //  LegalDocument.swift
// //  NewsCapture
// //
// //  Created by Mark Evans on 10/25/24.
// //
// //  Summary: Defines the LegalDocument model which represents legal documents and
// //           official records in the UtahNewsData system. Now conforms to JSONSchemaProvider
// //           to provide a static JSON schema for LLM responses.
// 
// import SwiftUI
// import Foundation
// import SwiftSoup
// 
// /// Represents different types of legal documents
// public enum LegalDocumentType: String, Codable, CaseIterable, Sendable {
//     /// Legislative bill
//     case bill = "Bill"
//     /// Court ruling or decision
//     case courtRuling = "Court Ruling"
//     /// Executive order
//     case executiveOrder = "Executive Order"
//     /// Administrative regulation
//     case regulation = "Regulation"
//     /// Legal statute
//     case statute = "Statute"
//     /// Legal opinion or advisory
//     case legalOpinion = "Legal Opinion"
//     /// Policy document
//     case policy = "Policy"
//     /// Other legal document types
//     case other = "Other"
//     
//     /// Returns a human-readable description of the document type
//     public var description: String {
//         return self.rawValue
//     }
// }
// 
// /// Represents a legal document or official record in the news system.
// /// Legal documents can include court filings, legislation, regulations,
// /// and other official legal records relevant to news coverage.
// public struct LegalDocument: AssociatedData, JSONSchemaProvider { // Added JSONSchemaProvider conformance
//     /// Unique identifier for the legal document
//     public var id: String
//     
//     /// Relationships to other entities in the system
//     public var relationships: [Relationship] = []
//     
//     /// Title or name of the legal document
//     public var title: String
//     
//     /// When the document was issued or published
//     public var dateIssued: Date
//     
//     /// The name property required by the AssociatedData protocol.
//     /// Returns the title of the document.
//     public var name: String {
//         return title
//     }
//     
//     /// Document type (e.g., "legislation", "court filing", "regulation")
//     public var documentType: String?
//     
//     /// Official document number or identifier
//     public var documentNumber: String?
//     
//     /// URL where the document can be accessed
//     public var documentURL: String?
//     
//     /// Creates a new legal document with the specified properties.
//     ///
//     /// - Parameters:
//     ///   - id: Unique identifier for the document (defaults to a new UUID string)
//     ///   - title: Title or name of the legal document
//     ///   - dateIssued: When the document was issued or published
//     ///   - documentType: Type of document (e.g., "legislation", "court filing")
//     ///   - documentNumber: Official document number or identifier
//     ///   - documentURL: URL where the document can be accessed
//     public init(
//         id: String = UUID().uuidString,
//         title: String,
//         dateIssued: Date,
//         documentType: String? = nil,
//         documentNumber: String? = nil,
//         documentURL: String? = nil
//     ) {
//         self.id = id
//         self.title = title
//         self.dateIssued = dateIssued
//         self.documentType = documentType
//         self.documentNumber = documentNumber
//         self.documentURL = documentURL
//     }
//     
//     // MARK: - JSON Schema Provider
//     /// Provides the JSON schema for LegalDocument.
//     public static var jsonSchema: String {
//         return """
//         {
//             "type": "object",
//             "properties": {
//                 "id": {"type": "string"},
//                 "relationships": {
//                     "type": "array",
//                     "items": {"type": "object"}
//                 },
//                 "title": {"type": "string"},
//                 "dateIssued": {"type": "string", "format": "date-time"},
//                 "documentType": {"type": ["string", "null"]},
//                 "documentNumber": {"type": ["string", "null"]},
//                 "documentURL": {"type": ["string", "null"]}
//             },
//             "required": ["id", "title", "dateIssued"]
//         }
//         """
//     }
// }

// File: Location.swift
// //
// //  Location.swift
// //  NewsCapture
// //
// //  Created by Mark Evans on 10/25/24.
// //
// //  Summary: Defines the Location model which represents geographic locations
// //           in the UtahNewsData system. Now conforms to JSONSchemaProvider to provide a static JSON schema for LLM responses.
// //           Also includes the Coordinates struct with JSON schema updates.
// 
// import Foundation
// import SwiftUI
// import SwiftSoup
// 
// /// Represents a physical location in the UtahNewsData system
// public struct Location: Codable, Identifiable, Hashable, Equatable, AssociatedData, Sendable, JSONSchemaProvider {
//     /// Unique identifier for the location
//     public var id: String
// 
//     /// Relationships to other entities (events, organizations, etc.)
//     public var relationships: [Relationship] = []
// 
//     /// The location's name (e.g., "Salt Lake City", "Utah State Capitol")
//     public var name: String
// 
//     /// Optional street address or descriptive location
//     public var address: String?
// 
//     /// Optional geographic coordinates (latitude/longitude)
//     public var coordinates: Coordinates?
// 
//     /// Latitude coordinate (north/south position)
//     public var latitude: Double?
// 
//     /// Longitude coordinate (east/west position)
//     public var longitude: Double?
// 
//     /// City of the location
//     public var city: String?
// 
//     /// State of the location
//     public var state: String?
// 
//     /// Zip code of the location
//     public var zipCode: String?
// 
//     /// Country of the location
//     public var country: String?
// 
//     /// Creates a new Location with a name.
//     ///
//     /// - Parameters:
//     ///   - id: Unique identifier (defaults to a new UUID string)
//     ///   - name: The location's name
//     public init(id: String = UUID().uuidString, name: String) {
//         self.id = id
//         self.name = name
//     }
// 
//     /// Creates a new Location with a name and coordinates.
//     ///
//     /// - Parameters:
//     ///   - id: Unique identifier (defaults to a new UUID string)
//     ///   - name: The location's name
//     ///   - coordinates: Geographic coordinates (latitude/longitude)
//     public init(id: String = UUID().uuidString, name: String, coordinates: Coordinates?) {
//         self.id = id
//         self.name = name
//         self.coordinates = coordinates
//     }
// 
//     /// Creates a new Location with additional details.
//     ///
//     /// - Parameters:
//     ///   - latitude: Latitude coordinate
//     ///   - longitude: Longitude coordinate
//     ///   - address: Street address
//     ///   - city: City
//     ///   - state: State
//     ///   - zipCode: Zip code
//     ///   - country: Country
//     ///   - relationships: Array of relationships to other entities
//     public init(
//         latitude: Double? = nil,
//         longitude: Double? = nil,
//         address: String? = nil,
//         city: String? = nil,
//         state: String? = nil,
//         zipCode: String? = nil,
//         country: String? = nil,
//         relationships: [Relationship] = []
//     ) {
//         self.id = UUID().uuidString
//         self.name = [city, state].compactMap { $0 }.joined(separator: ", ")
//         self.latitude = latitude
//         self.longitude = longitude
//         self.address = address
//         self.city = city
//         self.state = state
//         self.zipCode = zipCode
//         self.country = country
//         self.relationships = relationships
//     }
// 
//     // MARK: - JSON Schema Provider
//     /// Provides the JSON schema for Location.
//     public static var jsonSchema: String {
//         """
//         {
//             "type": "object",
//             "properties": {
//                 "id": { "type": "string", "format": "uuid" },
//                 "street": { "type": "string" },
//                 "city": { "type": "string" },
//                 "state": { "type": "string" },
//                 "postalCode": { "type": "string" },
//                 "country": { "type": "string" }
//             },
//             "required": ["id"]
//         }
//         """
//     }
// }
// 
// /// Represents geographic coordinates with latitude and longitude.
// public struct Coordinates: BaseEntity, Codable, Hashable, Equatable, JSONSchemaProvider, Sendable
// {  // Added JSONSchemaProvider and Sendable conformance
//     /// Unique identifier for the coordinates
//     public var id: String
// 
//     /// The name or description of these coordinates
//     public var name: String
// 
//     /// Latitude coordinate (north/south position)
//     public var latitude: Double
// 
//     /// Longitude coordinate (east/west position)
//     public var longitude: Double
// 
//     /// Creates new geographic coordinates.
//     /// - Parameters:
//     ///   - id: Unique identifier for the coordinates
//     ///   - name: Name or description of these coordinates (e.g., "Downtown SLC")
//     ///   - latitude: Latitude coordinate
//     ///   - longitude: Longitude coordinate
//     public init(
//         id: String = UUID().uuidString,
//         name: String,
//         latitude: Double,
//         longitude: Double
//     ) {
//         self.id = id
//         self.name = name
//         self.latitude = latitude
//         self.longitude = longitude
//     }
// 
//     // MARK: - JSON Schema Provider
//     /// Provides the JSON schema for Coordinates.
//     public static var jsonSchema: String {
//         return """
//             {
//                 "type": "object",
//                 "properties": {
//                     "id": {"type": "string"},
//                     "name": {"type": "string"},
//                     "latitude": {"type": "number"},
//                     "longitude": {"type": "number"}
//                 },
//                 "required": ["id", "name", "latitude", "longitude"]
//             }
//             """
//     }
// }

// Warning: File Medialtem.swift not found in /Users/markevans/Developer/UtahNewsData/Sources/UtahNewsData
// File: NewsAlert.swift
// //
// //  NewsAlert.swift
// //  NewsCapture
// //
// //  Created by Mark Evans on 10/25/24.
// //
// //  Summary: Defines the NewsAlert model which represents time-sensitive alerts and notifications
// //           in the UtahNewsData system. Now conforms to JSONSchemaProvider to provide a static JSON schema for LLM responses.
// 
// import SwiftUI
// import Foundation
// import SwiftSoup
// 
// /// Represents a time-sensitive alert or notification in the news system.
// /// News alerts can include breaking news, emergency notifications, weather
// /// alerts, and other time-critical information.
// public struct NewsAlert: AssociatedData, JSONSchemaProvider, Sendable {
//     /// Unique identifier for the alert
//     public var id: String
//     
//     /// Relationships to other entities in the system
//     public var relationships: [Relationship] = []
//     
//     /// Title or headline of the alert
//     public var title: String
//     
//     /// Detailed message or content of the alert
//     public var content: String
//     
//     /// Type of alert (e.g., "Breaking News", "Weather Alert", etc.)
//     public var alertType: String
//     
//     /// Severity level of the alert
//     public var severity: AlertSeverity
//     
//     /// When the alert was published
//     public var publishedAt: Date
//     
//     /// Source or issuer of the alert
//     public var source: String?
//     
//     /// When the alert expires or is no longer relevant
//     public var expirationDate: Date?
//     
//     /// The name property required by the AssociatedData protocol.
//     /// Returns the title of the alert.
//     public var name: String {
//         return title
//     }
//     
//     /// Creates a new news alert with the specified properties.
//     ///
//     /// - Parameters:
//     ///   - id: Unique identifier for the alert (defaults to a new UUID string)
//     ///   - title: Title or headline of the alert
//     ///   - content: Detailed content of the alert
//     ///   - alertType: Type of the alert
//     ///   - severity: Severity level of the alert
//     ///   - publishedAt: When the alert was published
//     ///   - source: Source or issuer of the alert
//     public init(
//         id: String = UUID().uuidString,
//         title: String,
//         content: String,
//         alertType: String,
//         severity: AlertSeverity,
//         publishedAt: Date,
//         source: String? = nil
//     ) {
//         self.id = id
//         self.title = title
//         self.content = content
//         self.alertType = alertType
//         self.severity = severity
//         self.publishedAt = publishedAt
//         self.source = source
//     }
//     
//     // MARK: - JSONSchemaProvider Implementation
//     
//     public static var jsonSchema: String {
//         """
//         {
//             "type": "object",
//             "properties": {
//                 "id": { "type": "string", "format": "uuid" },
//                 "title": { "type": "string" },
//                 "content": { "type": "string" },
//                 "urgencyLevel": { "type": "string", "enum": ["low", "medium", "high", "critical"] },
//                 "category": { "type": "string" },
//                 "location": { "$ref": "#/definitions/Location" },
//                 "timestamp": { "type": "string", "format": "date-time" },
//                 "source": { "type": "string" }
//             },
//             "required": ["id", "title", "content"]
//         }
//         """
//     }
// }
// 
// /// Represents the severity level of a news alert.
// /// Used to categorize alerts by their urgency and significance.
// public enum AlertSeverity: String, Codable, CaseIterable, Sendable {
//     /// Low priority or informational alert
//     case low
//     
//     /// Medium priority alert with moderate importance
//     case medium
//     
//     /// High priority alert requiring immediate attention
//     case high
//     
//     /// Returns a human-readable description of the alert severity
//     public var description: String {
//         switch self {
//         case .low:
//             return "Low Priority"
//         case .medium:
//             return "Medium Priority"
//         case .high:
//             return "High Priority"
//         }
//     }
//     
//     /// Returns a color associated with this alert severity for UI display
//     public var color: String {
//         switch self {
//         case .low:
//             return "blue"
//         case .medium:
//             return "yellow"
//         case .high:
//             return "orange"
//         }
//     }
// }
// 
// /// Represents the urgency level of a news alert
// public enum UrgencyLevel: String, Codable, CaseIterable, Sendable {
//     /// Immediate attention required
//     case immediate
//     /// High priority but not immediate
//     case high
//     /// Medium priority
//     case medium
//     /// Low priority
//     case low
//     
//     /// Returns a human-readable description of the urgency level
//     public var description: String {
//         switch self {
//         case .immediate:
//             return "Immediate"
//         case .high:
//             return "High"
//         case .medium:
//             return "Medium"
//         case .low:
//             return "Low"
//         }
//     }
//     
//     /// Returns a color associated with this urgency level for UI display
//     public var color: String {
//         switch self {
//         case .immediate:
//             return "red"
//         case .high:
//             return "orange"
//         case .medium:
//             return "yellow"
//         case .low:
//             return "blue"
//         }
//     }
// }

// File: NewsContent.swift
// //
// //  NewsContent.swift
// //  UtahNewsData
// //
// //  Created by Mark Evans on 11/18/24.
// //
// 
// /*
//  # NewsContent Protocol
//  
//  This file defines the NewsContent protocol, which serves as the foundation for
//  various types of news content in the UtahNewsData system, such as articles, videos,
//  and audio content.
//  
//  ## Key Features:
//  
//  1. Core identification (id, title)
//  2. Content access (url)
//  3. Media representation (urlToImage)
//  4. Publication metadata (publishedAt, author)
//  5. Content storage (textContent)
//  6. Basic information display (basicInfo)
//  
//  ## Usage:
//  
//  The NewsContent protocol is implemented by various content types:
//  
//  ```swift
//  // Article implementation
//  struct Article: NewsContent {
//      var id: String
//      var title: String
//      var url: String
//      var urlToImage: String?
//      var publishedAt: Date
//      var textContent: String?
//      var author: String?
//      
//      // Additional article-specific properties
//      var category: String?
//      var source: String?
//  }
//  
//  // Video implementation
//  struct Video: NewsContent {
//      var id: String
//      var title: String
//      var url: String
//      var urlToImage: String?
//      var publishedAt: Date
//      var textContent: String?
//      var author: String?
//      
//      // Additional video-specific properties
//      var duration: TimeInterval
//      var resolution: String
//  }
//  ```
//  
//  The protocol provides a common interface for working with different types of news content,
//  allowing for consistent handling in UI components and data processing.
//  
//  ## Migration to MediaItem
//  
//  While the NewsContent protocol is still supported for backward compatibility,
//  new code should use the MediaItem struct instead, which provides a more unified
//  approach to handling all types of media content.
//  
//  ```swift
//  // Convert a NewsContent object to a MediaItem
//  let article = Article(title: "News Article", url: "https://example.com")
//  let mediaItem = MediaItem.from(article)
//  ```
//  */
// 
// import Foundation
// 
// /// A protocol defining the common properties and methods for news content types.
// /// This protocol serves as the foundation for various types of news content in the
// /// UtahNewsData system, such as articles, videos, and audio content.
// ///
// /// Note: While still supported for backward compatibility, new code should use
// /// the MediaItem struct instead, which provides a more unified approach to
// /// handling all types of media content.
// public protocol NewsContent: BaseEntity {
//     /// Title or headline of the content
//     var title: String { get set }
//     
//     /// URL where the content can be accessed
//     var url: String { get set }
//     
//     /// URL to an image representing the content (thumbnail, featured image)
//     var urlToImage: String? { get set }
//     
//     /// When the content was published
//     var publishedAt: Date { get set }
//     
//     /// The main text content, if available
//     var textContent: String? { get set }
//     
//     /// Author or creator of the content
//     var author: String? { get set }
//     
//     /// Returns a basic information string about the content
//     func basicInfo() -> String
// }
// 
// /// Default implementation of the basicInfo method
// public extension NewsContent {
//     /// Returns a basic information string containing the title and publication date.
//     /// 
//     /// - Returns: A formatted string with the content's title and publication date
//     func basicInfo() -> String {
//         return "Title: \(title), Published At: \(publishedAt)"
//     }
//     
//     /// The name property required by the BaseEntity protocol.
//     /// Returns the title of the content.
//     var name: String {
//         return title
//     }
// }
// 
// /// Extension to provide conversion to MediaItem
// public extension NewsContent {
//     /// Converts this NewsContent object to a MediaItem.
//     ///
//     /// - Returns: A new MediaItem with properties from this NewsContent object
//     func toMediaItem() -> MediaItem {
//         return MediaItem(
//             id: id,
//             title: title,
//             type: determineMediaType(),
//             url: url,
//             textContent: textContent,
//             author: author,
//             publishedAt: publishedAt
//         )
//     }
//     
//     /// Determines the appropriate MediaType for this NewsContent object.
//     ///
//     /// - Returns: The MediaType that best matches this content
//     private func determineMediaType() -> MediaType {
//         // This is a simple implementation that could be overridden by specific types
//         let typeString = String(describing: type(of: self)).lowercased()
//         
//         if typeString.contains("video") {
//             return .video
//         } else if typeString.contains("audio") {
//             return .audio
//         } else if typeString.contains("article") {
//             return .text
//         } else {
//             return .other
//         }
//     }
// }

// File: NewsEvent.swift
// //
// //  NewsEvent.swift
// //  UtahNewsData
// //
// //  Created by Mark Evans on 2/12/25.
// //
// 
// /*
//  # NewsEvent Model
// 
//  This file defines the NewsEvent model, which represents significant events covered in the news
//  in the UtahNewsData system. NewsEvents can be associated with articles, people, organizations,
//  and locations, providing a way to track and organize coverage of specific occurrences.
// 
//  ## Key Features:
// 
//  1. Core event information (title, date)
//  2. Associated content (quotes, facts, statistical data)
//  3. Categorization
//  4. Relationships to other entities
// 
//  ## Usage:
// 
//  ```swift
//  // Create a basic news event
//  let basicEvent = NewsEvent(
//      title: "Utah State Fair",
//      date: Date() // September 5, 2023
//  )
// 
//  // Create a detailed news event with associated content
//  let detailedEvent = NewsEvent(
//      title: "Utah Legislative Session 2023",
//      date: Date() // January 17, 2023
//  )
// 
//  // Add quotes to the event
//  let governorQuote = Quote(
//      text: "This legislative session will focus on water conservation and education funding.",
//      speaker: governor // Person entity
//  )
//  detailedEvent.quotes.append(governorQuote)
// 
//  // Add facts to the event
//  let budgetFact = Fact(
//      statement: "The proposed state budget includes $200 million for water infrastructure."
//  )
//  detailedEvent.facts.append(budgetFact)
// 
//  // Add statistical data to the event
//  let educationStat = StatisticalData(
//      title: "Education Funding",
//      value: "7.8",
//      unit: "billion dollars"
//  )
//  detailedEvent.statisticalData.append(educationStat)
// 
//  // Add categories to the event
//  let politicsCategory = Category(name: "Politics")
//  let budgetCategory = Category(name: "Budget")
//  detailedEvent.categories = [politicsCategory, budgetCategory]
// 
//  // Create relationships with other entities
//  let articleRelationship = Relationship(
//      fromEntity: detailedEvent,
//      toEntity: legislativeArticle, // Article entity
//      type: .describes
//  )
//  detailedEvent.relationships.append(articleRelationship)
//  ```
// 
//  The NewsEvent model implements AssociatedData, allowing it to be linked with
//  other entities in the UtahNewsData system through relationships.
//  */
// 
// import Foundation
// import SwiftSoup
// 
// /// Represents a significant event covered in the news in the UtahNewsData system.
// /// NewsEvents can be associated with articles, people, organizations, and locations,
// /// providing a way to track and organize coverage of specific occurrences.
// public struct NewsEvent: Codable, Identifiable, Hashable, Equatable, AssociatedData, Sendable,
//     JSONSchemaProvider, EntityDetailsProvider
// {
//     /// Unique identifier for the news event
//     public var id: String
// 
//     /// Relationships to other entities in the system
//     public var relationships: [Relationship] = []
// 
//     /// The name or headline of the event
//     public var title: String
// 
//     /// The name property required by the BaseEntity protocol
//     public var name: String {
//         return title
//     }
// 
//     /// When the event occurred
//     public var date: Date
// 
//     /// Direct quotations related to the event
//     public var quotes: [Quote] = []
// 
//     /// Verified facts related to the event
//     public var facts: [Fact] = []
// 
//     /// Statistical data points related to the event
//     public var statisticalData: [StatisticalData] = []
// 
//     /// Categories that the event belongs to
//     public var categories: [Category] = []
// 
//     /// Description of the event
//     public var description: String?
// 
//     /// Start date of the event
//     public var startDate: Date?
// 
//     /// End date of the event
//     public var endDate: Date?
// 
//     /// Location of the event
//     public var location: Location?
// 
//     /// Participants in the event
//     public var participants: [Person]?
// 
//     /// Organizations involved in the event
//     public var organizations: [Organization]?
// 
//     /// Related events
//     public var relatedEvents: [String]?
// 
//     /// Creates a new NewsEvent with the specified properties.
//     ///
//     /// - Parameters:
//     ///   - id: Unique identifier for the news event (defaults to a new UUID string)
//     ///   - title: The name or headline of the event
//     ///   - date: When the event occurred
//     ///   - description: Description of the event
//     ///   - startDate: Start date of the event
//     ///   - endDate: End date of the event
//     ///   - location: Location of the event
//     ///   - participants: Participants in the event
//     ///   - organizations: Organizations involved in the event
//     ///   - relatedEvents: Related events
//     ///   - relationships: Relationships to other entities
//     public init(
//         id: String = UUID().uuidString,
//         title: String,
//         date: Date,
//         description: String? = nil,
//         startDate: Date? = nil,
//         endDate: Date? = nil,
//         location: Location? = nil,
//         participants: [Person]? = nil,
//         organizations: [Organization]? = nil,
//         relatedEvents: [String]? = nil,
//         relationships: [Relationship] = []
//     ) {
//         self.id = id
//         self.title = title
//         self.date = date
//         self.description = description
//         self.startDate = startDate
//         self.endDate = endDate
//         self.location = location
//         self.participants = participants
//         self.organizations = organizations
//         self.relatedEvents = relatedEvents
//         self.relationships = relationships
//     }
// 
//     /// JSON schema for LLM responses
//     public static var jsonSchema: String {
//         """
//         {
//             "type": "object",
//             "properties": {
//                 "id": { "type": "string", "format": "uuid" },
//                 "title": { "type": "string" },
//                 "description": { "type": "string" },
//                 "startDate": { "type": "string", "format": "date-time" },
//                 "endDate": { "type": "string", "format": "date-time" },
//                 "location": { "$ref": "#/definitions/Location" },
//                 "organizer": { "$ref": "#/definitions/Organization" },
//                 "participants": {
//                     "type": "array",
//                     "items": { "$ref": "#/definitions/Person" }
//                 },
//                 "category": { "type": "string" },
//                 "tags": {
//                     "type": "array",
//                     "items": { "type": "string" }
//                 },
//                 "status": { "type": "string", "enum": ["scheduled", "inProgress", "completed", "cancelled"] },
//                 "url": { "type": "string", "format": "uri" }
//             },
//             "required": ["id", "title", "startDate"]
//         }
//         """
//     }
//     
//     // MARK: - EntityDetailsProvider Implementation
//     
//     public func getDetailedDescription() -> String {
//         var description = "EVENT: \(title)"
//         
//         if let desc = self.description {
//             description += "\nDescription: \(desc)"
//         }
//         
//         let formatter = DateFormatter()
//         formatter.dateStyle = .medium
//         description += "\nDate: \(formatter.string(from: date))"
//         
//         if let startDate = startDate {
//             description += "\nStart Date: \(formatter.string(from: startDate))"
//         }
//         
//         if let endDate = endDate {
//             description += "\nEnd Date: \(formatter.string(from: endDate))"
//         }
//         
//         if let location = location {
//             description += "\nLocation: \(location.name)"
//         }
//         
//         if let participants = participants, !participants.isEmpty {
//             description += "\nParticipants: \(participants.map { $0.name }.joined(separator: ", "))"
//         }
//         
//         if let organizations = organizations, !organizations.isEmpty {
//             description += "\nOrganizations: \(organizations.map { $0.name }.joined(separator: ", "))"
//         }
//         
//         if !quotes.isEmpty {
//             description += "\nQuotes: \(quotes.count)"
//         }
//         
//         if !facts.isEmpty {
//             description += "\nFacts: \(facts.count)"
//         }
//         
//         if !statisticalData.isEmpty {
//             description += "\nStatistical Data Points: \(statisticalData.count)"
//         }
//         
//         if !categories.isEmpty {
//             description += "\nCategories: \(categories.map { $0.name }.joined(separator: ", "))"
//         }
//         
//         return description
//     }
// }

// File: NewsStory.swift
// //
// //  NewsStory.swift
// //  NewsCapture
// //
// //  Created by Mark Evans on 10/25/24.
// //
// 
// /*
//  # NewsStory Model
// 
//  This file defines the NewsStory model, which represents a complete news story
//  in the UtahNewsData system. A news story is a comprehensive journalistic piece
//  that includes a headline, author attribution, publication date, and categorization.
// 
//  ## Key Features:
// 
//  1. Story identification (headline)
//  2. Author attribution
//  3. Publication tracking (publishedDate)
//  4. Categorization
//  5. Source attribution
//  6. Relationship tracking with other entities
// 
//  ## Usage:
// 
//  ```swift
//  // Create a news story
//  let reporter = Person(name: "Jane Smith", details: "Staff Reporter")
// 
//  let story = NewsStory(
//      headline: "Utah Legislature Passes New Water Conservation Bill",
//      author: reporter,
//      publishedDate: Date()
//  )
// 
//  // Add categories
//  story.categories = [
//      Category(name: "Politics"),
//      Category(name: "Environment")
//  ]
// 
//  // Add sources
//  story.sources = [
//      Source(name: "Utah State Legislature", url: "https://le.utah.gov"),
//      Source(name: "Department of Natural Resources", url: "https://dnr.utah.gov")
//  ]
// 
//  // Associate with related entities
//  let billRelationship = Relationship(
//      id: senateBill101.id,
//      type: .legalDocument,
//      displayName: "Covers"
//  )
//  story.relationships.append(billRelationship)
//  ```
// 
//  The NewsStory model implements AssociatedData, allowing it to maintain
//  relationships with other entities in the system, such as people, organizations,
//  and legal documents.
//  */
// 
// import SwiftUI
// 
// /// Represents a complete news story in the news system.
// /// A news story is a comprehensive journalistic piece that includes
// /// a headline, author attribution, publication date, and categorization.
// public struct NewsStory: AssociatedData, JSONSchemaProvider, Sendable {
//     /// Unique identifier for the news story
//     public var id: String
// 
//     /// Relationships to other entities in the system
//     public var relationships: [Relationship] = []
// 
//     /// Headline or title of the news story
//     public var headline: String
// 
//     /// Author or reporter who wrote the story
//     public var author: Person
// 
//     /// When the story was published
//     public var publishedDate: Date
// 
//     /// Categories or topics associated with the story
//     public var categories: [Category] = []
// 
//     /// Sources cited or referenced in the story
//     public var sources: [Source] = []
// 
//     /// The name property required by the AssociatedData protocol.
//     /// Returns the headline of the story.
//     public var name: String {
//         return headline
//     }
// 
//     /// Full text content of the story
//     public var content: String?
// 
//     /// URL where the story can be accessed
//     public var url: String?
// 
//     /// Featured image URL for the story
//     public var featuredImageURL: String?
// 
//     /// Creates a new news story with the specified properties.
//     ///
//     /// - Parameters:
//     ///   - id: Unique identifier for the story (defaults to a new UUID string)
//     ///   - headline: Headline or title of the news story
//     ///   - author: Author or reporter who wrote the story
//     ///   - publishedDate: When the story was published
//     ///   - content: Full text content of the story
//     ///   - url: URL where the story can be accessed
//     ///   - featuredImageURL: Featured image URL for the story
//     public init(
//         id: String = UUID().uuidString,
//         headline: String,
//         author: Person,
//         publishedDate: Date,
//         content: String? = nil,
//         url: String? = nil,
//         featuredImageURL: String? = nil
//     ) {
//         self.id = id
//         self.headline = headline
//         self.author = author
//         self.publishedDate = publishedDate
//         self.content = content
//         self.url = url
//         self.featuredImageURL = featuredImageURL
//     }
// 
//     /// JSON schema for LLM responses
//     public static var jsonSchema: String {
//         """
//         {
//             "type": "object",
//             "properties": {
//                 "id": {"type": "string"},
//                 "headline": {"type": "string"},
//                 "author": {"$ref": "#/definitions/Person"},
//                 "publishedDate": {"type": "string", "format": "date-time"},
//                 "categories": {
//                     "type": "array",
//                     "items": {"$ref": "#/definitions/Category"},
//                     "optional": true
//                 },
//                 "sources": {
//                     "type": "array",
//                     "items": {"$ref": "#/definitions/Source"},
//                     "optional": true
//                 },
//                 "content": {"type": "string", "optional": true},
//                 "summary": {"type": "string", "optional": true},
//                 "keywords": {
//                     "type": "array",
//                     "items": {"type": "string"},
//                     "optional": true
//                 },
//                 "url": {"type": "string", "format": "uri", "optional": true},
//                 "mediaItems": {
//                     "type": "array",
//                     "items": {"$ref": "#/definitions/MediaItem"},
//                     "optional": true
//                 }
//             },
//             "required": ["id", "headline", "author", "publishedDate"],
//             "definitions": {
//                 "Person": {"$ref": "Person.jsonSchema"},
//                 "Category": {"$ref": "Category.jsonSchema"},
//                 "Source": {"$ref": "Source.jsonSchema"},
//                 "MediaItem": {"$ref": "MediaItem.jsonSchema"}
//             }
//         }
//         """
//     }
// }

// File: Organization.swift
// //
// //  Organization.swift
// //  UtahNewsData
// //
// //  Created by Mark Evans on 10/25/24.
// //
// 
// /*
//  # Organization Model
// 
//  This file defines the Organization model, which represents companies, institutions,
//  government agencies, and other organizational entities in the UtahNewsData system.
//  The Organization model is one of the core entity types and can be related to many
//  other entities such as people, locations, news stories, and more.
// 
//  ## Key Features:
// 
//  1. Core identification (id, name)
//  2. Organizational description
//  3. Contact information
//  4. Web presence
// 
//  ## Usage:
// 
//  ```swift
//  // Create a basic organization
//  let organization = Organization(
//      name: "Utah News Network",
//      orgDescription: "A news organization covering Utah news"
//  )
// 
//  // Create an organization with contact information
//  let detailedOrg = Organization(
//      name: "Utah Tech Association",
//      orgDescription: "Industry association for technology companies in Utah",
//      contactInfo: [
//          ContactInfo(
//              name: "Media Relations",
//              email: "media@utatech.org",
//              phone: "801-555-1234"
//          )
//      ],
//      website: "https://utatech.org"
//  )
// 
//  // Add a relationship to another entity
//  var updatedOrg = organization
//  updatedOrg.relationships.append(
//      Relationship(
//          id: person.id,
//          type: .person,
//          displayName: "Employs",
//          context: "Chief Executive Officer"
//      )
//  )
//  ```
// 
//  The Organization model implements EntityDetailsProvider, which allows it to generate
//  rich text descriptions for RAG systems.
//  */
// 
// import SwiftUI
// import Foundation
// import SwiftSoup
// 
// /// Represents the type of organization
// public enum OrganizationType: String, Codable, CaseIterable, Sendable {
//     /// For-profit corporation
//     case corporation
//     /// Non-profit organization
//     case nonProfit
//     /// Government agency or department
//     case government
//     /// Educational institution
//     case educational
//     /// Media outlet or news organization
//     case mediaOutlet
//     
//     /// Returns a human-readable label for the organization type
//     public var label: String {
//         switch self {
//         case .corporation:
//             return "Corporation"
//         case .nonProfit:
//             return "Non-Profit Organization"
//         case .government:
//             return "Government Agency"
//         case .educational:
//             return "Educational Institution"
//         case .mediaOutlet:
//             return "Media Outlet"
//         }
//     }
// }
// 
// /// Represents an organization in the UtahNewsData system
// public struct Organization: AssociatedData, Codable, Identifiable, Hashable, Equatable, EntityDetailsProvider, Sendable {
//     /// Unique identifier for the organization
//     public var id: String
// 
//     /// Relationships to other entities (people, locations, etc.)
//     public var relationships: [Relationship] = []
// 
//     /// The organization's name
//     public var name: String
// 
//     /// Description of the organization
//     /// Note: This is stored as `orgDescription` internally to avoid conflicts with Swift's `description`
//     public var orgDescription: String?
// 
//     /// Array of contact information entries
//     public var contactInfo: [ContactInfo]? = []
// 
//     /// Organization's website URL
//     public var website: String?
// 
//     /// Organization's logo URL
//     public var logoURL: String?
// 
//     /// Organization's location
//     public var location: Location?
// 
//     /// Organization's type
//     public var type: String?
// 
//     /// Creates a new Organization instance with the specified properties.
//     ///
//     /// - Parameters:
//     ///   - id: Unique identifier (defaults to a new UUID string)
//     ///   - name: The organization's name
//     ///   - orgDescription: Description of the organization
//     ///   - contactInfo: Array of contact information entries
//     ///   - website: Organization's website URL
//     ///   - logoURL: Organization's logo URL
//     ///   - location: Organization's location
//     ///   - type: Organization's type
//     public init(
//         id: String = UUID().uuidString,
//         name: String,
//         orgDescription: String? = nil,
//         contactInfo: [ContactInfo]? = nil,
//         website: String? = nil,
//         logoURL: String? = nil,
//         location: Location? = nil,
//         type: String? = nil
//     ) {
//         self.id = id
//         self.name = name
//         self.orgDescription = orgDescription
//         self.contactInfo = contactInfo
//         self.website = website
//         self.logoURL = logoURL
//         self.location = location
//         self.type = type
//     }
// 
//     /// Creates an Organization instance by decoding from the given decoder.
//     /// Handles backward compatibility with the legacy "description" field.
//     ///
//     /// - Parameter decoder: The decoder to read data from
//     /// - Throws: An error if decoding fails
//     public init(from decoder: Decoder) throws {
//         let container = try decoder.container(keyedBy: CodingKeys.self)
//         // Use decodeIfPresent for id and fall back to a new UUID if missing.
//         self.id = (try? container.decodeIfPresent(String.self, forKey: .id)) ?? UUID().uuidString
//         self.relationships =
//             (try? container.decode([Relationship].self, forKey: .relationships)) ?? []
//         self.name = try container.decode(String.self, forKey: .name)
//         // First try the new key "orgDescription", then fall back to the legacy key "description"
//         let decodedDesc =
//             (try? container.decodeIfPresent(String.self, forKey: .orgDescription))
//             ?? (try? container.decodeIfPresent(String.self, forKey: .oldDescription))
//         self.orgDescription = (decodedDesc?.isEmpty ?? true) ? nil : decodedDesc
//         self.contactInfo = try? container.decode([ContactInfo].self, forKey: .contactInfo)
//         self.website = try? container.decode(String.self, forKey: .website)
//         self.logoURL = try? container.decode(String.self, forKey: .logoURL)
//         self.location = try? container.decode(Location.self, forKey: .location)
//         self.type = try? container.decode(String.self, forKey: .type)
//     }
// 
//     /// Encodes the Organization instance to the given encoder.
//     /// Maintains backward compatibility by encoding to both the new and legacy description fields.
//     ///
//     /// - Parameter encoder: The encoder to write data to
//     /// - Throws: An error if encoding fails
//     public func encode(to encoder: Encoder) throws {
//         var container = encoder.container(keyedBy: CodingKeys.self)
//         try container.encode(id, forKey: .id)
//         try container.encode(relationships, forKey: .relationships)
//         try container.encode(name, forKey: .name)
//         // Always encode using the legacy key "description" for backward compatibility.
//         try container.encode(orgDescription, forKey: .oldDescription)
//         try container.encode(contactInfo, forKey: .contactInfo)
//         try container.encode(website, forKey: .website)
//         try container.encode(logoURL, forKey: .logoURL)
//         try container.encode(location, forKey: .location)
//         try container.encode(type, forKey: .type)
//     }
// 
//     /// Keys used for encoding and decoding Organization instances
//     private enum CodingKeys: String, CodingKey {
//         case id, relationships, name
//         case orgDescription
//         case oldDescription = "description"
//         case contactInfo, website, logoURL, location, type
//     }
// 
//     // MARK: - JSONSchemaProvider Implementation
//     
//     public static var jsonSchema: String {
//         """
//         {
//             "type": "object",
//             "properties": {
//                 "id": { "type": "string", "format": "uuid" },
//                 "name": { "type": "string" },
//                 "type": { "type": "string", "enum": ["corporation", "nonProfit", "government", "educational", "mediaOutlet"] },
//                 "description": { "type": "string" },
//                 "website": { "type": "string", "format": "uri" },
//                 "location": { "$ref": "#/definitions/Location" },
//                 "foundingDate": { "type": "string", "format": "date-time" },
//                 "employees": { "type": "integer", "minimum": 0 },
//                 "industry": { "type": "string" },
//                 "socialMediaProfiles": {
//                     "type": "object",
//                     "additionalProperties": { "type": "string", "format": "uri" }
//                 },
//                 "contactInfo": { "$ref": "#/definitions/ContactInfo" }
//             },
//             "required": ["id", "name", "type"]
//         }
//         """
//     }
//     
//     // MARK: - EntityDetailsProvider Implementation
//     
//     public var entityType: EntityType {
//         .organization
//     }
//     
//     public var entityName: String {
//         name
//     }
//     
//     public var entityDescription: String? {
//         orgDescription
//     }
//     
//     public var entityLocation: Location? {
//         location
//     }
//     
//     public var entityURL: URL? {
//         if let websiteStr = website {
//             return URL(string: websiteStr)
//         }
//         return nil
//     }
//     
//     public var entityImageURL: URL? {
//         nil // Organizations don't have a direct image URL in the current model
//     }
//     
//     public var entityIdentifier: String {
//         id
//     }
//     
//     public var entityMetadata: [String: String] {
//         var metadata: [String: String] = [
//             "type": type ?? "Unknown"
//         ]
//         return metadata
//     }
// 
//     public func getDetailedDescription() -> String {
//         var description = "\(name)"
//         
//         if let desc = orgDescription {
//             description += "\n\n\(desc)"
//         }
//         
//         if let type = type {
//             description += "\nType: \(type)"
//         }
//         
//         if let website = website {
//             description += "\nWebsite: \(website)"
//         }
//         
//         if let location = location {
//             description += "\nLocation: \(location.name)"
//         }
//         
//         if let contacts = contactInfo, !contacts.isEmpty {
//             description += "\n\nContact Information:"
//             for contact in contacts {
//                 if let email = contact.email {
//                     description += "\nEmail: \(email)"
//                 }
//                 if let phone = contact.phone {
//                     description += "\nPhone: \(phone)"
//                 }
//             }
//         }
//         
//         return description
//     }
// }

// File: Person.swift
// //
// //  Person.swift
// //  UtahNewsData
// //
// //  Created by Mark Evans on [date].
// //
// //  Updated to include additional properties for public interest/notability.
// 
// /*
//  # Person Model
// 
//  This file defines the Person model, which represents individuals in the UtahNewsData system.
//  The Person model is one of the core entity types and can be related to many other entities
//  such as organizations, news stories, quotes, and more.
// 
//  ## Key Features:
// 
//  1. Core identification (id, name, details)
//  2. Biographical information (biography, birth/death dates, nationality)
//  3. Professional details (occupation, achievements)
//  4. Contact information (email, phone, website, address)
//  5. Location data (string representation and coordinates)
//  6. Social media presence
// 
//  ## Usage:
// 
//  ```swift
//  // Create a basic person
//  let person = Person(
//      name: "Jane Doe",
//      details: "Reporter for Utah News Network"
//  )
// 
//  // Create a person with more details
//  let detailedPerson = Person(
//      name: "John Smith",
//      details: "Political analyst",
//      biography: "John Smith is a political analyst with 15 years of experience...",
//      occupation: "Political Analyst",
//      nationality: "American",
//      notableAchievements: ["Published 3 books", "Regular contributor to major news outlets"]
//  )
// 
//  // Add a relationship to another entity
//  var updatedPerson = person
//  updatedPerson.relationships.append(
//      Relationship(
//          id: organization.id,
//          type: .organization,
//          displayName: "Works at",
//          context: "Senior reporter since 2020"
//      )
//  )
//  ```
// 
//  The Person model implements EntityDetailsProvider, which allows it to generate
//  rich text descriptions for RAG systems.
//  */
// 
// import SwiftUI
// import Foundation
// import SwiftSoup
// 
// /// Represents an educational qualification or degree
// public struct Education: Codable, Hashable, Equatable, Sendable {
//     /// Name of the educational institution
//     public var institution: String
//     
//     /// Type of degree or qualification (e.g., "Bachelor's", "Master's", "Ph.D.")
//     public var degree: String?
//     
//     /// Field of study
//     public var field: String?
//     
//     /// Year the degree was awarded
//     public var year: Int?
//     
//     /// Creates a new Education instance
//     /// - Parameters:
//     ///   - institution: Name of the educational institution
//     ///   - degree: Type of degree or qualification
//     ///   - field: Field of study
//     ///   - year: Year the degree was awarded
//     public init(
//         institution: String,
//         degree: String? = nil,
//         field: String? = nil,
//         year: Int? = nil
//     ) {
//         self.institution = institution
//         self.degree = degree
//         self.field = field
//         self.year = year
//     }
// }
// 
// /// Represents a person in the news data system.
// /// This can be a journalist, public figure, expert, or any individual
// /// relevant to news content.
// public struct Person: AssociatedData, Codable, Identifiable, Hashable, EntityDetailsProvider,
//     JSONSchemaProvider, Sendable
// {
//     // MARK: - Core Properties
// 
//     /// Unique identifier for the person
//     public var id: String
// 
//     /// Relationships to other entities (organizations, locations, etc.)
//     public var relationships: [Relationship] = []
// 
//     /// The person's full name
//     public var name: String
// 
//     /// Brief description or summary of the person
//     public var details: String
// 
//     // MARK: - Additional Public Figure Properties
// 
//     /// Detailed biography or background information
//     public var biography: String?
// 
//     /// Date of birth, if known
//     public var birthDate: Date?
// 
//     /// Date of death, if applicable
//     public var deathDate: Date?
// 
//     /// Professional occupation or role
//     public var occupation: String?
// 
//     /// Nationality or citizenship
//     public var nationality: String?
// 
//     /// List of significant achievements or contributions
//     public var notableAchievements: [String]?
// 
//     /// URL to a profile image or photo
//     public var imageURL: String?
// 
//     /// Text description of location (e.g., "Salt Lake City, Utah")
//     public var locationString: String?
// 
//     /// Latitude coordinate for precise location
//     public var locationLatitude: Double?
// 
//     /// Longitude coordinate for precise location
//     public var locationLongitude: Double?
// 
//     /// Email address for contact
//     public var email: String?
// 
//     /// Personal or professional website
//     public var website: String?
// 
//     /// Phone number for contact
//     public var phone: String?
// 
//     /// Physical address
//     public var address: String?
// 
//     /// Dictionary of social media platforms and corresponding handles
//     /// Example: ["Twitter": "@janedoe", "LinkedIn": "jane-doe"]
//     public var socialMediaHandles: [String: String]?
// 
//     // MARK: - Initializer
// 
//     /// Creates a new Person instance with the specified properties.
//     ///
//     /// - Parameters:
//     ///   - id: Unique identifier (defaults to a new UUID string)
//     ///   - relationships: Array of relationships to other entities (defaults to empty)
//     ///   - name: The person's full name
//     ///   - details: Brief description or summary
//     ///   - biography: Detailed background information
//     ///   - birthDate: Date of birth
//     ///   - deathDate: Date of death, if applicable
//     ///   - occupation: Professional role or job title
//     ///   - nationality: Citizenship or nationality
//     ///   - notableAchievements: List of significant accomplishments
//     ///   - imageURL: URL to a profile image
//     ///   - locationString: Text description of location
//     ///   - locationLatitude: Latitude coordinate
//     ///   - locationLongitude: Longitude coordinate
//     ///   - email: Contact email address
//     ///   - website: Personal or professional website
//     ///   - phone: Contact phone number
//     ///   - address: Physical address
//     ///   - socialMediaHandles: Dictionary of platform names and handles
//     public init(
//         id: String = UUID().uuidString,
//         relationships: [Relationship] = [],
//         name: String,
//         details: String,
//         biography: String? = nil,
//         birthDate: Date? = nil,
//         deathDate: Date? = nil,
//         occupation: String? = nil,
//         nationality: String? = nil,
//         notableAchievements: [String]? = nil,
//         imageURL: String? = nil,
//         locationString: String? = nil,
//         locationLatitude: Double? = nil,
//         locationLongitude: Double? = nil,
//         email: String? = nil,
//         website: String? = nil,
//         phone: String? = nil,
//         address: String? = nil,
//         socialMediaHandles: [String: String]? = [:]
//     ) {
//         self.id = id
//         self.relationships = relationships
//         self.name = name
//         self.details = details
// 
//         self.biography = biography
//         self.birthDate = birthDate
//         self.deathDate = deathDate
//         self.occupation = occupation
//         self.nationality = nationality
//         self.notableAchievements = notableAchievements
// 
//         self.imageURL = imageURL
//         self.locationString = locationString
//         self.locationLatitude = locationLatitude
//         self.locationLongitude = locationLongitude
//         self.email = email
//         self.website = website
//         self.phone = phone
//         self.address = address
//         self.socialMediaHandles = socialMediaHandles
//     }
// 
//     // MARK: - Decodable
// 
//     /// Creates a Person instance by decoding from the given decoder.
//     /// Provides fallbacks for optional properties and generates a UUID if id is missing.
//     ///
//     /// - Parameter decoder: The decoder to read data from
//     /// - Throws: An error if decoding fails
//     public init(from decoder: Decoder) throws {
//         let container = try decoder.container(keyedBy: CodingKeys.self)
//         self.name = try container.decode(String.self, forKey: .name)
//         self.details = try container.decode(String.self, forKey: .details)
//         self.id = (try? container.decode(String.self, forKey: .id)) ?? UUID().uuidString
//         self.relationships =
//             (try? container.decode([Relationship].self, forKey: .relationships)) ?? []
// 
//         self.biography = try? container.decode(String.self, forKey: .biography)
//         self.birthDate = try? container.decode(Date.self, forKey: .birthDate)
//         self.deathDate = try? container.decode(Date.self, forKey: .deathDate)
//         self.occupation = try? container.decode(String.self, forKey: .occupation)
//         self.nationality = try? container.decode(String.self, forKey: .nationality)
//         self.notableAchievements = try? container.decode(
//             [String].self, forKey: .notableAchievements)
// 
//         // New properties decoding
//         self.imageURL = try? container.decode(String.self, forKey: .imageURL)
//         self.locationString = try? container.decode(String.self, forKey: .locationString)
//         self.locationLatitude = try? container.decode(Double.self, forKey: .locationLatitude)
//         self.locationLongitude = try? container.decode(Double.self, forKey: .locationLongitude)
//         self.email = try? container.decode(String.self, forKey: .email)
//         self.website = try? container.decode(String.self, forKey: .website)
//         self.phone = try? container.decode(String.self, forKey: .phone)
//         self.address = try? container.decode(String.self, forKey: .address)
//         self.socialMediaHandles = try? container.decode(
//             [String: String].self, forKey: .socialMediaHandles)
//     }
// 
//     // MARK: - Encodable
// 
//     /// Encodes the Person instance to the given encoder.
//     ///
//     /// - Parameter encoder: The encoder to write data to
//     /// - Throws: An error if encoding fails
//     public func encode(to encoder: Encoder) throws {
//         var container = encoder.container(keyedBy: CodingKeys.self)
//         try container.encode(id, forKey: .id)
//         try container.encode(relationships, forKey: .relationships)
//         try container.encode(name, forKey: .name)
//         try container.encode(details, forKey: .details)
// 
//         try container.encode(biography, forKey: .biography)
//         try container.encode(birthDate, forKey: .birthDate)
//         try container.encode(deathDate, forKey: .deathDate)
//         try container.encode(occupation, forKey: .occupation)
//         try container.encode(nationality, forKey: .nationality)
//         try container.encode(notableAchievements, forKey: .notableAchievements)
// 
//         // New properties encoding
//         try container.encode(imageURL, forKey: .imageURL)
//         try container.encode(locationString, forKey: .locationString)
//         try container.encode(locationLatitude, forKey: .locationLatitude)
//         try container.encode(locationLongitude, forKey: .locationLongitude)
//         try container.encode(email, forKey: .email)
//         try container.encode(website, forKey: .website)
//         try container.encode(phone, forKey: .phone)
//         try container.encode(address, forKey: .address)
//         try container.encode(socialMediaHandles, forKey: .socialMediaHandles)
//     }
// 
//     // MARK: - Coding Keys
// 
//     /// Keys used for encoding and decoding Person instances
//     enum CodingKeys: String, CodingKey {
//         case id, relationships, name, details
//         case biography, birthDate, deathDate, occupation, nationality, notableAchievements
//         // New keys added
//         case imageURL, locationString, locationLatitude, locationLongitude, email, website, phone,
//             address, socialMediaHandles
//     }
// 
//     // MARK: - EntityDetailsProvider Implementation
// 
//     /// Generates a detailed description of the person for RAG context.
//     /// This includes biographical information, professional details,
//     /// achievements, location, and contact information.
//     ///
//     /// - Returns: A formatted string containing the person's details
//     public func getDetailedDescription() -> String {
//         var description = details + "\n\n"
// 
//         if let bio = biography {
//             description += "**Biography**: \(bio)\n\n"
//         }
// 
//         if let occupation = occupation {
//             description += "**Occupation**: \(occupation)\n"
//         }
// 
//         if let nationality = nationality {
//             description += "**Nationality**: \(nationality)\n"
//         }
// 
//         // Add birth/death dates if available
//         let dateFormatter = DateFormatter()
//         dateFormatter.dateStyle = .medium
// 
//         if let birthDate = birthDate {
//             description += "**Born**: \(dateFormatter.string(from: birthDate))"
//             if let deathDate = deathDate {
//                 description += " | **Died**: \(dateFormatter.string(from: deathDate))"
//             }
//             description += "\n"
//         } else if let deathDate = deathDate {
//             description += "**Died**: \(dateFormatter.string(from: deathDate))\n"
//         }
// 
//         // Add notable achievements
//         if let achievements = notableAchievements, !achievements.isEmpty {
//             description += "\n**Notable Achievements**:\n"
//             for achievement in achievements {
//                 description += "- \(achievement)\n"
//             }
//             description += "\n"
//         }
// 
//         // Add location information
//         if let location = locationString {
//             description += "**Location**: \(location)\n"
//         }
// 
//         // Add contact information
//         var contactInfo = ""
//         if let email = email {
//             contactInfo += "Email: \(email) | "
//         }
//         if let phone = phone {
//             contactInfo += "Phone: \(phone) | "
//         }
//         if let website = website {
//             contactInfo += "Website: \(website) | "
//         }
// 
//         if !contactInfo.isEmpty {
//             // Remove trailing separator
//             contactInfo = String(contactInfo.dropLast(3))
//             description += "\n**Contact**: \(contactInfo)\n"
//         }
// 
//         // Add social media handles
//         if let socialMedia = socialMediaHandles, !socialMedia.isEmpty {
//             description += "\n**Social Media**:\n"
//             for (platform, handle) in socialMedia {
//                 description += "- \(platform): \(handle)\n"
//             }
//         }
// 
//         return description
//     }
// 
//     // MARK: - JSONSchemaProvider Implementation
//     
//     public static var jsonSchema: String {
//         """
//         {
//             "type": "object",
//             "properties": {
//                 "id": { "type": "string", "format": "uuid" },
//                 "name": { "type": "string" },
//                 "title": { "type": "string" },
//                 "biography": { "type": "string" },
//                 "organization": { "$ref": "#/definitions/Organization" },
//                 "expertise": {
//                     "type": "array",
//                     "items": { "type": "string" }
//                 },
//                 "education": {
//                     "type": "array",
//                     "items": {
//                         "type": "object",
//                         "properties": {
//                             "institution": { "type": "string" },
//                             "degree": { "type": "string" },
//                             "field": { "type": "string" },
//                             "year": { "type": "integer" }
//                         }
//                     }
//                 },
//                 "contactInfo": { "$ref": "#/definitions/ContactInfo" },
//                 "socialMediaProfiles": {
//                     "type": "object",
//                     "additionalProperties": { "type": "string", "format": "uri" }
//                 },
//                 "imageURL": { "type": "string", "format": "uri" },
//                 "achievements": {
//                     "type": "array",
//                     "items": { "type": "string" }
//                 }
//             },
//             "required": ["id", "name"]
//         }
//         """
//     }
// }

// File: Poll.swift
// //
// //  Poll.swift
// //  NewsCapture
// //
// //  Created by Mark Evans on 10/25/24.
// //
// 
// /*
//  # Poll Model
// 
//  This file defines the Poll model, which represents opinion polls and surveys
//  in the UtahNewsData system. Polls capture public opinion on various topics
//  and issues, providing valuable data for news reporting and analysis.
// 
//  ## Key Features:
// 
//  1. Poll content (question, options)
//  2. Response tracking
//  3. Source attribution
//  4. Timing information (dateConducted)
//  5. Relationship tracking with other entities
// 
//  ## Usage:
// 
//  ```swift
//  // Create a poll
//  let pollster = Source(name: "Utah Opinion Research", url: "https://example.com")
// 
//  let poll = Poll(
//      question: "Do you support the proposed water conservation bill?",
//      options: ["Yes", "No", "Undecided"],
//      dateConducted: Date(),
//      source: pollster
//  )
// 
//  // Add responses
//  poll.responses = [
//      PollResponse(selectedOption: "Yes"),
//      PollResponse(selectedOption: "Yes"),
//      PollResponse(selectedOption: "No"),
//      PollResponse(selectedOption: "Undecided")
//  ]
// 
//  // Associate with related entities
//  let topicRelationship = Relationship(
//      id: waterConservationCategory.id,
//      type: .category,
//      displayName: "Related to"
//  )
//  poll.relationships.append(topicRelationship)
// 
//  let billRelationship = Relationship(
//      id: senateBill101.id,
//      type: .legalDocument,
//      displayName: "About"
//  )
//  poll.relationships.append(billRelationship)
//  ```
// 
//  The Poll model implements AssociatedData, allowing it to maintain
//  relationships with other entities in the system, such as categories,
//  legal documents, and news stories.
//  */
// 
// import SwiftUI
// import Foundation
// import SwiftSoup
// 
// /// Represents an option in a poll that users can vote for.
// public struct PollOption: Codable, Hashable, Equatable, Sendable {
//     /// The text of the poll option
//     public var text: String
//     
//     /// The number of votes this option has received
//     public var votes: Int
//     
//     /// Creates a new poll option.
//     ///
//     /// - Parameters:
//     ///   - text: The text of the poll option
//     ///   - votes: The number of votes this option has received
//     public init(text: String, votes: Int = 0) {
//         self.text = text
//         self.votes = votes
//     }
// }
// 
// /// Represents a poll or survey in the news system.
// /// Polls capture public opinion on various topics and issues,
// /// providing valuable data for news reporting and analysis.
// public struct Poll: AssociatedData, JSONSchemaProvider, Codable, Identifiable, Hashable, Equatable, Sendable {
//     /// Unique identifier for the poll
//     public var id: String
//     
//     /// Relationships to other entities in the system
//     public var relationships: [Relationship] = []
//     
//     /// The question being asked in the poll
//     public var question: String
//     
//     /// Possible answer options for the poll
//     public var options: [PollOption]
//     
//     /// Collected responses to the poll
//     public var responses: [PollResponse] = []
//     
//     /// When the poll was conducted
//     public var dateConducted: Date
//     
//     /// Organization or entity that conducted the poll
//     public var source: String
//     
//     /// Statistical margin of error for the poll results
//     public var marginOfError: Double?
//     
//     /// Number of people who participated in the poll
//     public var sampleSize: Int?
//     
//     /// Description of the demographic groups included in the poll
//     public var demographics: String?
//     
//     /// The name property required by the AssociatedData protocol.
//     /// Returns the poll question.
//     public var name: String {
//         return question
//     }
//     
//     /// Creates a new poll with the specified properties.
//     ///
//     /// - Parameters:
//     ///   - id: Unique identifier for the poll (defaults to a new UUID string)
//     ///   - question: The question being asked in the poll
//     ///   - options: Possible answer options for the poll
//     ///   - dateConducted: When the poll was conducted
//     ///   - source: Organization or entity that conducted the poll
//     ///   - marginOfError: Statistical margin of error for the poll results
//     ///   - sampleSize: Number of people who participated in the poll
//     ///   - demographics: Description of the demographic groups included in the poll
//     public init(
//         id: String = UUID().uuidString,
//         question: String,
//         options: [PollOption],
//         dateConducted: Date,
//         source: String,
//         marginOfError: Double? = nil,
//         sampleSize: Int? = nil,
//         demographics: String? = nil
//     ) {
//         self.id = id
//         self.question = question
//         self.options = options
//         self.dateConducted = dateConducted
//         self.source = source
//         self.marginOfError = marginOfError
//         self.sampleSize = sampleSize
//         self.demographics = demographics
//     }
//     
//     /// Returns the count of responses for each option.
//     ///
//     /// - Returns: A dictionary mapping option strings to response counts
//     public func getResults() -> [String: Int] {
//         var results: [String: Int] = [:]
// 
//         // Initialize all options with zero responses
//         for option in options {
//             results[option.text] = 0
//         }
// 
//         // Count responses for each option
//         for response in responses {
//             if let count = results[response.selectedOption] {
//                 results[response.selectedOption] = count + 1
//             }
//         }
// 
//         return results
//     }
// 
//     // MARK: - JSONSchemaProvider Implementation
//     
//     public static var jsonSchema: String {
//         """
//         {
//             "type": "object",
//             "properties": {
//                 "id": { "type": "string", "format": "uuid" },
//                 "title": { "type": "string" },
//                 "question": { "type": "string" },
//                 "options": {
//                     "type": "array",
//                     "items": {
//                         "type": "object",
//                         "properties": {
//                             "text": { "type": "string" },
//                             "votes": { "type": "integer", "minimum": 0 },
//                             "percentage": { "type": "number", "minimum": 0, "maximum": 100 }
//                         },
//                         "required": ["text"]
//                     }
//                 },
//                 "totalResponses": { "type": "integer", "minimum": 0 },
//                 "methodology": { "type": "string" },
//                 "dateRange": {
//                     "type": "object",
//                     "properties": {
//                         "start": { "type": "string", "format": "date-time" },
//                         "end": { "type": "string", "format": "date-time" }
//                     },
//                     "required": ["start", "end"]
//                 },
//                 "marginOfError": { "type": "number", "minimum": 0 },
//                 "demographics": {
//                     "type": "object",
//                     "additionalProperties": { "type": "string" }
//                 },
//                 "source": { "type": "string" }
//             },
//             "required": ["id", "title", "question", "options"]
//         }
//         """
//     }
// }
// 
// /// Represents a single response to a poll.
// /// Each response captures the selected option and optionally
// /// the person who responded.
// public struct PollResponse: BaseEntity, Codable, Hashable, Sendable {
//     /// Unique identifier for the poll response
//     public var id: String
// 
//     /// The name or description of this poll response
//     public var name: String {
//         return "Response to poll: \(selectedOption)"
//     }
// 
//     /// Person who responded to the poll (optional for anonymous polls)
//     public var respondent: Person?
// 
//     /// The option selected by the respondent
//     public var selectedOption: String
// 
//     /// Creates a new poll response with the specified properties.
//     ///
//     /// - Parameters:
//     ///   - id: Unique identifier for the poll response (defaults to a new UUID string)
//     ///   - respondent: Person who responded to the poll (optional for anonymous polls)
//     ///   - selectedOption: The option selected by the respondent
//     public init(id: String = UUID().uuidString, respondent: Person? = nil, selectedOption: String) {
//         self.id = id
//         self.respondent = respondent
//         self.selectedOption = selectedOption
//     }
// }

// File: Quote.swift
// //
// //  Quote.swift
// //  UtahNewsData
// //
// //  Created by Mark Evans on 2/12/25.
// //
// 
// /*
//  # Quote Model
// 
//  This file defines the Quote model, which represents direct quotations from individuals
//  in the UtahNewsData system. Quotes can be associated with articles, news events, and other
//  content types, providing attribution and context for statements.
// 
//  ## Key Features:
// 
//  1. Core content (text of the quote)
//  2. Attribution (speaker, source)
//  3. Contextual information (date, location, topic)
//  4. Related entities
// 
//  ## Usage:
// 
//  ```swift
//  // Create a basic quote
//  let basicQuote = Quote(
//      text: "We're committed to improving Utah's water infrastructure.",
//      speaker: governor // Person entity
//  )
// 
//  // Create a detailed quote with context
//  let detailedQuote = Quote(
//      text: "The new legislation represents a significant step forward in addressing our state's water conservation needs.",
//      speaker: waterDirector, // Person entity
//      source: pressConference, // NewsEvent entity
//      date: Date(),
//      context: "Statement made during press conference announcing new water conservation bill",
//      topics: ["Water Conservation", "Legislation", "Infrastructure"],
//      location: capitolBuilding // Location entity
//  )
// 
//  // Associate quote with an article
//  let article = Article(
//      title: "Utah Passes Water Conservation Bill",
//      body: ["The Utah Legislature passed a comprehensive water conservation bill on Monday..."]
//  )
// 
//  // Create relationship between quote and article
//  let relationship = Relationship(
//      fromEntity: detailedQuote,
//      toEntity: article,
//      type: .quotedIn
//  )
// 
//  detailedQuote.relationships.append(relationship)
//  article.relationships.append(relationship)
//  ```
// 
//  The Quote model implements EntityDetailsProvider, allowing it to generate
//  rich text descriptions for RAG (Retrieval Augmented Generation) systems.
//  */
// 
// import Foundation
// import SwiftSoup
// 
// /// Represents a direct quotation from an individual in the UtahNewsData system.
// /// Quotes can be associated with articles, news events, and other content types,
// /// providing attribution and context for statements.
// public struct Quote: Identifiable, EntityDetailsProvider, JSONSchemaProvider, Sendable {
//     /// Unique identifier for the quote
//     public var id: String = UUID().uuidString
// 
//     /// The name property required by the BaseEntity protocol
//     public var name: String {
//         return text.count > 50 ? String(text.prefix(47)) + "..." : text
//     }
// 
//     /// Relationships to other entities in the system
//     public var relationships: [Relationship] = []
// 
//     /// The actual text of the quotation
//     public var text: String
// 
//     /// The person who made the statement
//     public var speaker: Person?
// 
//     /// The event, article, or other source where the quote originated
//     public var source: (any EntityDetailsProvider)?
// 
//     /// When the statement was made
//     public var date: Date?
// 
//     /// Additional information about the circumstances of the quote
//     public var context: String?
// 
//     /// Subject areas or keywords related to the quote
//     public var topics: [String]?
// 
//     /// Where the statement was made
//     public var location: Location?
// 
//     /// Creates a new Quote with the specified properties.
//     ///
//     /// - Parameters:
//     ///   - text: The actual text of the quotation
//     ///   - speaker: The person who made the statement
//     ///   - source: The event, article, or other source where the quote originated
//     ///   - date: When the statement was made
//     ///   - context: Additional information about the circumstances of the quote
//     ///   - topics: Subject areas or keywords related to the quote
//     ///   - location: Where the statement was made
//     public init(
//         text: String,
//         speaker: Person? = nil,
//         source: (any EntityDetailsProvider)? = nil,
//         date: Date? = nil,
//         context: String? = nil,
//         topics: [String]? = nil,
//         location: Location? = nil
//     ) {
//         self.text = text
//         self.speaker = speaker
//         self.source = source
//         self.date = date
//         self.context = context
//         self.topics = topics
//         self.location = location
//     }
// 
//     /// Generates a detailed text description of the quote for use in RAG systems.
//     /// The description includes the quote text, speaker, source, and contextual information.
//     ///
//     /// - Returns: A formatted string containing the quote's details
//     public func getDetailedDescription() -> String {
//         var description = "QUOTE: \"\(text)\""
// 
//         if let speaker = speaker {
//             description += "\nSpeaker: \(speaker.name)"
//         }
// 
//         if let date = date {
//             let formatter = DateFormatter()
//             formatter.dateStyle = .medium
//             description += "\nDate: \(formatter.string(from: date))"
//         }
// 
//         if let context = context {
//             description += "\nContext: \(context)"
//         }
// 
//         if let location = location {
//             description += "\nLocation: \(location.name)"
//         }
// 
//         if let topics = topics, !topics.isEmpty {
//             description += "\nTopics: \(topics.joined(separator: ", "))"
//         }
// 
//         return description
//     }
// 
//     /// JSON schema for LLM responses
//     public static var jsonSchema: String {
//         """
//         {
//             "type": "object",
//             "properties": {
//                 "id": {"type": "string"},
//                 "text": {"type": "string"},
//                 "speaker": {"$ref": "#/definitions/Person"},
//                 "source": {"$ref": "#/definitions/NewsEvent", "optional": true},
//                 "date": {"type": "string", "format": "date-time", "optional": true},
//                 "context": {"type": "string", "optional": true},
//                 "topics": {
//                     "type": "array",
//                     "items": {"type": "string"},
//                     "optional": true
//                 },
//                 "location": {"$ref": "#/definitions/Location", "optional": true},
//                 "sentiment": {"type": "string", "optional": true},
//                 "verificationStatus": {
//                     "type": "string",
//                     "enum": ["verified", "unverified", "disputed", "retracted"],
//                     "optional": true
//                 },
//                 "metadata": {
//                     "type": "object",
//                     "additionalProperties": true,
//                     "optional": true
//                 }
//             },
//             "required": ["id", "text", "speaker"],
//             "definitions": {
//                 "Person": {"$ref": "Person.jsonSchema"},
//                 "NewsEvent": {"$ref": "NewsEvent.jsonSchema"},
//                 "Location": {"$ref": "Location.jsonSchema"}
//             }
//         }
//         """
//     }
// 
//     // MARK: - HTMLParsable Implementation
//     
//     public static func parse(from document: Document) throws -> Quote {
//         let text = try extractQuoteText(from: document)
//         let speaker = try extractSpeaker(from: document)
//         let sourceString = try extractSource(from: document)
//         var source: (any EntityDetailsProvider)?
//         if let str = sourceString {
//             source = NewsEvent(
//                 title: str,
//                 date: Date(),  // Use current date since we don't have a specific date from the source
//                 description: nil,
//                 startDate: nil,
//                 endDate: nil,
//                 location: nil,
//                 participants: nil,
//                 organizations: nil,
//                 relatedEvents: nil,
//                 relationships: []
//             ) as any EntityDetailsProvider
//         } else {
//             source = nil
//         }
//         let date = try extractDate(from: document)
//         let context = try extractContext(from: document)
//         let location = try extractLocation(from: document)
//         
//         return Quote(
//             text: text,
//             speaker: speaker,
//             source: source,
//             date: date,
//             context: context,
//             topics: [],
//             location: location
//         )
//     }
//     
//     // MARK: - Private Helper Methods
//     
//     private static func extractQuoteText(from document: Document) throws -> String {
//         let textSelectors = [
//             "[itemprop='text']",
//             ".quote-text",
//             ".quote-content",
//             "blockquote"
//         ]
//         
//         for selector in textSelectors {
//             if let text = try document.select(selector).first()?.text(),
//                !text.isEmpty {
//                 return text
//             }
//         }
//         
//         throw ParsingError.missingRequiredField("quote text")
//     }
//     
//     private static func extractSpeaker(from document: Document) throws -> Person? {
//         let speakerSelectors = [
//             "[itemprop='speaker']",
//             ".quote-speaker",
//             ".quote-author",
//             ".speaker-info"
//         ]
//         
//         for selector in speakerSelectors {
//             if let element = try document.select(selector).first() {
//                 let name = try element.select("[itemprop='name']").first()?.text()
//                 let title = try element.select("[itemprop='jobTitle']").first()?.text()
//                 let organization = try element.select("[itemprop='affiliation']").first()?.text()
//                 
//                 if let name = name {
//                     return Person(
//                         name: name,
//                         details: title ?? "",
//                         biography: nil,
//                         birthDate: nil,
//                         deathDate: nil,
//                         occupation: organization,
//                         nationality: nil,
//                         notableAchievements: nil,
//                         imageURL: nil,
//                         locationString: nil,
//                         locationLatitude: nil,
//                         locationLongitude: nil,
//                         email: nil,
//                         website: nil,
//                         phone: nil,
//                         address: nil,
//                         socialMediaHandles: nil
//                     )
//                 }
//             }
//         }
//         
//         return nil
//     }
//     
//     private static func extractSource(from document: Document) throws -> String? {
//         let sourceSelectors = [
//             "[itemprop='source']",
//             ".quote-source",
//             ".source-info",
//             "meta[property='article:publisher']"
//         ]
//         
//         for selector in sourceSelectors {
//             if selector.contains("meta") {
//                 if let source = try document.select(selector).first()?.attr("content"),
//                    !source.isEmpty {
//                     return source
//                 }
//             } else {
//                 if let source = try document.select(selector).first()?.text(),
//                    !source.isEmpty {
//                     return source
//                 }
//             }
//         }
//         
//         return nil
//     }
//     
//     private static func extractDate(from document: Document) throws -> Date? {
//         let dateSelectors = [
//             "[itemprop='dateCreated']",
//             ".quote-date",
//             "time[datetime]",
//             "meta[property='article:published_time']"
//         ]
//         
//         for selector in dateSelectors {
//             if let dateStr = try document.select(selector).first()?.attr(selector.contains("meta") ? "content" : "datetime") {
//                 for formatter in [DateFormatter.iso8601Full, DateFormatter.iso8601, DateFormatter.standardDate] {
//                     if let date = formatter.date(from: dateStr) {
//                         return date
//                     }
//                 }
//             }
//         }
//         
//         return nil
//     }
//     
//     private static func extractContext(from document: Document) throws -> String? {
//         let contextSelectors = [
//             "[itemprop='context']",
//             ".quote-context",
//             ".context-info",
//             ".quote-background"
//         ]
//         
//         for selector in contextSelectors {
//             if let context = try document.select(selector).first()?.text(),
//                !context.isEmpty {
//                 return context
//             }
//         }
//         
//         return nil
//     }
//     
//     private static func extractLocation(from document: Document) throws -> Location? {
//         for selector in ["[itemprop='location']", ".quote-location", ".location-info"] {
//             if let element = try document.select(selector).first() {
//                 let address = try element.select("[itemprop='streetAddress']").first()?.text()
//                 let city = try element.select("[itemprop='addressLocality']").first()?.text()
//                 let state = try element.select("[itemprop='addressRegion']").first()?.text()
//                 let zipCode = try element.select("[itemprop='postalCode']").first()?.text()
//                 let country = try element.select("[itemprop='addressCountry']").first()?.text()
//                 
//                 if address != nil || city != nil || state != nil || zipCode != nil || country != nil {
//                     return Location(
//                         latitude: nil,
//                         longitude: nil,
//                         address: address,
//                         city: city,
//                         state: state,
//                         zipCode: zipCode,
//                         country: country,
//                         relationships: []
//                     )
//                 }
//             }
//         }
//         
//         return nil
//     }
// }
// 
// // MARK: - Equatable & Hashable
// extension Quote: Equatable, Hashable {
//     public static func == (lhs: Quote, rhs: Quote) -> Bool {
//         lhs.id == rhs.id && lhs.text == rhs.text && lhs.speaker == rhs.speaker
//             && lhs.date == rhs.date && lhs.context == rhs.context && lhs.topics == rhs.topics
//             && lhs.location == rhs.location
//         // Note: source is not compared as it's an EntityDetailsProvider which doesn't conform to Equatable
//     }
// 
//     public func hash(into hasher: inout Hasher) {
//         hasher.combine(id)
//         hasher.combine(text)
//         hasher.combine(speaker)
//         hasher.combine(date)
//         hasher.combine(context)
//         hasher.combine(topics)
//         hasher.combine(location)
//         // Note: source is not hashed as it's an EntityDetailsProvider which doesn't conform to Hashable
//     }
// }
// 
// // MARK: - Codable
// extension Quote: Codable {
//     private enum CodingKeys: String, CodingKey {
//         case id, relationships, text, speaker, date, context, topics, location
//         // Note: source is excluded as it's an EntityDetailsProvider which doesn't conform to Codable
//     }
// 
//     public init(from decoder: Decoder) throws {
//         let container = try decoder.container(keyedBy: CodingKeys.self)
// 
//         id = try container.decode(String.self, forKey: .id)
//         relationships = try container.decode([Relationship].self, forKey: .relationships)
//         text = try container.decode(String.self, forKey: .text)
//         speaker = try container.decodeIfPresent(Person.self, forKey: .speaker)
//         date = try container.decodeIfPresent(Date.self, forKey: .date)
//         context = try container.decodeIfPresent(String.self, forKey: .context)
//         topics = try container.decodeIfPresent([String].self, forKey: .topics)
//         location = try container.decodeIfPresent(Location.self, forKey: .location)
//         source = nil  // Cannot decode EntityDetailsProvider
//     }
// 
//     public func encode(to encoder: Encoder) throws {
//         var container = encoder.container(keyedBy: CodingKeys.self)
// 
//         try container.encode(id, forKey: .id)
//         try container.encode(relationships, forKey: .relationships)
//         try container.encode(text, forKey: .text)
//         try container.encode(speaker, forKey: .speaker)
//         try container.encode(date, forKey: .date)
//         try container.encode(context, forKey: .context)
//         try container.encode(topics, forKey: .topics)
//         try container.encode(location, forKey: .location)
//         // source is not encoded as it's an EntityDetailsProvider which doesn't conform to Codable
//     }
// }

// File: ScrapeStory.swift
// //
// //  ScrapeStory.swift
// //  UtahNewsData
// //
// //  Created by Mark Evans on 11/26/24.
// //
// 
// /*
//  # ScrapeStory Model
// 
//  This file defines the ScrapeStory model and related response structures used for
//  web scraping operations in the UtahNewsData system. These models represent the raw
//  data extracted from news websites before it's processed into the system's domain models.
// 
//  ## Key Components:
// 
//  1. ScrapeStory: Raw story data extracted from a web page
//  2. StoryExtract: Collection of scraped stories
//  3. Response structures: Wrappers for API responses
// 
//  ## Usage:
// 
//  ```swift
//  // Process a scraped story into an Article
//  func processScrapedStory(story: ScrapeStory, baseURL: String) -> Article? {
//      return Article(from: story, baseURL: baseURL)
//  }
// 
//  // Handle a FirecrawlResponse from the scraping service
//  func handleScrapingResponse(response: FirecrawlResponse) {
//      if response.success {
//          for story in response.data.extract.stories {
//              if let article = processScrapedStory(story: story, baseURL: "https://example.com") {
//                  dataStore.addArticle(article)
//              }
//          }
//      } else {
//          print("Scraping operation failed")
//      }
//  }
//  ```
// 
//  The ScrapeStory model is designed to be a flexible container for raw scraped data,
//  with optional properties to accommodate the varying information available from
//  different news sources.
//  */
// 
// import Foundation
// 
// /// Collection of scraped stories from a web source.
// public struct StoryExtract: BaseEntity, Codable, Sendable {
//     /// Unique identifier for the story extract
//     public var id: String = UUID().uuidString
// 
//     /// The name or description of this story extract
//     public var name: String = "Story Extract"
// 
//     /// Array of scraped stories
//     public let stories: [ScrapeStory]
// 
//     /// Creates a new story extract with the specified stories.
//     /// - Parameter stories: Array of scraped stories
//     public init(stories: [ScrapeStory]) {
//         self.stories = stories
//     }
// }
// 
// /// Represents raw story data extracted from a web page.
// /// This is the initial data structure used before processing into domain models.
// public struct ScrapeStory: BaseEntity, Codable, Sendable {
//     /// Unique identifier for the scraped story
//     public var id: String
// 
//     /// The name or title of this scraped story
//     public var name: String {
//         return title ?? "Untitled Story"
//     }
// 
//     /// Title or headline of the story
//     public var title: String?
// 
//     /// Main text content of the story
//     public var textContent: String?
// 
//     /// URL where the story can be accessed
//     public var url: String?
// 
//     /// URL to the main image for the story
//     public var urlToImage: String?
// 
//     /// URLs to additional images in the story
//     public var additionalImages: [String]?
// 
//     /// When the story was published (as a string, needs parsing)
//     public var publishedAt: String?
// 
//     /// Author or creator of the story
//     public var author: String?
// 
//     /// Category or section the story belongs to
//     public var category: String?
// 
//     /// URL to video content associated with the story
//     public var videoURL: String?
// }
// 
// /// Response structure for a single story extraction API call.
// public struct SingleStoryResponse: BaseEntity, Codable, Sendable {
//     /// Unique identifier for the response
//     public var id: String = UUID().uuidString
// 
//     /// The name or description of this response
//     public var name: String = "Single Story Response"
// 
//     /// Whether the extraction was successful
//     public let success: Bool
// 
//     /// The extracted data
//     public let data: SingleStoryData
// }
// 
// /// Container for a single extracted story.
// public struct SingleStoryData: BaseEntity, Codable, Sendable {
//     /// Unique identifier for the data container
//     public var id: String = UUID().uuidString
// 
//     /// The name or description of this data container
//     public var name: String = "Single Story Data"
// 
//     /// The extracted story
//     public let extract: ScrapeStory
// }
// 
// /// Response structure for a batch crawling API call.
// public struct FirecrawlResponse: BaseEntity, Codable, Sendable {
//     /// Unique identifier for the response
//     public var id: String = UUID().uuidString
// 
//     /// The name or description of this response
//     public var name: String = "Firecrawl Response"
// 
//     /// Whether the crawling operation was successful
//     public let success: Bool
// 
//     /// The extracted data
//     public let data: FirecrawlData
// }
// 
// /// Container for batch extracted stories.
// public struct FirecrawlData: BaseEntity, Codable, Sendable {
//     /// Unique identifier for the data container
//     public var id: String = UUID().uuidString
// 
//     /// The name or description of this data container
//     public var name: String = "Firecrawl Data"
// 
//     /// Collection of extracted stories
//     public let extract: StoryExtract
// }

// File: SocialMediaPost.swift
// //
// //  SocialMediaPost.swift
// //  NewsCapture
// //
// //  Created by Mark Evans on 10/25/24.
// //
// 
// /*
//  # SocialMediaPost Model
//  
//  This file defines the SocialMediaPost model, which represents social media content
//  in the UtahNewsData system. Social media posts can include tweets, Facebook posts,
//  Instagram posts, and other content from social platforms that are relevant to news coverage.
//  
//  ## Key Features:
//  
//  1. Author attribution
//  2. Platform identification
//  3. Timing information (datePosted)
//  4. Content access (url)
//  5. Relationship tracking with other entities
//  
//  ## Usage:
//  
//  ```swift
//  // Create a social media post
//  let politician = Person(name: "Jane Smith", details: "State Senator")
//  
//  let tweet = SocialMediaPost(
//      author: politician,
//      platform: "Twitter",
//      datePosted: Date(),
//      content: "Proud to announce that the water conservation bill passed today with bipartisan support!"
//  )
//  
//  // Set the URL to the original post
//  tweet.url = URL(string: "https://twitter.com/janesmith/status/1234567890")
//  
//  // Associate with related entities
//  let billRelationship = Relationship(
//      id: senateBill101.id,
//      type: .legalDocument,
//      displayName: "References"
//  )
//  tweet.relationships.append(billRelationship)
//  ```
//  
//  The SocialMediaPost model implements AssociatedData, allowing it to maintain
//  relationships with other entities in the system, such as people, organizations,
//  and topics mentioned in the post.
//  */
// 
// import SwiftUI
// import Foundation
// import SwiftSoup
// 
// /// Represents different social media platforms
// public enum SocialPlatform: String, Codable, CaseIterable, Sendable {
//     /// Twitter/X platform
//     case twitter = "Twitter"
//     /// Facebook platform
//     case facebook = "Facebook"
//     /// Instagram platform
//     case instagram = "Instagram"
//     /// LinkedIn platform
//     case linkedin = "LinkedIn"
//     /// YouTube platform
//     case youtube = "YouTube"
//     /// TikTok platform
//     case tiktok = "TikTok"
//     /// Threads platform
//     case threads = "Threads"
//     /// Mastodon platform
//     case mastodon = "Mastodon"
//     /// Other social media platforms
//     case other = "Other"
//     
//     /// Returns the base URL for the platform
//     public var baseURL: String {
//         switch self {
//         case .twitter:
//             return "https://twitter.com"
//         case .facebook:
//             return "https://facebook.com"
//         case .instagram:
//             return "https://instagram.com"
//         case .linkedin:
//             return "https://linkedin.com"
//         case .youtube:
//             return "https://youtube.com"
//         case .tiktok:
//             return "https://tiktok.com"
//         case .threads:
//             return "https://threads.net"
//         case .mastodon:
//             return "" // Varies by instance
//         case .other:
//             return ""
//         }
//     }
// }
// 
// /// Represents a social media post in the news system.
// /// Social media posts can include tweets, Facebook posts, Instagram posts,
// /// and other content from social platforms that are relevant to news coverage.
// public struct SocialMediaPost: AssociatedData {
//     /// Unique identifier for the social media post
//     public var id: String
//     
//     /// Relationships to other entities in the system
//     public var relationships: [Relationship] = []
//     
//     /// Person or entity who created the post
//     public var author: Person
//     
//     /// Social media platform where the post was published (e.g., "Twitter", "Facebook")
//     public var platform: String
//     
//     /// When the post was published
//     public var datePosted: Date
//     
//     /// URL to the original post
//     public var url: URL?
//     
//     /// The name property required by the AssociatedData protocol.
//     /// Returns a descriptive name based on the author and platform.
//     public var name: String {
//         return "\(author.name)'s \(platform) post"
//     }
//     
//     /// Text content of the post
//     public var content: String?
//     
//     /// URLs to media (images, videos) included in the post
//     public var mediaURLs: [String]?
//     
//     /// Number of likes/favorites the post received
//     public var likeCount: Int?
//     
//     /// Number of shares/retweets the post received
//     public var shareCount: Int?
//     
//     /// Number of comments/replies the post received
//     public var commentCount: Int?
//     
//     /// Creates a new social media post with the specified properties.
//     ///
//     /// - Parameters:
//     ///   - id: Unique identifier for the post (defaults to a new UUID string)
//     ///   - author: Person or entity who created the post
//     ///   - platform: Social media platform where the post was published
//     ///   - datePosted: When the post was published
//     ///   - url: URL to the original post
//     ///   - content: Text content of the post
//     ///   - mediaURLs: URLs to media included in the post
//     ///   - likeCount: Number of likes/favorites the post received
//     ///   - shareCount: Number of shares/retweets the post received
//     ///   - commentCount: Number of comments/replies the post received
//     public init(
//         id: String = UUID().uuidString,
//         author: Person,
//         platform: String,
//         datePosted: Date,
//         url: URL? = nil,
//         content: String? = nil,
//         mediaURLs: [String]? = nil,
//         likeCount: Int? = nil,
//         shareCount: Int? = nil,
//         commentCount: Int? = nil
//     ) {
//         self.id = id
//         self.author = author
//         self.platform = platform
//         self.datePosted = datePosted
//         self.url = url
//         self.content = content
//         self.mediaURLs = mediaURLs
//         self.likeCount = likeCount
//         self.shareCount = shareCount
//         self.commentCount = commentCount
//     }
// }

// File: Source.swift
// //
// //  Source.swift
// //  NewsCapture
// //
// //  Created by Mark Evans on 10/25/24.
// //
// 
// /*
//  # Source Model
// 
//  This file defines the Source model, which represents news sources and information providers
//  in the UtahNewsData system. Sources can include news organizations, government agencies,
//  academic institutions, and other entities that produce or distribute news content.
// 
//  ## Key Features:
// 
//  1. Source identification and attribution
//  2. Credibility assessment
//  3. Categorization by type and subject area
//  4. Metadata for content discovery (siteMapURL, JSONSchema)
//  5. Relationship tracking with other entities
// 
//  ## Usage:
// 
//  ```swift
//  // Create a news source
//  let tribune = Source(
//      name: "Salt Lake Tribune",
//      url: URL(string: "https://www.sltrib.com")!,
//      credibilityRating: 4,
//      category: .news,
//      subCategory: .newspaper,
//      description: "Utah's largest newspaper, covering news, politics, business, and sports across the state."
//  )
// 
//  // Add sitemap information for content discovery
//  tribune.siteMapURL = URL(string: "https://www.sltrib.com/sitemap.xml")
// 
//  // Associate with related entities
//  let ownerRelationship = Relationship(
//      id: mediaGroup.id,
//      type: .organization,
//      displayName: "Owned By"
//  )
//  tribune.relationships.append(ownerRelationship)
//  ```
// 
//  The Source model implements AssociatedData, allowing it to maintain
//  relationships with other entities in the system, such as parent companies,
//  affiliated organizations, and key personnel.
//  */
// 
// import SwiftUI
// import Foundation
// import SwiftSoup
// 
// // By aligning the Source struct with the schema defined in NewsSource, you can decode
// // Firestore documents that match the NewsSource structure directly into Source.
// // This involves changing Source's properties (e.g., using a String for the id instead
// // of UUID, and adding category, subCategory, description, JSONSchema, etc.) so that
// // they match what's stored in your Firestore "sources" collection.
// 
// /// Represents a news source or information provider in the news system.
// /// Sources can include news organizations, government agencies, academic institutions,
// /// and other entities that produce or distribute news content.
// public struct Source: AssociatedData, Codable, Identifiable, Hashable, Equatable, JSONSchemaProvider, Sendable
// {
//     /// Unique identifier for the source
//     public var id: String
//     /// Relationships to other entities in the system
//     public var relationships: [Relationship] = []
//     /// Name of the news source or information provider
//     public var name: String
//     /// URL to the source's website or main page
//     public var url: String
//     /// Rating from 1-5 indicating the source's credibility and reliability
//     /// - 1: Low credibility (unreliable, frequent misinformation)
//     /// - 3: Moderate credibility (generally reliable with occasional issues)
//     /// - 5: High credibility (highly reliable, fact-checked content)
//     public var credibilityRating: Int?
//     /// URL to the source's sitemap, used for content discovery
//     public var siteMapURL: URL?
//     /// Primary category of the source
//     public var category: String?
//     /// Subcategory providing more specific classification
//     public var subCategory: NewsSourceSubcategory?
//     /// Detailed description of the source, its focus, and its background
//     public var description: String?
//     /// JSON schema for parsing content from this source, if available
//     public var JSONSchema: JSONSchema?
//     /// Type of the source
//     public var type: String
//     /// Whether the source is active
//     public var isActive: Bool
//     /// Last checked date
//     public var lastChecked: Date
//     /// Whether the source has robots.txt
//     public var hasRobotsTxt: Bool
//     /// Whether the source has sitemap
//     public var hasSitemap: Bool
//     /// Feed URLs
//     public var feedUrls: [String]
//     /// Metadata
//     public var metadata: [String: String]
//     /// Language code for the source's content (e.g., "en-US")
//     public var language: String?
// 
//     // If needed, a custom initializer to create a Source from a NewsSource instance:
//     //    public init(
//     //        newsSource: NewsSource,
//     //        credibilityRating: Int? = nil,
//     //        relationships: [Relationship] = []
//     //    ) {
//     //        self.id = newsSource.id
//     //        self.name = newsSource.name
//     //        self.url = newsSource.url
//     //        self.category = newsSource.category
//     //        self.subCategory = newsSource.subCategory
//     //        self.description = newsSource.description
//     //        self.JSONSchema = newsSource.JSONSchema
//     //        self.siteMapURL = newsSource.siteMapURL
//     //        self.credibilityRating = credibilityRating
//     //        self.relationships = relationships
//     //    }
// 
//     // If you do not have a direct use for the old initializer, you can remove it,
//     // or provide a default one that suits your Firestore decode scenario.
//     /// Creates a new source with the specified properties.
//     ///
//     /// - Parameters:
//     ///   - id: Unique identifier for the source (defaults to a new UUID string)
//     ///   - name: Name of the news source or information provider
//     ///   - url: URL to the source's website or main page
//     ///   - description: Detailed description of the source
//     ///   - category: Primary category of the source
//     ///   - language: Language code for the source's content
//     public init(
//         id: String = UUID().uuidString,
//         name: String,
//         url: String,
//         description: String? = nil,
//         category: String? = nil,
//         language: String? = nil
//     ) {
//         self.id = id
//         self.name = name
//         self.url = url
//         self.description = description
//         self.category = category
//         self.language = language
//         self.type = "news" // Default type
//         self.isActive = true // Default to active
//         self.lastChecked = Date() // Current date
//         self.hasRobotsTxt = false // Default to false
//         self.hasSitemap = false // Default to false
//         self.feedUrls = [] // Empty array
//         self.metadata = [:] // Empty dictionary
//     }
// 
//     // MARK: - JSONSchemaProvider Implementation
//     
//     public static var jsonSchema: String {
//         """
//         {
//             "type": "object",
//             "properties": {
//                 "id": { "type": "string", "format": "uuid" },
//                 "name": { "type": "string" },
//                 "description": { "type": "string" },
//                 "url": { "type": "string", "format": "uri" },
//                 "category": { "type": "string" },
//                 "language": { "type": "string" },
//                 "country": { "type": "string" },
//                 "reliability": {
//                     "type": "object",
//                     "properties": {
//                         "score": { "type": "number", "minimum": 0, "maximum": 1 },
//                         "lastUpdated": { "type": "string", "format": "date-time" }
//                     }
//                 }
//             },
//             "required": ["id", "name", "url"]
//         }
//         """
//     }
// }
// 
// public enum JSONSchema: String, CaseIterable, Codable, Sendable {
//     case schema1
//     case schema2
//     // Add more schemas as needed
// 
//     public var label: String {
//         switch self {
//         case .schema1:
//             return "Schema 1"
//         case .schema2:
//             return "Schema 2"
//         }
//     }
// }
// 
// /// Primary categories for news sources and information providers
// public enum NewsSourceCategory: String, CaseIterable, Codable, Sendable {
//     /// Traditional news media organizations
//     case localGovernmentAndPolitics
//     /// Government agencies and official sources
//     case publicSafety
//     /// Educational and research institutions
//     case education
//     /// Non-profit organizations and advocacy groups
//     case healthcare
//     /// Corporate and business entities
//     case transportation
//     /// Independent content creators and citizen journalists
//     case economyAndBusiness
//     /// Social media platforms and user-generated content
//     case environmentAndSustainability
//     /// Human-readable label for the category
//     case housing
//     /// Human-readable label for the category
//     case cultureAndEntertainment
//     /// Human-readable label for the category
//     case sportsAndRecreation
//     /// Human-readable label for the category
//     case socialServices
//     /// Human-readable label for the category
//     case technologyAndInnovation
//     /// Human-readable label for the category
//     case weatherAndNaturalEvents
//     /// Human-readable label for the category
//     case infrastructure
//     /// Human-readable label for the category
//     case communityVoicesAndOpinions
//     /// Human-readable label for the category
//     case general
//     /// Human-readable label for the category
//     case newsNoticesEventsAndAnnouncements
//     /// Human-readable label for the category
//     case religion
// 
//     public var label: String {
//         switch self {
//         case .localGovernmentAndPolitics:
//             return "Local Government and Politics"
//         case .publicSafety:
//             return "Public Safety"
//         case .education:
//             return "Education"
//         case .healthcare:
//             return "Healthcare"
//         case .transportation:
//             return "Transportation"
//         case .economyAndBusiness:
//             return "Economy and Business"
//         case .environmentAndSustainability:
//             return "Environment and Sustainability"
//         case .housing:
//             return "Housing"
//         case .cultureAndEntertainment:
//             return "Culture and Entertainment"
//         case .sportsAndRecreation:
//             return "Sports and Recreation"
//         case .socialServices:
//             return "Social Services"
//         case .technologyAndInnovation:
//             return "Technology and Innovation"
//         case .weatherAndNaturalEvents:
//             return "Weather and Natural Events"
//         case .infrastructure:
//             return "Infrastructure"
//         case .communityVoicesAndOpinions:
//             return "Community Voices and Opinions"
//         case .general:
//             return "General"
//         case .newsNoticesEventsAndAnnouncements:
//             return "News, Notices, Events, and Announcements"
//         case .religion:
//             return "Religion"
//         }
//     }
// }
// 
// /// Subcategories for more specific classification of news sources
// public enum NewsSourceSubcategory: String, CaseIterable, Codable, Sendable {
//     /// Print newspapers and their digital properties
//     case none
//     /// Television news networks and stations
//     case meetings
//     /// Radio stations and networks
//     case policies
//     /// Digital-only news publications
//     case initiatives
//     /// News wire services and content syndicators
//     case reports
//     /// News wire services and content syndicators
//     case events
// 
//     /// Human-readable label for the subcategory
//     public var label: String {
//         switch self {
//         case .none:
//             return "None"
//         case .meetings:
//             return "Meetings"
//         case .policies:
//             return "Policies"
//         case .initiatives:
//             return "Initiatives"
//         case .reports:
//             return "Reports"
//         case .events:
//             return "Events"
//         }
//     }
// }
// 
// /// Represents a specific news source with additional metadata
// public struct NewsSource: BaseEntity, Codable, Sendable {
//     /// Unique identifier for the news source
//     public var id: String
//     /// Name of the news source
//     public var name: String
//     /// URL to the news source's website
//     public var url: String
//     /// Logo or icon for the news source
//     public var logoURL: URL?
//     /// Primary color associated with the news source's branding
//     public var primaryColor: String?
// 
//     /// Creates a new news source with the specified properties.
//     ///
//     /// - Parameters:
//     ///   - id: Unique identifier for the news source (defaults to a new UUID string)
//     ///   - name: Name of the news source
//     ///   - url: URL to the news source's website
//     ///   - logoURL: URL to the news source's logo or icon
//     ///   - primaryColor: Hex color code for the news source's primary branding color
//     public init(
//         id: String = UUID().uuidString,
//         name: String = "",
//         url: String = "",
//         logoURL: URL? = nil,
//         primaryColor: String? = nil
//     ) {
//         self.id = id
//         self.name = name
//         self.url = url
//         self.logoURL = logoURL
//         self.primaryColor = primaryColor
//     }
// }

// File: StatisticalData.swift
// //
// //  StatisticalData.swift
// //  UtahNewsData
// //
// //  Created by Mark Evans on 2/12/25.
// //
// 
// /*
//  # StatisticalData Model
// 
//  This file defines the StatisticalData model, which represents numerical data points
//  in the UtahNewsData system. StatisticalData can be associated with articles, news events,
//  and other content types, providing quantitative information with proper attribution.
// 
//  ## Key Features:
// 
//  1. Core data (title, value, unit)
//  2. Source attribution
//  3. Contextual information (date, methodology, margin of error)
//  4. Visualization hints
//  5. Related entities
// 
//  ## Usage:
// 
//  ```swift
//  // Create a basic statistical data point
//  let basicStat = StatisticalData(
//      title: "Utah Population",
//      value: "3.3",
//      unit: "million people"
//  )
// 
//  // Create a detailed statistical data point
//  let detailedStat = StatisticalData(
//      title: "Utah Unemployment Rate",
//      value: "2.1",
//      unit: "percent",
//      source: laborDepartment, // Organization entity
//      date: Date(),
//      methodology: "Based on monthly survey of employers",
//      marginOfError: "±0.2",
//      visualizationType: .lineChart,
//      comparisonValue: "3.5", // National average
//      topics: ["Economy", "Employment"],
//      relatedEntities: [saltLakeCounty, utahState] // Location entities
//  )
// 
//  // Associate statistical data with an article
//  let article = Article(
//      title: "Utah's Economy Continues Strong Performance",
//      body: ["Utah's economy showed strong performance in the latest economic indicators..."]
//  )
// 
//  // Create relationship between statistical data and article
//  let relationship = Relationship(
//      fromEntity: detailedStat,
//      toEntity: article,
//      type: .supportedBy
//  )
// 
//  detailedStat.relationships.append(relationship)
//  article.relationships.append(relationship)
//  ```
// 
//  The StatisticalData model implements EntityDetailsProvider, allowing it to generate
//  rich text descriptions for RAG (Retrieval Augmented Generation) systems.
//  */
// 
// import Foundation
// 
// /// Represents the type of visualization suitable for the statistical data
// public enum VisualizationType: String, Codable, Sendable {
//     case barChart
//     case lineChart
//     case pieChart
//     case scatterPlot
//     case table
//     case other
// }
// 
// /// Represents a numerical data point in the UtahNewsData system.
// /// StatisticalData can be associated with articles, news events, and other content types,
// /// providing quantitative information with proper attribution.
// public struct StatisticalData: AssociatedData, EntityDetailsProvider, JSONSchemaProvider {
//     /// Unique identifier for the statistical data
//     public var id: String = UUID().uuidString
// 
//     /// The name property required by the BaseEntity protocol
//     public var name: String {
//         return title
//     }
// 
//     /// Relationships to other entities in the system
//     public var relationships: [Relationship] = []
// 
//     /// The name or description of the statistical data
//     public var title: String
// 
//     /// The numerical value of the statistic
//     public var value: String
// 
//     /// The unit of measurement (e.g., "percent", "million dollars")
//     public var unit: String
// 
//     /// Organization or person that is the source of this data
//     public var source: (any EntityDetailsProvider)?
// 
//     /// When the data was collected or published
//     public var date: Date?
// 
//     /// Information about how the data was collected or calculated
//     public var methodology: String?
// 
//     /// Statistical margin of error if applicable
//     public var marginOfError: String?
// 
//     /// Recommended visualization type for this data
//     public var visualizationType: VisualizationType?
// 
//     /// A comparison value for context (e.g., previous year, national average)
//     public var comparisonValue: String?
// 
//     /// Subject areas or keywords related to the data
//     public var topics: [String]?
// 
//     /// Entities (people, organizations, locations) related to this data
//     public var relatedEntities: [any EntityDetailsProvider]?
// 
//     /// Creates a new StatisticalData with the specified properties.
//     ///
//     /// - Parameters:
//     ///   - title: The name or description of the statistical data
//     ///   - value: The numerical value of the statistic
//     ///   - unit: The unit of measurement (e.g., "percent", "million dollars")
//     ///   - source: Organization or person that is the source of this data
//     ///   - date: When the data was collected or published
//     ///   - methodology: Information about how the data was collected or calculated
//     ///   - marginOfError: Statistical margin of error if applicable
//     ///   - visualizationType: Recommended visualization type for this data
//     ///   - comparisonValue: A comparison value for context (e.g., previous year, national average)
//     ///   - topics: Subject areas or keywords related to the data
//     ///   - relatedEntities: Entities (people, organizations, locations) related to this data
//     public init(
//         title: String,
//         value: String,
//         unit: String,
//         source: (any EntityDetailsProvider)? = nil,
//         date: Date? = nil,
//         methodology: String? = nil,
//         marginOfError: String? = nil,
//         visualizationType: VisualizationType? = nil,
//         comparisonValue: String? = nil,
//         topics: [String]? = nil,
//         relatedEntities: [any EntityDetailsProvider]? = nil
//     ) {
//         self.title = title
//         self.value = value
//         self.unit = unit
//         self.source = source
//         self.date = date
//         self.methodology = methodology
//         self.marginOfError = marginOfError
//         self.visualizationType = visualizationType
//         self.comparisonValue = comparisonValue
//         self.topics = topics
//         self.relatedEntities = relatedEntities
//     }
// 
//     /// Generates a detailed text description of the statistical data for use in RAG systems.
//     /// The description includes the title, value, unit, source, and contextual information.
//     ///
//     /// - Returns: A formatted string containing the statistical data's details
//     public func getDetailedDescription() -> String {
//         var description = "STATISTICAL DATA: \(title)"
//         description += "\nValue: \(value) \(unit)"
// 
//         if let marginOfError = marginOfError {
//             description += " (±\(marginOfError))"
//         }
// 
//         if let source = source {
//             if let organization = source as? Organization {
//                 description += "\nSource: \(organization.name)"
//             } else if let person = source as? Person {
//                 description += "\nSource: \(person.name)"
//             }
//         }
// 
//         if let date = date {
//             let formatter = DateFormatter()
//             formatter.dateStyle = .medium
//             description += "\nDate: \(formatter.string(from: date))"
//         }
// 
//         if let methodology = methodology {
//             description += "\nMethodology: \(methodology)"
//         }
// 
//         if let comparisonValue = comparisonValue {
//             description += "\nComparison Value: \(comparisonValue) \(unit)"
//         }
// 
//         if let topics = topics, !topics.isEmpty {
//             description += "\nTopics: \(topics.joined(separator: ", "))"
//         }
// 
//         return description
//     }
// 
//     /// JSON schema for LLM responses
//     public static var jsonSchema: String {
//         """
//         {
//             "type": "object",
//             "properties": {
//                 "id": {"type": "string"},
//                 "title": {"type": "string"},
//                 "value": {"type": "string"},
//                 "unit": {"type": "string"},
//                 "source": {"$ref": "#/definitions/Organization", "optional": true},
//                 "date": {"type": "string", "format": "date-time", "optional": true},
//                 "methodology": {"type": "string", "optional": true},
//                 "marginOfError": {"type": "string", "optional": true},
//                 "visualizationType": {
//                     "type": "string",
//                     "enum": ["barChart", "lineChart", "pieChart", "scatterPlot", "table"],
//                     "optional": true
//                 },
//                 "comparisonValue": {"type": "string", "optional": true},
//                 "topics": {
//                     "type": "array",
//                     "items": {"type": "string"},
//                     "optional": true
//                 },
//                 "relatedEntities": {
//                     "type": "array",
//                     "items": {
//                         "oneOf": [
//                             {"$ref": "#/definitions/Location"},
//                             {"$ref": "#/definitions/Organization"}
//                         ]
//                     },
//                     "optional": true
//                 },
//                 "metadata": {
//                     "type": "object",
//                     "additionalProperties": true,
//                     "optional": true
//                 }
//             },
//             "required": ["id", "title", "value", "unit"],
//             "definitions": {
//                 "Organization": {"$ref": "Organization.jsonSchema"},
//                 "Location": {"$ref": "Location.jsonSchema"}
//             }
//         }
//         """
//     }
// }
// 
// // MARK: - Equatable & Hashable
// extension StatisticalData: Equatable, Hashable {
//     public static func == (lhs: StatisticalData, rhs: StatisticalData) -> Bool {
//         lhs.id == rhs.id && lhs.title == rhs.title && lhs.value == rhs.value && lhs.unit == rhs.unit
//             && lhs.date == rhs.date && lhs.methodology == rhs.methodology
//             && lhs.marginOfError == rhs.marginOfError
//             && lhs.visualizationType == rhs.visualizationType
//             && lhs.comparisonValue == rhs.comparisonValue && lhs.topics == rhs.topics
//         // Note: source and relatedEntities are not compared as they're EntityDetailsProvider which doesn't conform to Equatable
//     }
// 
//     public func hash(into hasher: inout Hasher) {
//         hasher.combine(id)
//         hasher.combine(title)
//         hasher.combine(value)
//         hasher.combine(unit)
//         hasher.combine(date)
//         hasher.combine(methodology)
//         hasher.combine(marginOfError)
//         hasher.combine(visualizationType)
//         hasher.combine(comparisonValue)
//         hasher.combine(topics)
//         // Note: source and relatedEntities are not hashed as they're EntityDetailsProvider which doesn't conform to Hashable
//     }
// }
// 
// // MARK: - Codable
// extension StatisticalData: Codable {
//     private enum CodingKeys: String, CodingKey {
//         case id, relationships, title, value, unit, date, methodology, marginOfError,
//             visualizationType, comparisonValue, topics
//         // Note: source and relatedEntities are excluded as they're EntityDetailsProvider which doesn't conform to Codable
//     }
// 
//     public init(from decoder: Decoder) throws {
//         let container = try decoder.container(keyedBy: CodingKeys.self)
// 
//         id = try container.decode(String.self, forKey: .id)
//         relationships = try container.decode([Relationship].self, forKey: .relationships)
//         title = try container.decode(String.self, forKey: .title)
//         value = try container.decode(String.self, forKey: .value)
//         unit = try container.decode(String.self, forKey: .unit)
//         date = try container.decodeIfPresent(Date.self, forKey: .date)
//         methodology = try container.decodeIfPresent(String.self, forKey: .methodology)
//         marginOfError = try container.decodeIfPresent(String.self, forKey: .marginOfError)
//         visualizationType = try container.decodeIfPresent(
//             VisualizationType.self, forKey: .visualizationType)
//         comparisonValue = try container.decodeIfPresent(String.self, forKey: .comparisonValue)
//         topics = try container.decodeIfPresent([String].self, forKey: .topics)
//         source = nil  // Cannot decode EntityDetailsProvider
//         relatedEntities = nil  // Cannot decode [EntityDetailsProvider]
//     }
// 
//     public func encode(to encoder: Encoder) throws {
//         var container = encoder.container(keyedBy: CodingKeys.self)
// 
//         try container.encode(id, forKey: .id)
//         try container.encode(relationships, forKey: .relationships)
//         try container.encode(title, forKey: .title)
//         try container.encode(value, forKey: .value)
//         try container.encode(unit, forKey: .unit)
//         try container.encode(date, forKey: .date)
//         try container.encode(methodology, forKey: .methodology)
//         try container.encode(marginOfError, forKey: .marginOfError)
//         try container.encode(visualizationType, forKey: .visualizationType)
//         try container.encode(comparisonValue, forKey: .comparisonValue)
//         try container.encode(topics, forKey: .topics)
//         // source and relatedEntities are not encoded as they're EntityDetailsProvider which doesn't conform to Codable
//     }
// }

// File: UserSubmission.swift
// //
// //  UserSubmission.swift
// //  UtahNewsData
// //
// //  Created by Mark Evans on 1/28/25.
// //
// 
// /*
//  # UserSubmission Model
// 
//  This file defines the UserSubmission model, which represents content submitted by users
//  to the UtahNewsData system. User submissions can include various types of media content
//  such as text, images, videos, audio, and documents.
// 
//  ## Key Features:
// 
//  1. Core submission metadata (title, description, submission date)
//  2. User attribution (who submitted the content)
//  3. Multiple media item support using the unified MediaItem model
//  4. Relationship tracking with other entities
// 
//  ## Usage:
// 
//  ```swift
//  // Create a user submission with text and an image
//  let submission = UserSubmission(
//      id: UUID().uuidString,
//      title: "Traffic accident on Main Street",
//      description: "I witnessed a car accident at the intersection of Main and State",
//      user: currentUser,
//      mediaItems: [
//          MediaItem(title: "Description", type: .text, url: "", textContent: "The accident happened around 2:30 PM..."),
//          MediaItem(title: "Photo", type: .image, url: "https://example.com/accident-photo.jpg")
//      ]
//  )
// 
//  // Add the submission to the system
//  dataStore.addUserSubmission(submission)
// 
//  // Add a relationship to a location
//  let location = Location(name: "Main Street and State Street")
//  submission.relationships.append(Relationship(
//      id: location.id,
//      type: .location,
//      displayName: "Location"
//  ))
//  ```
// 
//  UserSubmission implements AssociatedData, allowing it to maintain relationships
//  with other entities in the system, such as locations, events, or people mentioned
//  in the submission.
//  */
// 
// import Foundation
// 
// /// Represents content submitted by users to the news system.
// /// User submissions can include various types of media content such as
// /// text, images, videos, audio, and documents.
// public struct UserSubmission: AssociatedData, EntityDetailsProvider, JSONSchemaProvider {
//     /// Unique identifier for the submission
//     public var id: String
// 
//     /// Relationships to other entities in the system
//     public var relationships: [Relationship] = []
// 
//     /// Title or headline of the submission
//     public var title: String
// 
//     /// Detailed description of the submission
//     public var description: String
// 
//     /// When the content was submitted
//     public var dateSubmitted: Date
// 
//     /// User who submitted the content
//     public var user: Person
// 
//     /// Media items included in the submission
//     public var mediaItems: [MediaItem]
// 
//     /// Creates a new user submission with the specified properties.
//     ///
//     /// - Parameters:
//     ///   - id: Unique identifier for the submission
//     ///   - title: Title or headline of the submission
//     ///   - description: Detailed description of the submission
//     ///   - dateSubmitted: When the content was submitted (defaults to current date)
//     ///   - user: User who submitted the content
//     ///   - mediaItems: Media items included in the submission
//     ///   - relationships: Relationships to other entities in the system
//     public init(
//         id: String = UUID().uuidString,
//         title: String,
//         description: String = "",
//         dateSubmitted: Date = Date(),
//         user: Person,
//         mediaItems: [MediaItem] = [],
//         relationships: [Relationship] = []
//     ) {
//         self.id = id
//         self.title = title
//         self.description = description
//         self.dateSubmitted = dateSubmitted
//         self.user = user
//         self.mediaItems = mediaItems
//         self.relationships = relationships
//     }
// 
//     /// The name property required by the AssociatedData protocol.
//     /// Returns the title of the submission.
//     public var name: String {
//         return title
//     }
// 
//     /// Generates a detailed text description of the user submission for use in RAG systems.
//     /// The description includes the title, description, user information, and media items.
//     ///
//     /// - Returns: A formatted string containing the submission's details
//     public func getDetailedDescription() -> String {
//         var description = "USER SUBMISSION: \(title)"
//         description += "\nDescription: \(self.description)"
//         description += "\nSubmitted by: \(user.name) on \(formatDate(dateSubmitted))"
// 
//         if !mediaItems.isEmpty {
//             description += "\n\nMedia Items:"
//             for (index, item) in mediaItems.enumerated() {
//                 description += "\n\n[\(index + 1)] \(item.getDetailedDescription())"
//             }
//         }
// 
//         return description
//     }
// 
//     /// Helper method to format a date for display
//     private func formatDate(_ date: Date) -> String {
//         let formatter = DateFormatter()
//         formatter.dateStyle = .medium
//         formatter.timeStyle = .short
//         return formatter.string(from: date)
//     }
// 
//     /// JSON schema for LLM responses
//     public static var jsonSchema: String {
//         """
//         {
//             "type": "object",
//             "properties": {
//                 "id": {"type": "string"},
//                 "title": {"type": "string"},
//                 "description": {"type": "string"},
//                 "user": {"$ref": "#/definitions/Person"},
//                 "submissionDate": {"type": "string", "format": "date-time"},
//                 "mediaItems": {
//                     "type": "array",
//                     "items": {"$ref": "#/definitions/MediaItem"},
//                     "optional": true
//                 },
//                 "status": {
//                     "type": "string",
//                     "enum": ["pending", "approved", "rejected", "archived"],
//                     "optional": true
//                 },
//                 "moderatorNotes": {"type": "string", "optional": true},
//                 "tags": {
//                     "type": "array",
//                     "items": {"type": "string"},
//                     "optional": true
//                 },
//                 "location": {"$ref": "#/definitions/Location", "optional": true},
//                 "metadata": {
//                     "type": "object",
//                     "additionalProperties": true,
//                     "optional": true
//                 }
//             },
//             "required": ["id", "title", "description", "user", "submissionDate"],
//             "definitions": {
//                 "Person": {"$ref": "Person.jsonSchema"},
//                 "MediaItem": {"$ref": "MediaItem.jsonSchema"},
//                 "Location": {"$ref": "Location.jsonSchema"}
//             }
//         }
//         """
//     }
// }
// 
// // MARK: - Legacy Support
// 
// /// Extension to provide backward compatibility with the old media type model
// extension UserSubmission {
//     /// Creates a UserSubmission from the legacy model that used separate media type arrays
//     ///
//     /// - Parameters:
//     ///   - legacySubmission: The legacy UserSubmission with separate media arrays
//     /// - Returns: A new UserSubmission with a unified mediaItems array
//     public static func fromLegacy(
//         id: String,
//         title: String,
//         description: String,
//         dateSubmitted: Date,
//         user: Person,
//         mediaItems: [MediaItem],
//         relationships: [Relationship] = []
//     ) -> UserSubmission {
//         return UserSubmission(
//             id: id,
//             title: title,
//             description: description,
//             dateSubmitted: dateSubmitted,
//             user: user,
//             mediaItems: mediaItems,
//             relationships: relationships
//         )
//     }
// }
// 
// // MARK: - Legacy Media Types (Deprecated)
// 
// /// A text-based media item in a user submission
// @available(*, deprecated, message: "Use MediaItem with type .text instead")
// public struct TextMedia: BaseEntity, Codable, Hashable, Sendable {
//     /// Unique identifier for the text media
//     public var id: String
// 
//     /// The text content
//     public var content: String
// 
//     /// The name of the text media, used for display and embedding generation
//     public var name: String {
//         return content.prefix(50) + (content.count > 50 ? "..." : "")
//     }
// 
//     /// Creates a new text media item
//     public init(id: String = UUID().uuidString, content: String) {
//         self.id = id
//         self.content = content
//     }
// }
// 
// /// An image media item in a user submission
// @available(*, deprecated, message: "Use MediaItem with type .image instead")
// public struct ImageMedia: BaseEntity, Codable, Hashable, Sendable {
//     /// Unique identifier for the image media
//     public var id: String
// 
//     /// URL or path to the image
//     public var url: String
// 
//     /// Caption or description of the image
//     public var caption: String?
// 
//     /// The name of the image media, used for display and embedding generation
//     public var name: String {
//         return caption ?? "Image \(id)"
//     }
// 
//     /// Creates a new image media item
//     public init(id: String = UUID().uuidString, url: String, caption: String? = nil) {
//         self.id = id
//         self.url = url
//         self.caption = caption
//     }
// }
// 
// /// A video media item in a user submission
// @available(*, deprecated, message: "Use MediaItem with type .video instead")
// public struct VideoMedia: BaseEntity, Codable, Hashable, Sendable {
//     /// Unique identifier for the video media
//     public var id: String
// 
//     /// URL or path to the video
//     public var url: String
// 
//     /// Caption or description of the video
//     public var caption: String?
// 
//     /// Duration of the video in seconds
//     public var duration: TimeInterval?
// 
//     /// The name of the video media, used for display and embedding generation
//     public var name: String {
//         return caption ?? "Video \(id)"
//     }
// 
//     /// Creates a new video media item
//     public init(
//         id: String = UUID().uuidString, url: String, caption: String? = nil,
//         duration: TimeInterval? = nil
//     ) {
//         self.id = id
//         self.url = url
//         self.caption = caption
//         self.duration = duration
//     }
// }
// 
// /// An audio media item in a user submission
// @available(*, deprecated, message: "Use MediaItem with type .audio instead")
// public struct AudioMedia: BaseEntity, Codable, Hashable, Sendable {
//     /// Unique identifier for the audio media
//     public var id: String
// 
//     /// URL or path to the audio
//     public var url: String
// 
//     /// Caption or description of the audio
//     public var caption: String?
// 
//     /// Duration of the audio in seconds
//     public var duration: TimeInterval?
// 
//     /// The name of the audio media, used for display and embedding generation
//     public var name: String {
//         return caption ?? "Audio \(id)"
//     }
// 
//     /// Creates a new audio media item
//     public init(
//         id: String = UUID().uuidString, url: String, caption: String? = nil,
//         duration: TimeInterval? = nil
//     ) {
//         self.id = id
//         self.url = url
//         self.caption = caption
//         self.duration = duration
//     }
// }
// 
// /// A document media item in a user submission
// @available(*, deprecated, message: "Use MediaItem with type .document instead")
// public struct DocumentMedia: BaseEntity, Codable, Hashable, Sendable {
//     /// Unique identifier for the document media
//     public var id: String
// 
//     /// URL or path to the document
//     public var url: String
// 
//     /// Title or name of the document
//     public var title: String?
// 
//     /// Description of the document
//     public var description: String?
// 
//     /// The name of the document media, used for display and embedding generation
//     public var name: String {
//         return title ?? "Document \(id)"
//     }
// 
//     /// Creates a new document media item
//     public init(
//         id: String = UUID().uuidString, url: String, title: String? = nil,
//         description: String? = nil
//     ) {
//         self.id = id
//         self.url = url
//         self.title = title
//         self.description = description
//     }
// }

// File: UtahNewsData.swift
// /*
//  # UtahNewsData Package
//  
//  This is the main entry point for the UtahNewsData package, which provides a comprehensive
//  set of data models and utilities for working with news data specific to Utah.
//  
//  ## Package Overview
//  
//  UtahNewsData is designed to support applications that collect, process, and display
//  news content from various sources throughout Utah. It provides:
//  
//  1. Core data models for news entities (articles, videos, audio)
//  2. Entity models for people, organizations, locations, and other news-related concepts
//  3. Relationship tracking between entities
//  4. Utilities for data processing and retrieval
//  5. Support for RAG (Retrieval Augmented Generation) systems
//  
//  ## Key Components
//  
//  - News Content Models: Article, Video, Audio
//  - Entity Models: Person, Organization, Location, etc.
//  - Relationship System: AssociatedData protocol and Relationship struct
//  - Data Processing: ScrapeStory and related models
//  - Utilities: Extensions, RAG utilities
//  
//  ## Usage
//  
//  Import this package into your Swift project to access the full range of models and utilities:
//  
//  ```swift
//  import UtahNewsData
//  
//  // Create and use news content
//  let article = Article(
//      title: "Utah Legislature Passes New Bill",
//      url: "https://example.com/utah-legislature-bill",
//      textContent: "The Utah Legislature today passed a bill that..."
//  )
//  
//  // Work with entities and relationships
//  let person = Person(name: "Jane Doe", details: "State Senator")
//  let organization = Organization(name: "Utah State Legislature")
//  
//  // Create relationships between entities
//  let relationship = Relationship(
//      id: organization.id,
//      type: .organization,
//      displayName: "Member of"
//  )
//  person.relationships.append(relationship)
//  ```
//  
//  For more detailed examples, see the documentation for individual components.
//  */
// 
// // The Swift Programming Language
// // https://docs.swift.org/swift-book

// File: Video.swift
// //
// //  Video.swift
// //  UtahNewsData
// //
// //  Created by Mark Evans on 11/18/24.
// //
// 
// /*
//  # Video Model
//  
//  This file defines the Video model, which represents video content in the UtahNewsData
//  system. The Video struct implements the NewsContent protocol, providing a consistent
//  interface for working with video content alongside other news content types.
//  
//  ## Key Features:
//  
//  1. Core news content properties (title, URL, publication date)
//  2. Video-specific metadata (duration, resolution)
//  3. Preview support with example instance
//  
//  ## Usage:
//  
//  ```swift
//  // Create a video instance
//  let video = Video(
//      title: "Governor's Press Conference on Water Conservation",
//      url: "https://www.utahnews.com/videos/governor-water-conservation",
//      urlToImage: "https://www.utahnews.com/images/governor-thumbnail.jpg",
//      publishedAt: Date(),
//      textContent: "Governor discusses new water conservation initiatives for Utah",
//      author: "Utah News Video Team",
//      duration: 1800, // 30 minutes in seconds
//      resolution: "1080p"
//  )
//  
//  // Access video properties
//  print("Video: \(video.title)")
//  print("Duration: \(Int(video.duration / 60)) minutes")
//  print("Resolution: \(video.resolution)")
//  
//  // Use in a list with other news content types
//  let newsItems: [NewsContent] = [article1, video, article2]
//  for item in newsItems {
//      print(item.basicInfo())
//  }
//  ```
//  
//  The Video model is designed to work seamlessly with UI components that display
//  news content, while providing additional properties specific to video content.
//  */
// 
// import Foundation
// 
// /// A struct representing a video in the news app.
// /// Videos are a type of news content with additional properties for
// /// duration and resolution.
// public struct Video: NewsContent, BaseEntity, Sendable {
//     /// Unique identifier for the video
//     public var id: String
//     
//     /// The name of the entity (required by BaseEntity)
//     public var name: String { title }
//     
//     /// Title or headline of the video
//     public var title: String
//     
//     /// URL where the video can be accessed
//     public var url: String
//     
//     /// URL to a thumbnail image representing the video
//     public var urlToImage: String?
//     
//     /// When the video was published
//     public var publishedAt: Date
//     
//     /// Description or transcript of the video
//     public var textContent: String?
//     
//     /// Creator or producer of the video
//     public var author: String?
//     
//     /// Length of the video in seconds
//     public var duration: TimeInterval
//     
//     /// Video quality (e.g., "720p", "1080p", "4K")
//     public var resolution: String
//     
//     /// Creates a new video with the specified properties.
//     ///
//     /// - Parameters:
//     ///   - id: Unique identifier for the video (defaults to a new UUID string)
//     ///   - title: Title or headline of the video
//     ///   - url: URL where the video can be accessed
//     ///   - urlToImage: URL to a thumbnail image (defaults to a placeholder)
//     ///   - publishedAt: When the video was published (defaults to current date)
//     ///   - textContent: Description or transcript of the video
//     ///   - author: Creator or producer of the video
//     ///   - duration: Length of the video in seconds
//     ///   - resolution: Video quality (e.g., "720p", "1080p", "4K")
//     public init(
//         id: String = UUID().uuidString,
//         title: String,
//         url: String,
//         urlToImage: String? = "https://picsum.photos/800/1200",
//         publishedAt: Date = Date(),
//         textContent: String? = nil,
//         author: String? = nil,
//         duration: TimeInterval,
//         resolution: String
//     ) {
//         self.id = id
//         self.title = title
//         self.url = url
//         self.urlToImage = urlToImage
//         self.publishedAt = publishedAt
//         self.textContent = textContent
//         self.author = author
//         self.duration = duration
//         self.resolution = resolution
//     }
//     
//     /// Returns a formatted duration string in minutes and seconds.
//     ///
//     /// - Returns: A string in the format "MM:SS"
//     public func formattedDuration() -> String {
//         let minutes = Int(duration) / 60
//         let seconds = Int(duration) % 60
//         return String(format: "%d:%02d", minutes, seconds)
//     }
// }
// 
// public extension Video {
//     /// An example instance of `Video` for previews and testing.
//     /// This provides a convenient way to use a realistic video instance
//     /// in SwiftUI previews and unit tests.
//     @MainActor static let example = Video(
//         title: "Utah News Video Highlights",
//         url: "https://www.utahnews.com/video-highlights",
//         urlToImage: "https://picsum.photos/800/600",
//         textContent: "Watch the latest video highlights from Utah News.",
//         author: "Mark Evans",
//         duration: 300, // Duration in seconds
//         resolution: "1080p"
//     )
// }

