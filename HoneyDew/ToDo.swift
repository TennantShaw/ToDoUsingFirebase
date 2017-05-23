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
    var title: String?
    var description: String?
    var reminderDate: String?
    var uniqueID: String?

    // MARK: - Equatable/Hashable Conformance
    public static func == (lhs: ToDo, rhs: ToDo) -> Bool {
        return lhs.title == rhs.title && lhs.description == rhs.description && lhs.reminderDate == rhs.reminderDate && lhs.uniqueID == rhs.uniqueID
    }
    
    var hashValue: Int {
        return title!.hashValue &+ description!.hashValue &+ reminderDate!.hashValue &+ uniqueID!.hashValue
    }
    
}
