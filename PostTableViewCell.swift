//
//  PostTableViewCell.swift
//  DoorChat
//
//  Created by cbluser113 on 20/12/1937 SAKA.
//  Copyright © 1937 SAKA Aseem14. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var time_label: UILabel!
    @IBOutlet weak var post_image: UIImageView!
    @IBOutlet weak var post_title: UILabel!
    @IBOutlet weak var post_desc: UILabel!
    @IBOutlet weak var like_count: UILabel!
    @IBOutlet weak var comment_count: UILabel!
    @IBOutlet weak var post_btn: UIButton!
    @IBOutlet weak var like_btn: UIButton!
    @IBOutlet weak var like_pressed: UIButton!
    @IBOutlet weak var post_view: UIView!
   
     
    
    override func awakeFromNib() {
        super.awakeFromNib()
        post_image.layer.borderWidth=1.0
        post_image.layer.masksToBounds = false
        post_image.layer.cornerRadius = post_image.frame.height/2
        post_image.layer.borderColor = UIColor(red:47/255.0, green:36/255.0, blue:37/255.0, alpha: 1.0).CGColor
        post_image.clipsToBounds = true
        post_view.layer.borderWidth=1.0
        post_view.layer.masksToBounds = false
        post_view.layer.cornerRadius = 2
        post_view.layer.borderColor =  UIColor(red:1.0, green:1.0, blue:1.0, alpha: 1.0).CGColor
        post_view.clipsToBounds = true
        
    }
    
    

    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
