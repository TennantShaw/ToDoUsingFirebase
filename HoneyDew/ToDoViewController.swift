//
//  ToDoViewController.swift
//  HoneyDew
//
//  Created by Tennant Shaw on 5/22/17.
//  Copyright © 2017 Tennant Shaw. All rights reserved.
//

import Firebase
import UIKit

class ToDoViewController: UIViewController {
    // MARK: - Properties
    var todo: ToDo?
    
    // MARK: - Outlets
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var todoTextView: UITextView!
    @IBOutlet var datePicker: UIDatePicker!
    
    // MARK: - Actions
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        if todo == nil {
            todo = ToDo()
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy hh:mm a"
        
        todo?.title = self.titleTextField.text
        todo?.description = self.todoTextView.text
        todo?.reminderDate = dateFormatter.string(from: Date())
        
        let ref = Database.database().reference()
        let key = ref.child("todoList").childByAutoId().key
        
        let dictionaryTodo = [
            "title" : todo!.title!,
            "description" : todo!.description!,
            "date" : todo!.reminderDate!
            ]
        
        let childUpdates = ["/todoList/\(key)": dictionaryTodo]
            
        ref.updateChildValues(childUpdates, withCompletionBlock: { (error, ref) -> Void in
                self.navigationController?.popViewController(animated: true)
        })
        
    }

    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.todo != nil {
            titleTextField.text = self.todo?.title
            todoTextView.text = self.todo?.description
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy hh:mm a"
            let date = dateFormatter.string(from: Date())
            datePicker.accessibilityIdentifier = date
        }
    }

}
