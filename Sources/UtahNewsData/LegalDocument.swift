//
//  LegalDocument.swift
//  NewsCapture
//
//  Created by Mark Evans on 10/25/24.
//

import SwiftUI


public struct LegalDocument: AssociatedData {
    public var id: UUID
    public var relationships: [Relationship] = []
    public var title: String
    public var dateIssued: Date
    public var mediaItems: [MediaItem] = [] // Contains DocumentMedia or TextMedia

    init(id: UUID = UUID(), title: String, dateIssued: Date) {
        self.id = id
        self.title = title
        self.dateIssued = dateIssued
    }
}