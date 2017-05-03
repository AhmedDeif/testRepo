//
//  ViewController.swift
//  checklists
//
//  Created by Ahmed Abodeif on 4/17/17.
//  Copyright © 2017 Ahmed Abodeif. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController, AddItemViewControllerDelegate {
    
    var items: [ChecklistItem]
    var CategoryDelegate : UpdateCategoryItemsDelegate!
    var currentCategory : CategoryListItem!
    var selectedCategoryIndex : Int!
    var CategoryName : String
    
    required init?(coder aDecoder: NSCoder) {
        items = [ChecklistItem]()
        CategoryName = ""
        super.init(coder: aDecoder)
    }
    
    
    func addItemViewControllerDidCancel( _ controller: AddItemViewController){
        dismiss(animated: true, completion: nil)
    }
    
    func addItemViewController( _ controller: AddItemViewController, didFinishEditing item: ChecklistItem ){
        let newRowIndex = items.index(of: controller.itemToEdit)!
        items[newRowIndex] = item
        let indexPath = IndexPath(row:newRowIndex, section: 0)
        let indexPaths = [indexPath]
        dismiss(animated: true, completion: nil)
        tableView.reloadRows(at: indexPaths, with: UITableViewRowAnimation.automatic)
        CategoryDelegate.addItemToCategory(self, didFinishEditing: item, itemCategory: currentCategory, categoryIndex: selectedCategoryIndex, ItemIndex:newRowIndex)
    }

    func addItemViewController( _ controller: AddItemViewController, didFinishAdding item: ChecklistItem ){
        let newRowIndex = items.count
        items.append(item)
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: UITableViewRowAnimation.automatic)
        dismiss(animated: true, completion: nil)
        CategoryDelegate.addItemToCategory(self, didFinishAdding: item, itemCategory: currentCategory)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        items.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
    override func viewDidLoad() {
        self.title = self.CategoryName
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? CheckListItemCell {
            configureCheckMark(for: cell, at: indexPath)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckListsItem", for: indexPath) as! CheckListItemCell
        configureText(for: cell, at: indexPath)
        configureCheckMark(for: cell, at: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func configureCheckMark(for cell : CheckListItemCell, at indexPath: IndexPath) {
        let item = items[indexPath.row]
        item.toggleChecked()
        if item.checked{
            cell.checkMark.text = "✅"
        }
        else {
            cell.checkMark.text = ""
        }
    }
    
    func configureText(for cell : CheckListItemCell, at indexPath : IndexPath) {
        let item = items[indexPath.row]
        cell.itemTitleLabel?.text = item.text
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "AddItemViewController" {
            if let navigationController = segue.destination as? UINavigationController {
                let controller = navigationController.topViewController! as! AddItemViewController; controller.delegate = self
            }
        }
        else {
            if segue.identifier == "EditViewController" {
                if let navigationController = segue.destination as? UINavigationController {
                    let controller = navigationController.topViewController! as! AddItemViewController
                    controller.delegate = self
                    if let indexPath = tableView.indexPath(for: sender as! UITableViewCell)  {
                        controller.itemToEdit = items[indexPath.row]
                    }
                }
            }
        }
    }
}

protocol UpdateCategoryItemsDelegate : class{
    func addItemToCategory( _ controller: ChecklistViewController, didFinishAdding item: ChecklistItem, itemCategory: CategoryListItem)
    func addItemToCategory(_ controller: ChecklistViewController, didFinishEditing item: ChecklistItem, itemCategory: CategoryListItem, categoryIndex: Int, ItemIndex: Int)
}

