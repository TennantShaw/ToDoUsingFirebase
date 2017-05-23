//
//  ToDoListTableViewController.swift
//  HoneyDew
//
//  Created by Tennant Shaw on 5/22/17.
//  Copyright © 2017 Tennant Shaw. All rights reserved.
//

import Firebase
import UIKit

class ToDoListTableViewController: UITableViewController {
    // MARK: - Properties
    var todoList = [ToDo]()
    
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
                    todo.description = todoElement["description"] as? String
                    todo.reminderDate = todoElement["date"] as? String
                    self.todoList.append(todo)
                }
            }
            self.tableView.reloadData()
            print("\(self.todoList)")
        }) { (error) in
            print(error.localizedDescription)
        }
    }

 
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // MARK: - TableView datasource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.todoList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell")
        cell!.textLabel?.text = todoList[indexPath.row].title
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todoVC = self.storyboard!.instantiateViewController(withIdentifier: "ToDoVC") as! ToDoViewController
        todoVC.todo = todoList[indexPath.row]
        self.navigationController?.pushViewController(todoVC, animated: true)
    }
}
