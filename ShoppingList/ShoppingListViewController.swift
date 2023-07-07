//
//  ViewController.swift
//  ShoppingList
//
//  Created by Md Ruman Islam on 16/6/23.
//

import UIKit


struct TableItem {
    let title: String
    let detail: String
    var hasCheckmark: Bool
}

enum editinType {
    case delete
    case add
}

class ShoppingListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    
    enum EditingType {
        case delete
        case add
    }
    
    var editingType = EditingType.add
    var viewModel = ShoppingListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        viewModel.loadData()
        tableView.reloadData()
    }
    
    @IBAction func deleteButtonAction(_ sender: Any) {
        editingType = .delete
        tableView.isEditing = !tableView.isEditing
    }
    @IBAction func addButtonAction(_ sender: Any) {
        editingType = .add
        tableView.isEditing = !tableView.isEditing
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let item = viewModel.item(at: indexPath.row)
        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = item.detail
        
        if item.hasCheckmark {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .detailButton
            
            let checkmarkImage = UIImage(named: "uncheck")
            let checkmarkImageView = UIImageView(image: checkmarkImage)
            
            let imageSize = CGSize(width: 24, height: 24)
            let imageFrame = CGRect(origin: .zero, size: imageSize)
            checkmarkImageView.frame = imageFrame
            cell.accessoryView = checkmarkImageView
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        viewModel.toggleCheckmark(at: indexPath.row)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Shopping List"
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        switch editingType {
        case .delete:
            return .delete
        case .add:
            return .insert
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteItem(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            showInputAlert()
        }
    }
    
    func showInputAlert() {
        let alert = UIAlertController(title: "Add Item", message: nil, preferredStyle: .alert)
        alert.addTextField { $0.placeholder = "Enter Title" }
        alert.addTextField { $0.placeholder = "Enter Detail" }
        
        let addAction = UIAlertAction(title: "Add", style: .default) { [weak self, weak alert] _ in
            guard let self = self else { return }
            
            let title = alert?.textFields?[0].text ?? "No Title"
            let detail = alert?.textFields?[1].text ?? "No Detail"
            
            let newItem = ShoppingListViewModel.Item(title: title, detail: detail, hasCheckmark: false)
            self.viewModel.addItem(newItem)
            
            let indexPath = IndexPath(row: 0, section: 0)
            self.tableView.insertRows(at: [indexPath], with: .fade)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true)
    }
}


