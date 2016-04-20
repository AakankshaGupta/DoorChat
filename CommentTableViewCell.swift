//
//  CommentTableViewCell.swift
//  DoorChat
//
//  Created by cbluser113 on 21/12/1937 SAKA.
//  Copyright © 1937 SAKA Aseem14. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var profile_picture: UIImageView!
    @IBOutlet weak var fullname: UILabel!
    @IBOutlet weak var comment_desc: UILabel!
    @IBOutlet weak var comment_likes: UILabel!
    @IBOutlet weak var subcomments: UILabel!
    @IBOutlet weak var comment_tym: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profile_picture.layer.borderWidth=1.0
        profile_picture.layer.masksToBounds = false
        profile_picture.layer.cornerRadius = profile_picture.frame.height/2
        profile_picture.layer.borderColor = UIColor(red:47/255.0, green:36/255.0, blue:37/255.0, alpha: 1.0).CGColor
        profile_picture.clipsToBounds = true
        self.comment_desc.preferredMaxLayoutWidth = UIScreen.mainScreen().bounds.size.width - 100

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
