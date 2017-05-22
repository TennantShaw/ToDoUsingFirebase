//
//  User.swift
//  HoneyDew
//
//  Created by Tennant Shaw on 5/22/17.
//  Copyright © 2017 Tennant Shaw. All rights reserved.
//

import Foundation

class User: Equatable, Hashable {
    // MARK: - Properties
    var displayName: String
    var userName: String
    var toDoList: ToDoList
    
    
    // MARK: - Initializers
    init(displayName: String, userName: String, toDoList: ToDoList) {
        self.displayName = displayName
        self.userName = userName
        self.toDoList = toDoList
    }
    
    // MARK: - Equatable/Hashable Conformance
    public static func == (lhs: User, rhs: User) -> Bool {
        return lhs.displayName == rhs.displayName && lhs.userName == rhs.userName && lhs.toDoList == rhs.toDoList
    }
    
    var hashValue: Int {
        return displayName.hashValue &+ userName.hashValue
    }
}
