//
//  ExpertAnalysis.swift
//  NewsCapture
//
//  Created by Mark Evans on 10/25/24.
//

import SwiftUI


public struct ExpertAnalysis: AssociatedData {
    public var id: String
    public var relationships: [Relationship] = []
    public var expert: Person
    public var date: Date
    public var topics: [Category] = []

    init(id: String = UUID().uuidString, expert: Person, date: Date) {
        self.id = id
        self.expert = expert
        self.date = date
    }
}
