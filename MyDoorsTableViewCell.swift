//
//  MyDoorsTableViewCell.swift
//  DoorChat
//
//  Created by Aseem14 on 04/03/16.
//  Copyright © 2016 Aseem14. All rights reserved.
//

import UIKit

class MyDoorsTableViewCell: UITableViewCell, UIScrollViewDelegate
{

    @IBOutlet weak var main_tym: UILabel!
    @IBOutlet weak var main_title: UILabel!
    @IBOutlet weak var chat_btn: UIButton!
    @IBOutlet weak var main_image: UIImageView!
    @IBOutlet weak var people_view: UIView!
    @IBOutlet weak var people_count: UILabel!
    @IBOutlet weak var door_view: UIView!
    
    var root_obj = RootViewController()
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
       
        people_view.layer.borderWidth=1.0
        people_view.layer.masksToBounds = false
        people_view.layer.cornerRadius = 10
        people_view.layer.borderColor = UIColor(red:0/255.0, green:0/255.0, blue:0/255.0, alpha: 0.2).CGColor
        people_view.clipsToBounds = true
        self.main_title.preferredMaxLayoutWidth = UIScreen.mainScreen().bounds.size.width - 200
        chat_btn.layer.borderWidth=2.0
        chat_btn.layer.masksToBounds = false
        chat_btn.layer.borderColor = UIColor(red:81/255.0, green:180/255.0, blue:245/255.0, alpha: 1.0).CGColor
        chat_btn.layer.cornerRadius = 5
        chat_btn.clipsToBounds = true
        door_view.layer.borderWidth=1.0
        door_view.layer.masksToBounds = false
        door_view.layer.cornerRadius = 2
        door_view.layer.borderColor = UIColor(red:1.0, green:1.0, blue:1.0, alpha: 1.0).CGColor
        door_view.clipsToBounds = true


    }

    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }

    @IBAction func my_chat(sender: AnyObject) {
        
        
    }
}
