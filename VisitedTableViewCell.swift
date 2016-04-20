//
//  VisitedTableViewCell.swift
//  DoorChat
//
//  Created by Aseem14 on 02/03/16.
//  Copyright © 2016 Aseem14. All rights reserved.
//

import UIKit

class VisitedTableViewCell: UITableViewCell
{

    @IBOutlet weak var visited_door_image: UIImageView!
    @IBOutlet weak var visited_door_tym: UILabel!
    @IBOutlet weak var visited_door_name: UILabel!
    @IBOutlet weak var visitedview: UIView!
    @IBOutlet weak var visitedmembers: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
       
        visitedview.layer.borderWidth=1.0
        visitedview.layer.masksToBounds = false
        visitedview.layer.borderColor = UIColor.whiteColor().CGColor
        visitedview.layer.cornerRadius = 10
        visitedview.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func chat_visited_door(sender: AnyObject) {
        
    }

}
