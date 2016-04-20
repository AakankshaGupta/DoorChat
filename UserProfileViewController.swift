//
//  UserProfileViewController.swift
//  DoorChat
//
//  Created by Aseem14 on 29/02/16.
//  Copyright © 2016 Aseem14. All rights reserved.
//

import UIKit
import SwiftyJSON


class UserProfileViewController: LatitudeLongitudeViewController {
    
    @IBOutlet weak var UserDp: UIImageView!
    @IBOutlet weak var UserName: UILabel!
    @IBOutlet weak var UserAddress: UILabel!
    
    
    var username : String?
    var useraddress : String?
    var userdp: String?
    
    var token : String?
    
    
   
    var array2 : [User] = []
    var i: Int = 0
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        
    }
    
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(true)
        UserName.text = username
        UserAddress.text = useraddress
        self.locationset()
        guard let dp = userdp else{return}
        self.UserDp.sd_setImageWithURL(NSURL(string: (dp)))
    }
    
    
    @IBAction func settingsBtn(sender: AnyObject) {
        
        guard let destination = self.storyboard?.instantiateViewControllerWithIdentifier("SettingsViewController") as?SettingsViewController else {return}
        self.navigationController?.pushViewController(destination, animated: true)

    }
    
    @IBAction func goback(sender: AnyObject)
    {
        navigationController?.popViewControllerAnimated(true)
    }
    
    
    @IBAction func manageDoors(sender: AnyObject) {
        
        guard let mytoken = token, my_lat = self.mylat, my_lng = self.mylon else {return}
        HTTPManager.mainapi(APIManager.manage_doors, withParameters: ["token":mytoken,"page":"1","my_lat":my_lat,"my_lng":my_lng], success: { (response) -> () in
            
            print(response)
            guard let myResponse = response else {return}
            let json = JSON(myResponse)
            self.array1 = User.changeDictToUserArray(json["myCreatedDoors"].arrayValue)
            self.array2 = User.changeDictToUserArray(json["myVisitedDoors"].arrayValue)
            
            
    guard let destination = self.storyboard?.instantiateViewControllerWithIdentifier("ManageDoorsViewController") as? ManageDoorsViewController else {return}
            
            
            destination.total_visited_doors = json["total_visited"].stringValue
            destination.total_created_doors = json["total_mycreated"].stringValue
            
            destination.table_created_array = self.array1
            destination.table_visited_array = self.array2
            destination.myjson = json
            
            self.navigationController?.pushViewController(destination, animated: true)
            
            }) { (error) -> () in
                
        }
        
        
    }
    
}
