//
//  ExpandableTableViewCell.swift
//  DoorChat
//
//  Created by cbluser113 on 01/01/1938 SAKA.
//  Copyright © 1938 SAKA Aseem14. All rights reserved.
//

import UIKit

class ExpandableTableViewCell: UITableViewCell {

    @IBOutlet weak var allCount: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func allEntries(sender: AnyObject) {
        
    }
}
