//
//  CategoryItemTableViewCell.swift
//  checklists
//
//  Created by Ahmed Abodeif on 4/29/17.
//  Copyright © 2017 Ahmed Abodeif. All rights reserved.
//

import UIKit

class CategoryItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var CategoryLabel: UILabel!
    @IBOutlet weak var CategoryListCount: UILabel!
    @IBOutlet weak var CategoryIconView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
