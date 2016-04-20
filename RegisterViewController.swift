//
//  RegisterViewController.swift
//  DoorChat
//
//  Created by Aseem14 on 23/02/16.
//  Copyright © 2016 Aseem14. All rights reserved.
//

import UIKit
import SwiftyJSON

class RegisterViewController: LatitudeLongitudeViewController,UITextFieldDelegate {
    
    var FullName: String = ""
    var UserName : String = ""
    var UserImage : UIImage?
    var UserGender : String?
   
    
    @IBOutlet weak var activityview: UIActivityIndicatorView!
    @IBOutlet weak var mylabel: UILabel!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    
    override func viewDidLoad()
    {
        
        super.viewDidLoad()
        activityview.hidden = true
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        self.mylabel.preferredMaxLayoutWidth = UIScreen.mainScreen().bounds.size.width
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewWillAppear(false)
        
        self.locationset()
        
    }
    
    
    func dismissKeyboard()
    {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
        
    }
    
    @IBAction func backrootview(sender: AnyObject) {
        
        navigationController?.popToRootViewControllerAnimated(true)
        
    }
    
    @IBAction func registerbtn(sender: AnyObject)
    {
        print("registering.....")
        self.activityview.hidden = false
        self.activityview.startAnimating()
        guard let myemail = self.email.text, mypass = self.password.text,mygen = self.UserGender, image = self.UserImage , latitude = mylat, longitude = mylon else{return}
        
        HTTPManager.postFileWithParameters(APIManager.register_url, paramerters:  ["fullname": self.FullName,"username" :self.UserName,"email":myemail,"password":mypass,"lat": latitude,"lng": longitude,"device_token":"123", "gender":mygen], profilePic: image, success:
            {
                (response) -> () in
                print("......success.....")
                print(response)
                guard let myResponse = response else {return}
                let json = JSON(myResponse)
                self.array1 = User.changeDictToUserArray(json["user_profile"].arrayValue)
                print(self.array1)
                
                guard let destination = self.storyboard?.instantiateViewControllerWithIdentifier("RootViewController") as? RootViewController else {return}
                self.navigationController?.pushViewController(destination, animated: true)
                
            }){
                (NSError) -> () in
                print("........error...........")
                print(NSError)
        }
    }
    
    func senddata(name1 :String,username1:String, image1:UIImage, gender: String)
        
    {
        FullName = name1
        UserName = username1
        UserImage = image1
        UserGender = gender
    }
    
    
}