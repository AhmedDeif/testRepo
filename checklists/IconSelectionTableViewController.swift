//
//  IconSelectionTableViewController.swift
//  checklists
//
//  Created by Ahmed Abodeif on 5/2/17.
//  Copyright © 2017 Ahmed Abodeif. All rights reserved.
//

import UIKit

class IconSelectionTableViewController: UITableViewController {
    
    var IconTypes: [String] = []
    var delegate : PickCategoryIconDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        initIconCells()
        
    }
    
    func initIconCells() {
        IconTypes.append("No Icon.png")
        IconTypes.append("Appointments.png")
        IconTypes.append("Birthdays.png")
        IconTypes.append("Chores.png")
        IconTypes.append("Drinks.png")
        IconTypes.append("Folder.png")
        IconTypes.append("Groceries.png")
        IconTypes.append("Inbox.png")
        IconTypes.append("Photos.png")
        IconTypes.append("Trips.png")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return IconTypes.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? IconSelectionTableViewCell {
            delegate.CategoryIconChosen(self, CategoryIconName: IconTypes[indexPath.row])
        }
        dismiss(animated: true, completion: nil)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> IconSelectionTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IconSelectionCell", for: indexPath) as?  IconSelectionTableViewCell
        cell?.IconName = IconTypes[indexPath.row]
        let image = UIImage(named: (cell?.IconName)!)
        cell?.imageView?.image = image
        return cell!
    }
    

}

protocol PickCategoryIconDelegate : class{
    func CategoryIconChosen( _ controller: IconSelectionTableViewController, CategoryIconName: String)
}
