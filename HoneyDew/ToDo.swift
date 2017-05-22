//
//  ToDo.swift
//  HoneyDew
//
//  Created by Tennant Shaw on 5/22/17.
//  Copyright © 2017 Tennant Shaw. All rights reserved.
//

import Foundation

class ToDo {
    // MARK: - Properties
    var title: String
    var description: String
    var createdDate: Date
    var completedDate: Date
    var dueDate: Date
    var completedStatus: Bool = false
    
    // MARK: - Initializers
    init(title: String, description: String, createdDate: Date, completedDate: Date, dueDate: Date) {
        self.title = title
        self.description = description
        self.createdDate = Date()
        self.completedDate = Date()
        self.dueDate = Date()
    }
    
}
