//
//  CheckListItem.swift
//  checklists
//
//  Created by Ahmed Abodeif on 4/19/17.
//  Copyright © 2017 Ahmed Abodeif. All rights reserved.
//

import Foundation

class ChecklistItem : NSObject {
    
    var text = ""
    var checked = false
    
    func toggleChecked() {
        self.checked = !self.checked
        print(self.checked)
    }


}
