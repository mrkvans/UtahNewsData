//
//  CalEvent.swift
//  NewsCapture
//
//  Created by Mark Evans on 10/25/24.
//

import SwiftUI


public struct CalEvent: AssociatedData {
    public var id: UUID
    public var relationships: [Relationship] = []
    public var title: String
    public var description: String?
    public var startDate: Date
    public var endDate: Date?

    init(id: UUID = UUID(), title: String, startDate: Date) {
        self.id = id
        self.title = title
        self.startDate = startDate
    }
}