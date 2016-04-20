//
//  CreatedTableViewCell.swift
//  DoorChat
//
//  Created by Aseem14 on 02/03/16.
//  Copyright © 2016 Aseem14. All rights reserved.
//

import UIKit

class CreatedTableViewCell: UITableViewCell {

    @IBOutlet weak var chatBtn: UIButton!
    @IBOutlet weak var craeted_door_name: UILabel!
    @IBOutlet weak var created_door_image: UIImageView!
    @IBOutlet weak var craeted_door_tym: UILabel!
    @IBOutlet weak var door_total_member: UILabel!
    @IBOutlet weak var totalmemberview: UIView!
    
    var door_name : String?{
        didSet {
            guard let s = door_name else { return }
            self.craeted_door_name.text = s
        }
    }
    
    var door_image : String?{
        didSet {
            guard let s = door_name else { return }
            self.created_door_image.sd_setImageWithURL(NSURL(string:(s)))
        }
    }
    var door_tym : String?{
        didSet {
            guard let s = door_tym else { return }
            self.craeted_door_tym.text = s
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        totalmemberview.layer.borderWidth=1.0
        totalmemberview.layer.masksToBounds = false
        totalmemberview.layer.borderColor = UIColor.blackColor().CGColor
        totalmemberview.layer.cornerRadius = 10
        totalmemberview.clipsToBounds = true
        chatBtn.layer.borderWidth=2.0
        chatBtn.layer.masksToBounds = false
        chatBtn.layer.borderColor = UIColor(red:81/255.0, green:180/255.0, blue:245/255.0, alpha: 1.0).CGColor
        chatBtn.layer.cornerRadius = 5
        chatBtn.clipsToBounds = true


        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func chat_created_door(sender: AnyObject) {
        
        
    }

}
