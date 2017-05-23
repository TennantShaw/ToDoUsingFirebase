//
//  ToDoList.swift
//  HoneyDew
//
//  Created by Tennant Shaw on 5/22/17.
//  Copyright © 2017 Tennant Shaw. All rights reserved.
//

import Foundation
import FirebaseDatabase

class ToDoList: Equatable, Hashable {
    // MARK: - Properties
    var title: String
    var todos: [ToDo] = []
    
    init(title: String) {
        self.title = title
    }
    
    // MARK: - Equatable/Hashable Conformance
    public static func == (lhs: ToDoList, rhs: ToDoList) -> Bool {
        return lhs.title == rhs.title && lhs.todos == rhs.todos
    }
    
    var hashValue: Int {
        return title.hashValue
    }
}

extension ToDoList {
    // MARK: - Initializers
    convenience init?(dict: [String: Any]) {
        guard let title = dict[Constants.ListFields.title] as? String else {
            return nil
        }
        
        self.init(title: title)
    }
    
    convenience init?(tuple: (String, dict: [String: Any])) {
        guard let title = tuple.dict[Constants.ListFields.title] as? String else {
            return nil
        }
        
        self.init(title: title)
    }
    
    convenience init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String: Any] else {
            return nil
        }
        
        self.init(dict: dict)
    }
    
    static func array(snapshot: DataSnapshot) -> [ToDoList]? {
        guard let dictDict = snapshot.value as? [String: [String : Any]],
            let back = { () -> [ToDoList]? in dictDict.flatMap(ToDoList.init(tuple:)) }() ,
            back.count == dictDict.count else {
                return nil
        }
        
        return back
    }
    
    var dictionaryRepresentation: [String: Any] {
        return [
            Constants.ListFields.title : title
        ]
    }
}
