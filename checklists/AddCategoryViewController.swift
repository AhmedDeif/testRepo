//
//  AddCategoryViewController.swift
//  checklists
//
//  Created by Ahmed Abodeif on 4/29/17.
//  Copyright © 2017 Ahmed Abodeif. All rights reserved.
//

import UIKit

class AddCategoryViewController: UITableViewController,PickCategoryIconDelegate {
    
    var delegate: AddCategoryViewControllerDelegate!
    var ChosenCategoryIcon = "No Icon.png"
    
    @IBOutlet weak var AddIconButton: UIButton!

    @IBOutlet weak var categoryNameTextfield: UITextField!
    
    @IBAction func cancelAddingCategory(_ sender: Any) {
        delegate.AddCategoryViewControllerDelegateCancelAddCategory(self);
        print("clicked cancel")
    }
   
    @IBAction func AddNewCategory(_ sender: Any) {
        let categoryItem = CategoryListItem()
        categoryItem.categoryName = categoryNameTextfield.text!
        categoryItem.CategoryIcon = ChosenCategoryIcon
        delegate.AddCategoryViewControllerDelegateAddCategory(self, didFinishAdding: categoryItem);
    }
    
    func CategoryIconChosen( _ controller: IconSelectionTableViewController, CategoryIconName: String){
        self.ChosenCategoryIcon = CategoryIconName
        AddIconButton.setImage(UIImage(named: CategoryIconName), for: .normal)
        print("tb ma ana dost")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "ChoseCategoryIcon" {
            let controller = segue.destination as? IconSelectionTableViewController
            controller?.delegate = self
        }
    }


}


protocol AddCategoryViewControllerDelegate: class {
    func AddCategoryViewControllerDelegateAddCategory( _ controller: AddCategoryViewController, didFinishAdding item: CategoryListItem)
    func AddCategoryViewControllerDelegateCancelAddCategory( _ controller: AddCategoryViewController)
}
