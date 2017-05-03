//
//  CategoriesTableViewController.swift
//  checklists
//
//  Created by Ahmed Abodeif on 4/29/17.
//  Copyright © 2017 Ahmed Abodeif. All rights reserved.
//

import UIKit

class CategoriesTableViewController: UITableViewController, AddCategoryViewControllerDelegate, UpdateCategoryItemsDelegate {
    
    var categories: [CategoryListItem]
    
    required init?(coder aDecoder: NSCoder) {
        //  Creating temporary items list
        var items = [ChecklistItem]()
        let row0item = ChecklistItem()
        row0item.text = "Walk the dog"
        row0item.checked = false
        items.append(row0item)
        let row1item = ChecklistItem()
        row1item.text = "Brush my teeth"
        row1item.checked = true
        items.append(row1item)
        let row2item = ChecklistItem()
        row2item.text = "Learn iOS development"
        row2item.checked = true
        items.append(row2item)
        let row3item = ChecklistItem()
        row3item.text = "Soccer practice"
        row3item.checked = false
        items.append(row3item)
        let row4item = ChecklistItem()
        row4item.text = "Eat ice cream"
        row4item.checked = true
        items.append(row4item)
        categories = []
        categories = [CategoryListItem]()
        let row0Category = CategoryListItem()
        row0Category.categoryName = "Category 1"
        row0Category.CategoryIcon = "Inbox.png"
        row0Category.items = items
        let row1Category = CategoryListItem()
        row1Category.categoryName = "Category 2"
        row1Category.items = items
        row1Category.CategoryIcon = "Photos.png"
        categories.append(row0Category)
        categories.append(row1Category)
        super.init(coder: aDecoder)
    }


    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func addItemToCategory( _ controller: ChecklistViewController, didFinishAdding item: ChecklistItem, itemCategory: CategoryListItem) {
        print("bywsal li el category aho")
        
        var categoryIndex = categories.index(of: itemCategory)
        self.categories[categoryIndex!].items.append(item)
        let indexPath = IndexPath(row: categoryIndex!, section: 0)
        let indexPaths = [indexPath]
        tableView.reloadRows(at: indexPaths, with: UITableViewRowAnimation.automatic)
    }
   
    func addItemToCategory(_ controller: ChecklistViewController, didFinishEditing item: ChecklistItem, itemCategory: CategoryListItem, categoryIndex: Int, ItemIndex :Int) {
        
//        var oldItem = categories[categoryIndex].items.index(of: <#T##ChecklistItem#>)
        
        
        categories[categoryIndex].items[ItemIndex] = item
        
//        let newRowIndex = categories[selectedCategory].items.index(of: controller.itemToEdit)!
//        items[newRowIndex] = item
        let indexPath = IndexPath(row:categoryIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.reloadRows(at: indexPaths, with: UITableViewRowAnimation.automatic)
        

    }
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("The number of rows should be \(categories.count)")
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryItemTableViewCell", for: indexPath) as! CategoryItemTableViewCell
        configureText(for: cell, at: indexPath)
        configureItemCount(for: cell, at:indexPath)
        configureCategoryIcon(for: cell, at:indexPath)
        return cell
    }
    
    func configureCategoryIcon(for cell : CategoryItemTableViewCell, at indexPath : IndexPath) {
//        let catNAME = categories[indexPath.row].CategoryIcon
        let image = UIImage(named: categories[indexPath.row].CategoryIcon)
//        let image = UIImage(named:catNAME )
        cell.CategoryIconView.image = image
    }
    
    func configureText(for cell : CategoryItemTableViewCell, at indexPath : IndexPath) {
        let category = categories[indexPath.row]
        cell.CategoryLabel?.text = category.categoryName
    }
    
    func configureItemCount(for cell: CategoryItemTableViewCell, at indexPath : IndexPath){
        let category = categories[indexPath.row]
        cell.CategoryListCount?.text = String(category.items.count)
    }
    
    func AddCategoryViewControllerDelegateAddCategory( _ controller: AddCategoryViewController, didFinishAdding item: CategoryListItem){
        let newRowIndex = categories.count
        categories.append(item)
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: UITableViewRowAnimation.automatic)
        print("gamed we clicked add")
        dismiss(animated: true, completion: nil)
    }
    
    func AddCategoryViewControllerDelegateCancelAddCategory( _ controller: AddCategoryViewController){
        print("gamed we clicked CANCEL")
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? CategoryListItem {
            print("picked a cell")
            
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "AddNewCategory" {
            if let navigationController = segue.destination as? UINavigationController {
                let controller = navigationController.topViewController! as! AddCategoryViewController
                controller.delegate = self
            }
        }
        if segue.identifier == "CategoryDetails" {
            if let indexPath = tableView.indexPathForSelectedRow{
                let selectedRow = indexPath.row
                let controller = segue.destination as? ChecklistViewController
                controller?.CategoryDelegate = self
                controller?.currentCategory = categories[selectedRow]
                controller?.items = categories[selectedRow].items
                controller?.selectedCategoryIndex = selectedRow
                controller?.CategoryName = categories[selectedRow].categoryName
            }
        }
        if segue.identifier == "ChoseCategoryIcon" {
            let controller = segue.destination as? IconSelectionTableViewController
        }
    }
}
