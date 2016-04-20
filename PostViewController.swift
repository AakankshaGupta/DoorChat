//
//  PostViewController.swift
//  DoorChat
//
//  Created by Aseem14 on 04/03/16.
//  Copyright © 2016 Aseem14. All rights reserved.
//

import UIKit
import SwiftyJSON

class PostViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var post_table_view: UITableView!
    @IBOutlet weak var door_image: UIImageView!
    @IBOutlet weak var post_liked: UIButton!
    @IBOutlet weak var door_title: UILabel!
     @IBOutlet weak var door_address: UILabel!
    
   
    var token: String?
    var door_id: String?
    var selectedimage: UIImage?
    var id: String?
    var image : String?
    var like_check : String?
    var array1 = [User]()
    var bool_btn : Bool = true
    var selectedCell :PostTableViewCell?
    var tapGesture : UITapGestureRecognizer?
    var post : PostView!
    var screenSize: CGRect = UIScreen.mainScreen().bounds
     var originalOrigin: CGFloat?
     var oButton: UIButton = UIButton(type: .RoundedRect)
    var floatingButtonFrame: CGRect?
    var dp : String?
    var name : String?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.addOverlayButton()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        tapGesture = UITapGestureRecognizer(target: self, action: Selector("recognizeTapGesture:"))
        view.addGestureRecognizer(tapGesture!)
              self.post_api()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func like_btn(sender: AnyObject) {
        HTTPManager.mainapi(APIManager.like_post, withParameters: ["token":self.token!,"id":self.id!,"door_id":self.door_id!], success: { (response) -> () in
            print(response)
            guard let myresponse = response else{return}
            let json = JSON(myresponse)
          self.like_check = json["content"].stringValue
            self.post_table_view.reloadData()
            }) { (error) -> () in
                
        }
    }
    @IBAction func like_pressed_btn(sender: AnyObject) {
        bool_btn = true
        self.like_check = "Post Unlike"
        post_table_view.reloadData()
    }
    
       @IBAction func comment_btn(sender: AnyObject)
    {
        guard let destination = self.storyboard?.instantiateViewControllerWithIdentifier("CommentViewController") as?CommentViewController else {return}
         destination.mytoken = self.token
         destination.mydoor_id = self.door_id
         destination.mypost_id = self.id
         destination.dp = self.dp
         destination.name = self.name
        self.navigationController?.pushViewController(destination, animated: true)
    }
  
    func post_api()
    {
     
    HTTPManager.mainapi(APIManager.fetch_door_single, withParameters: ["token": self.token!, "page": "1", "door_id": self.door_id!], success: { (response) -> () in
        print(".......mydoorlist.......")
        print(response)
        guard let myresponse = response else{return}
        let json = JSON(myresponse)
        self.array1 = User.changeDictToUserArray(json["content"].arrayValue)
        self.image = json["door_image"].stringValue
        self.door_image.sd_setImageWithURL(NSURL(string: (self.image)!))
        self.door_title.text = json["door_title"].stringValue
        self.post_table_view.reloadData()
        }) { (error) -> () in
          print(error)
       }
       }
 
        
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return array1.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let object = self.array1[indexPath.row]
        guard let cell = tableView.dequeueReusableCellWithIdentifier("PostTableViewCell") as? PostTableViewCell  else { return UITableViewCell() }
        cell.like_pressed.hidden = true
        cell.post_image.sd_setImageWithURL(NSURL(string: (object.Profile_Picture)!))
        self.dp = object.Profile_Picture
        cell.post_title.text = object.FullName
        self.name = object.FullName
        cell.post_desc.text = object.post_desc
        cell.like_count.text = object.like_count
        cell.comment_count.text = object.comment_count
        cell.time_label.text = object.created_time
        self.id = object.door_id
        cell.like_pressed.hidden = bool_btn
        
        if(self.like_check == "Post Likes")
        {

            cell.like_pressed.hidden = false
            cell.like_count.text = "\(1)"
        }
        
        else if(self.like_check == "Post Unlike")
        {
            cell.like_pressed.hidden = true
            cell.like_count.text = "\(0)"
            
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        guard let currentCell = tableView.cellForRowAtIndexPath(indexPath) as? PostTableViewCell else { return }
        selectedCell = currentCell
        
    }
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        self.post_table_view.estimatedRowHeight = UITableViewAutomaticDimension
        self.post_table_view.rowHeight = UITableViewAutomaticDimension
        return self.post_table_view.rowHeight
    }
    
    @IBAction func post_action_btn(sender: AnyObject) {
        print(".....You are here....")
        self.post = PostView(frame:CGRect(x:-self.screenSize.width/6+185, y: 240, width: self.screenSize.width/6 , height: self.screenSize.height/6))
        self.view.addSubview(self.post)
        
    }
    
    func Post_Action(sender:UIButton!)
    {
       guard let destination = self.storyboard?.instantiateViewControllerWithIdentifier("AddPostViewController") as? AddPostViewController else {return}
        destination.door_id = self.door_id
        destination.token = self.token
        
        destination.mydoor_image = self.image
        destination.mydoor_title = self.door_title.text
        self.navigationController?.pushViewController(destination, animated: true)
    }
    
    func recognizeTapGesture(recognizer: UITapGestureRecognizer)
    {if(post == nil)
    {
      }
        else{
      self.post.hidden = true
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView)
    {
        let tableBounds: CGRect = self.post_table_view.bounds
        var floatingButtonFrame: CGRect = self.oButton.frame
        floatingButtonFrame.origin.y =  tableBounds.origin.y
    }
    
    func addOverlayButton()
    {
        self.oButton = UIButton(type: .Custom)
        self.oButton.frame = CGRectMake(230,380, 56.0, 56.0)
        oButton.layer.borderWidth=1.0
        oButton.layer.masksToBounds = false
        oButton.layer.cornerRadius = oButton.frame.height/2
        oButton.layer.borderColor = UIColor(red:81/255.0, green:182/255.0, blue:250/255.0, alpha: 1.0).CGColor
        oButton.clipsToBounds = true

        self.oButton.backgroundColor = UIColor(red: 81/255, green: 182/255, blue: 250/255, alpha: 1.0)
        self.oButton.setImage(UIImage(named: "ic_post"), forState: .Normal)
        self.oButton.addTarget(self, action: "Post_Action:", forControlEvents: .TouchUpInside)
        self.view!.insertSubview(self.oButton, aboveSubview: self.view!)
    }
    
    // to make the button float over the tableView including tableHeader
}
