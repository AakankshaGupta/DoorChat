//
//  CommentViewController.swift
//  DoorChat
//
//  Created by Aseem14 on 02/03/16.
//  Copyright © 2016 Aseem14. All rights reserved.
//

import UIKit
import SwiftyJSON

class CommentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var comment_text_view: UITextField!
    
    
    var mytoken : String?
    var mypost_id: String?
    var mydoor_id : String?
    var comment_desc : String?
    var p_comment_id: String = "0"
    var array1 = [User]()
    var name : String?
    var dp : String?
   
    var comment_tym : String?
    var comment_likes : String?
    var sub_comments : String?
    
    @IBOutlet weak var comment_table_view: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
       self.comment_api()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    func comment_api()
    {
        guard let token = self.mytoken , door_id = self.mydoor_id, post_id = self.mypost_id else {return}
        HTTPManager.mainapi(APIManager.comment_post, withParameters: ["token":token, "door_id": door_id, "post_id": post_id, "p_comment_id": ""], success: { (response) -> () in
            print(response)
            guard let myresponse = response else{return}
            let json = JSON(myresponse)
            self.array1 = User.changeDictToUserArray(json["content"].arrayValue)
            self.comment_table_view.reloadData()
            }) { (error) -> () in
                
        }
    }
    
      func add_comment_api()
    {
        let newcomment = User()
        
        newcomment.FullName = self.name
        newcomment.post_comment_desc = comment_text_view.text
        newcomment.created_time = self.comment_tym
        newcomment.is_like = self.comment_likes
        newcomment.Profile_Picture = self.dp
        
        guard let token = self.mytoken , door_id = self.mydoor_id, post_id = self.mypost_id else {return}
        HTTPManager.mainapi(APIManager.add_comment_post, withParameters: ["token":token, "door_id": door_id, "post_id": post_id,"comment_desc": comment_text_view.text! ,"p_comment_id": "0"], success: { (response) -> () in
            print(response)
            self.array1.append(newcomment)
            self.comment_text_view.text = ""
            self.comment_table_view.reloadData()
            }) { (error) -> () in
                
        }
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return array1.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let object = self.array1[indexPath.row]
        guard let cell = tableView.dequeueReusableCellWithIdentifier("CommentTableViewCell") as? CommentTableViewCell  else { return UITableViewCell() }
        cell.fullname.text = object.FullName
        self.name = object.FullName
        cell.profile_picture.sd_setImageWithURL(NSURL(string: (object.Profile_Picture)!))
        self.dp = object.Profile_Picture
        cell.comment_desc.text = object.post_comment_desc
        self.comment_desc = object.post_comment_desc
        cell.comment_likes.text = object.is_like
        self.comment_likes = object.is_like
        cell.subcomments.text = object.comment_count
        self.sub_comments = object.comment_count
        cell.comment_tym.text = object.created_time
        self.comment_tym = object.created_time
        return cell
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        self.comment_table_view.estimatedRowHeight = UITableViewAutomaticDimension
        self.comment_table_view.rowHeight = UITableViewAutomaticDimension
        return self.comment_table_view.rowHeight
    }
   
    @IBAction func add_comment(sender: AnyObject) {
        comment_api()
        add_comment_api()
    }

    @IBAction func back_btn(sender: AnyObject) {
         navigationController?.popViewControllerAnimated(true)
    }
}
