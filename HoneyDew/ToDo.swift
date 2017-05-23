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
    var text: String?
    var reminderDate: String?
    var uniqueID: String?

    // MARK: - Equatable/Hashable Conformance
    public static func == (lhs: ToDo, rhs: ToDo) -> Bool {
        return lhs.title == rhs.title && lhs.text == rhs.text && lhs.reminderDate == rhs.reminderDate && lhs.uniqueID == rhs.uniqueID
    }
    
    var hashValue: Int {
        return title!.hashValue &+ text!.hashValue &+ reminderDate!.hashValue &+ uniqueID!.hashValue
    }
    
}
