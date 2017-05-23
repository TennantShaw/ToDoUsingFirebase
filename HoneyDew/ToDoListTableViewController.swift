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
    let dataSource = ToDoListsDataSource()
    fileprivate var listsHandle: DatabaseHandle? = nil
    
    
    // MARK: - Initializers
    override init(style: UITableViewStyle) {
        super.init(style: style)
        sharedInitWork()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        sharedInitWork()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInitWork()
    }
    
    private func sharedInitWork() {
        let navItem = navigationItem
        let addListItem = UIBarButtonItem(barButtonSystemItem: .add,
                                          target: self, action: #selector(ToDoListTableViewController.addList))
    }
    
    // MARK: - Table View Stuff
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todoVC = self.storyboard!.instantiateViewController(withIdentifier: "ToDoVC") as! ToDoViewController
        todoVC.todo = todoList[indexPath.row]
        self.navigationController?.pushViewController(todoVC, animated: true)
    }
}

extension ToDoListTableViewController {
    // MARK: - View Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource
        configureDatabase()
    }
    
    @objc func addList() {
        let data = ToDoList(title: Date().description).dictionaryRepresentation
        databaseReference.child(listsPath).childByAutoId().setValue(data)
    }
}

extension ToDoListTableViewController /* Firebase */ {
    var user: User {
        if let _user = Auth.auth().currentUser {
            return _user
        } else {
            fatalError("User unexpectedly nil in ToDoListTableViewController")
        }
    }
    
    var listsPath: String {
        return "users/\(user.uid)/my_lists"
    }
    
    var databaseReference: DatabaseReference {
        return Database.database().reference()
    }
    
    func configureDatabase() {
        listsHandle = databaseReference.child(listsPath).observe(.childAdded, with: {
            [weak self] (snapshot) in
            let oList = ToDoList(snapshot: snapshot)
            
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self else { return }
                if let list = oList {
                    let index = strongSelf.dataSource.todoList.count
                    strongSelf.dataSource.todoList.append(list)
                    
                    let indexPath = IndexPath(row: index, section: 0)
                    strongSelf.tableView.insertRows(at: [indexPath],
                                                    with: .automatic)
                } else {
                    print("failed to deserialize lists")
                }
            }
        })
    }
}

class ToDoListsDataSource: NSObject, UITableViewDataSource {
    var todoList: [ToDoList] = [ToDoList(title: "Hello")]
    
    init(lists: [ToDoList]) {
        self.todoList = lists
    }
    
    override convenience init() {
        self.init(lists: [])
    }
    
    
    // MARK: - TableView datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell")
//        cell!.textLabel?.text = todoList[indexPath.row].title
//        return cell!
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellReuseIdentifiers.listsViewCell) else {
            fatalError("failed to dequeue cell with reuse identifier \(Constants.CellReuseIdentifiers.listsViewCell)")
        }
        let list = todoList[indexPath.row]
        cell.textLabel?.text = list.title
        return cell
    }
}

