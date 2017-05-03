//
//  AddItemViewController.swift
//  checklists
//
//  Created by Ahmed Abodeif on 4/22/17.
//  Copyright © 2017 Ahmed Abodeif. All rights reserved.
//

import UIKit


class AddItemViewController: UITableViewController{
    
    var delegate: AddItemViewControllerDelegate!
    var itemToEdit: ChecklistItem!
    
    @IBOutlet weak var textfiled: UITextField!
    var checkListItem: ChecklistItem!
    
    @IBAction func cnacel(_ sender: Any) {
        //  I need to add an if condiiotn here to handle the sender
        delegate.addItemViewControllerDidCancel(self)
    }
    
    @IBAction func done(_ sender: Any) {
        if(self.itemToEdit != nil) {
             let item = ChecklistItem()
            item.checked = itemToEdit.checked
            item.text = textfiled.text!
            delegate.addItemViewController(self,didFinishEditing: item)
        }
        else {
            let item = ChecklistItem()
            item.checked = false
            item.text = textfiled.text ?? "Empty Text"
            delegate.addItemViewController(self,didFinishAdding: item)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //  I need to check of checkListItem is no Nil
        
        if(self.itemToEdit != nil){
            print("This is an edit item screen")
            //  Add the previous item text in the place holder.
            textfiled.text = itemToEdit.text
            
        }
        else {
            print("This is an item creation screen")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

protocol AddItemViewControllerDelegate: class {
    func addItemViewControllerDidCancel( _ controller: AddItemViewController)
    func addItemViewController( _ controller: AddItemViewController, didFinishAdding item: ChecklistItem)
    func addItemViewController(_ controller: AddItemViewController, didFinishEditing item: ChecklistItem)
}

