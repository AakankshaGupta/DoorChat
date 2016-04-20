//
//  LoginViewController.swift
//  DoorChat
//
//  Created by Aseem14 on 23/02/16.
//  Copyright © 2016 Aseem14. All rights reserved.
//

import UIKit
import SwiftyJSON


class LoginViewController: LatitudeLongitudeViewController{
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var activityview: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        activityview.hidden = true
        
    }
    
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewWillAppear(true)
        self.locationset()
        
        
    }
    
    
    //IBActions...
    @IBAction func backbtn(sender: AnyObject) {
        
        navigationController?.popToRootViewControllerAnimated(true)
    }
    
    @IBAction func forgotpasswordbtn(sender: AnyObject)
    {
        
        print("Forgot Password...")
        
        
    }
    
    @IBAction func signinbtn(sender: AnyObject)
    {
        
        guard let myemail = email.text,mypass = password.text else{return}
        
        self.activityview.hidden = false
        self.activityview.startAnimating()
        
        HTTPManager.mainapi(APIManager.login_url, withParameters: [ "email": myemail,"password": mypass,"lat": self.mylat!,"lng": self.mylon!,"device_token":"123", "address": "Sec 28", "city": "Chandigarh","country": "India"],success:
            {
                (response) -> () in
                print(response)
                guard let myresponse = response else{return}
                let json = JSON(myresponse)
                self.fbtoken = json["token"].stringValue
                guard let destination = self.storyboard?.instantiateViewControllerWithIdentifier("RootViewController") as? RootViewController else{return}

                destination.fbtoken = self.fbtoken
                self.navigationController?.pushViewController(destination, animated: true)
                
            }) { (NSError) -> () in
                print(".....error....")
                print(NSError)
        }
    }
    
    
    @IBAction func registernewUser(sender: AnyObject)
    {
        
        guard let destination = self.storyboard?.instantiateViewControllerWithIdentifier("v2") as?NewRegisterViewController else {return}
        self.navigationController?.pushViewController(destination, animated: true)
        
    }
    
    
    func dismissKeyboard()
    {
        view.endEditing(true)
        
    }
    
    
}
