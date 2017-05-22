//
//  User.swift
//  HoneyDew
//
//  Created by Tennant Shaw on 5/22/17.
//  Copyright © 2017 Tennant Shaw. All rights reserved.
//

import Foundation

class User {
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
}
