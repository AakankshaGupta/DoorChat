//
//  ManageDoorsViewController.swift
//  DoorChat
//
//  Created by Aseem14 on 29/02/16.
//  Copyright © 2016 Aseem14. All rights reserved.
//

import UIKit
import SwiftyJSON

class ManageDoorsViewController: UIViewController, UITableViewDelegate , UITableViewDataSource {
    
    
    @IBOutlet weak var created_table_view: UITableView!
    
    
    var total_created_doors: String?
    var expandableTableView = ExpandableTableView()
    var total_visited_doors: String?
    var table_created_array: [User] = []
    var table_visited_array: [User] = []
    var myjson : JSON?
    var cell = UITableViewCell()
    var screenSize: CGRect = UIScreen.mainScreen().bounds
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        cell = (created_table_view.dequeueReusableCellWithIdentifier("ExpandableTableViewCell") as? ExpandableTableViewCell)!
        cell.hidden = false
        created_table_view.reloadData()
        
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func popscreen(sender: AnyObject) {
        
        navigationController?.popViewControllerAnimated(true)
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let cell = tableView.dequeueReusableCellWithIdentifier("ExpandableTableViewCell") as? ExpandableTableViewCell
       
            if(section == 1)
            {
                if(cell?.hidden == false)
                {
                    return 4
                }
                else
                {
                return table_created_array.count
                }
            }
            else
            {
                return table_visited_array.count
            }
        }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        cell = (tableView.dequeueReusableCellWithIdentifier("ExpandableTableViewCell") as? ExpandableTableViewCell)!
        
        if(cell.hidden == true)
        {
            if(indexPath.row < table_created_array.count)
            {
                
                let object = self.table_created_array[indexPath.row]
                guard let cell = tableView.dequeueReusableCellWithIdentifier("CreatedTableViewCell") as? CreatedTableViewCell, door_image = object.door_image else { return UITableViewCell()}
                cell.craeted_door_name.text = object.door_title
                cell.created_door_image.sd_setImageWithURL(NSURL(string: (door_image)))
                cell.craeted_door_tym.text = object.door_tym
                cell.door_total_member.text = object.door_total_member
                return cell
            }
            else{
                let object = self.table_visited_array[indexPath.row]
                guard let cell = tableView.dequeueReusableCellWithIdentifier("VisitedTableViewCell") as? VisitedTableViewCell, door_image = object.door_image else { return UITableViewCell() }
                cell.visited_door_name.text = object.door_title
                cell.visited_door_image.sd_setImageWithURL(NSURL(string: (door_image)))
                cell.visited_door_tym.text = object.door_tym
                cell.visitedmembers.text = object.door_total_member
                
                return cell
                
            }
        }
        else
        {
            if(indexPath.row < 3)
            {
                let object = self.table_created_array[indexPath.row]
                guard let cell = tableView.dequeueReusableCellWithIdentifier("CreatedTableViewCell") as? CreatedTableViewCell, door_image = object.door_image else { return UITableViewCell()}
                cell.craeted_door_name.text = object.door_title
                cell.created_door_image.sd_setImageWithURL(NSURL(string: (door_image)))
                cell.craeted_door_tym.text = object.door_tym
                cell.door_total_member.text = object.door_total_member
                
                print(cell.frame)
                return cell
                
            }
            else
            {
                guard let cell = tableView.dequeueReusableCellWithIdentifier("ExpandableTableViewCell") as? ExpandableTableViewCell else {return UITableViewCell()}
                
                return cell
            }
        }
        
    }
    
    @IBAction func allDoors(sender: AnyObject) {
        
        cell = (created_table_view.dequeueReusableCellWithIdentifier("ExpandableTableViewCell") as? ExpandableTableViewCell)!
        cell.hidden = true
        created_table_view.reloadData()
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if(section == 1)
        {
            guard let total_doors = self.total_created_doors else{ return "" }
            return "DOORS CREATED BY ME (\(total_doors))"
        }
        else
        {
            guard let total_doors = self.total_visited_doors else{ return "" }
            return "FREQUENTLY VISITED (\(total_doors))"
        }
        
    }
    
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        guard let header = view as? UITableViewHeaderFooterView else{return}
        header.textLabel?.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        header.textLabel?.textAlignment = .Center
        header.textLabel?.font = UIFont.boldSystemFontOfSize(11)
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        
        self.created_table_view.estimatedRowHeight = UITableViewAutomaticDimension
        self.created_table_view.rowHeight = UITableViewAutomaticDimension
        return self.created_table_view.rowHeight
    }
    
}
