//
//  TableViewController.swift
//  Actions
//
//  Created by Gary Tokman on 10/27/17.
//  Copyright © 2017 Gary Tokman. All rights reserved.
//

import UIKit

final class Todo {
    let title: String
    let date: Date
    var isImportant: Bool
    var isFinished: Bool
    
    init(title: String) {
        self.title = title
        self.date = Date()
        self.isImportant = false
        self.isFinished = false
    }
}

class TableViewController: UITableViewController {
    var todos = [Todo]()
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 1...10 {
            todos.append(Todo(title: "Todo #\(i)"))
        }
    }
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return todos.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath)

        // Configure the cell...
        let todo = todos[indexPath.row]
        cell.textLabel?.text = todo.title
        cell.detailTextLabel?.text = todo.date.description

        return cell
    }
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let important = importantAction(at: indexPath)
        let delete = deleteAction(at: indexPath)
        let swipeAction = UISwipeActionsConfiguration(actions: [important, delete])
        return swipeAction
    }
    // MARK: - Swipe left and righi methods
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let checkAction = comleteAction(at: indexPath)
        let swipeAction = UISwipeActionsConfiguration(actions: [checkAction])
        return swipeAction
    }
    func importantAction(at indexPath: IndexPath) -> UIContextualAction {
        let todo=todos[indexPath.row]
        let action = UIContextualAction(style: .normal, title: "important") { (action, view, completion) in
            print("importantAction")
            todo.isImportant = !todo.isImportant
            completion(true)
        }
        action.image = UIImage(named: "Alarm")
        action.backgroundColor = (todo.isImportant ?  .purple : .gray)
        return action
    }
    func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "delete") { (action, view, completion) in
            print("deleteAction")
            self.todos.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
        }
        action.image = UIImage(named: "Trash")
        action.backgroundColor = .red
        return action
    }
    func comleteAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Complet") { (action, view, completion) in
            print("comleteAction")
            self.todos.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
        }
        action.image=UIImage(named: "Check")
        action.backgroundColor = .green
        return action
    }

}
