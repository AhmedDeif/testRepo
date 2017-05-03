//
//  CheckListItemCell.swift
//  checklists
//
//  Created by Ahmed Abodeif on 4/17/17.
//  Copyright © 2017 Ahmed Abodeif. All rights reserved.
//

import UIKit

class CheckListItemCell: UITableViewCell {
    
    @IBOutlet var itemTitleLabel : UILabel!
    @IBOutlet var checkMark: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        itemTitleLabel.text = ""
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
}
