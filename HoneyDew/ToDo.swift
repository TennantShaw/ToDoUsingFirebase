//
//  ToDo.swift
//  HoneyDew
//
//  Created by Tennant Shaw on 5/22/17.
//  Copyright © 2017 Tennant Shaw. All rights reserved.
//

import Foundation

class ToDo: Equatable, Hashable {
    // MARK: - Properties
    var title: String
    var description: String
    var createdDate: Date
    var completedDate: Date
    var dueDate: Date
    var completedStatus: Bool
    
    // MARK: - Initializers
    init(title: String, description: String, createdDate: Date, completedDate: Date, dueDate: Date, completedStatus: Bool) {
        self.title = title
        self.description = description
        self.createdDate = Date()
        self.completedDate = Date()
        self.dueDate = Date()
        self.completedStatus = completedStatus
    }
    
    // MARK: - Equatable/Hashable Conformance
    public static func == (lhs: ToDo, rhs: ToDo) -> Bool {
        return lhs.title == rhs.title && lhs.description == rhs.description && lhs.createdDate == rhs.createdDate && lhs.completedDate == rhs.completedDate && lhs.dueDate == rhs.dueDate && lhs.completedStatus == rhs.completedStatus
    }
    
    var hashValue: Int {
        return title.hashValue &+ description.hashValue &+ createdDate.hashValue &+ completedDate.hashValue &+ dueDate.hashValue &+ completedStatus.hashValue
    }
    
}
