//
//  ToDoViewController.swift
//  HoneyDew
//
//  Created by Tennant Shaw on 5/22/17.
//  Copyright © 2017 Tennant Shaw. All rights reserved.
//

import Firebase
import UIKit
import GoogleSignIn

class ToDoViewController: UIViewController {
    
    // MARK: - Properties
    var todo: ToDo?
    var todoList = [ToDo]()
    
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
        todo?.text = self.todoTextView.text
        todo?.reminderDate = dateFormatter.string(from: Date())
        
        let ref = Database.database().reference()
        let key = ref.child("todoList").childByAutoId().key
        
        let dictionaryTodo = [
            "title" : todo!.title!,
            "text" : todo!.text!,
            "date" : todo!.reminderDate!
            ]
        
        let childUpdates = ["/todoList/\(key)": dictionaryTodo]
            
        ref.updateChildValues(childUpdates, withCompletionBlock: { (error, ref) -> Void in
                self.navigationController?.popViewController(animated: true)
        })
        
    }
    
    // MARK: - Load Data
    func loadData() {
        self.todoList.removeAll()
        let ref = Database.database().reference()
        ref.child("todoList").observeSingleEvent(of: .value, with: { (snapshot) in
            if let todoDict = snapshot.value as? [String:AnyObject] {
                for (_, todoElement) in todoDict {
                    print(todoElement)
                    let todo = ToDo()
                    todo.title = todoElement["title"] as? String
                    todo.text = todoElement["text"] as? String
                    todo.reminderDate = todoElement["date"] as? String
                    self.todoList.append(todo)
                }
            }
            print("\(self.todoList)")
        }) { (error) in
            print(error.localizedDescription)
        }
    }

    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.todo != nil {
            titleTextField.text = self.todo?.title
            todoTextView.text = self.todo?.text
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy hh:mm a"
            let date = dateFormatter.string(from: Date())
            datePicker.accessibilityIdentifier = date
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }

}
