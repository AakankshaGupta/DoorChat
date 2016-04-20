//
//  MainViewController.swift
//  DoorChat
//
//  Created by Aseem14 on 04/03/16.
//  Copyright © 2016 Aseem14. All rights reserved.
//

import UIKit
import SwiftyJSON

protocol BtnMovedDelegate
{
    func moveUp()
    func moveDown()
    func postpage(vc:UIViewController)
}

class MainViewController: UIViewController, UITableViewDataSource,UITableViewDelegate{
    
    
    @IBOutlet weak var main_table_view: UITableView!
    
    var delegate:BtnMovedDelegate?

    var main_array : [User]?
    var fb_token : String?
    var door_id: String?
    var dImage : String?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(true)
        guard let destination = self.storyboard?.instantiateViewControllerWithIdentifier("MainViewController") as? MainViewController else {return}
       
        if(destination == true)
        {
        self.main_table_view.reloadData()
        }
        else
        {
            // load addpost
        }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView)
    {
        
        if(main_table_view.scrollIndicatorInsets.top < scrollView.contentOffset.y)
        {
          self.delegate?.moveUp()
        }
        else
        {
          self.delegate?.moveDown()
        }
    }
    
      func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
   
    {
        
        return (self.main_array?.count)!
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
       
        let object = self.main_array![indexPath.row]
    guard let cell = tableView.dequeueReusableCellWithIdentifier("MyDoorsTableViewCell") as? MyDoorsTableViewCell, door_image = object.door_image else { return UITableViewCell()
        }
        cell.main_image.sd_setImageWithURL(NSURL(string: (door_image)))
        self.dImage = door_image
        cell.main_title.text = object.door_title
        cell.main_tym.text = object.door_tym
        cell.people_count.text = object.door_total_member
        self.door_id = object.door_id
        
        return cell
    }
    

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
      {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        guard let destination = self.storyboard?.instantiateViewControllerWithIdentifier("PostViewController") as? PostViewController else {return}
        
        let object = self.main_array![indexPath.row]
        destination.door_id = object.door_id
        destination.token = self.fb_token
        destination.image = self.dImage
        
        self.delegate?.postpage(destination)
    }
    
        
    }
    
