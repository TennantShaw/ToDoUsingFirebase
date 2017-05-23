//
//  Constants.swift
//  HoneyDew
//
//  Created by Tennant Shaw on 5/23/17.
//  Copyright © 2017 Tennant Shaw. All rights reserved.
//

struct Constants {
    
    enum NotificationKeys {
        static let signedIn = "onSignInCompleted"
    }
    
    enum Segues {
        static let SignInToGoogle = "signInSegue"
        static let FPToSignIn = "honeyDewSegue"
    }
    
    enum ListFields {
        static let title = "title"
    }
    
    enum TodoFields {
        static let title = "title"
        static let text = "text"
    }
    
    enum CellReuseIdentifiers {
        static let listsViewCell = "ListsViewCell"
        static let todosViewCell = "TodosViewCell"
    }
}
