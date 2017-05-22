//
//  ToDoList.swift
//  HoneyDew
//
//  Created by Tennant Shaw on 5/22/17.
//  Copyright © 2017 Tennant Shaw. All rights reserved.
//

import Foundation

class ToDoList: Equatable, Hashable {
    // MARK: - Properties
    var title: String = ""
    var todos: [ToDo] = []
    
    // MARK: - Equatable/Hashable Conformance
    public static func == (lhs: ToDoList, rhs: ToDoList) -> Bool {
        return lhs.title == rhs.title && lhs.todos == rhs.todos
    }
    
    var hashValue: Int {
        return title.hashValue
    }
}
