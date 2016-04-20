//
//  FirstViewController.swift
//  DoorChat
//
//  Created by Aseem14 on 23/02/16.
//  Copyright © 2016 Aseem14. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import FBSDKShareKit
import Google
import SwiftyJSON

class FirstViewController: LatitudeLongitudeViewController,GIDSignInDelegate, GIDSignInUIDelegate {
    
    // outlets..
    @IBOutlet weak var imageDoor: UIImageView!
    @IBOutlet weak var gmailbtn: UIButton!
    @IBOutlet weak var facebookbtn: UIButton!
    @IBOutlet weak var activityview: UIActivityIndicatorView!
    
    // variables..
    
    var token : String = " "
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        activityview.hidden = true
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        self.addstructure()
        self.locationset()
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    @IBAction func loginbtn(sender: AnyObject)
    {
        
        guard let destination = self.storyboard?.instantiateViewControllerWithIdentifier("v1") as?LoginViewController else {return}
        self.navigationController?.pushViewController(destination, animated: true)
        
    }
    
    
    @IBAction func loginmail(sender: AnyObject)
    {
        GIDSignIn.sharedInstance().signIn()
    }
    
    
    func signIn(signIn: GIDSignIn?, didSignInForUser user: GIDGoogleUser?,
        withError error: NSError?) {
            if (error == nil)
            {
                guard let destination = self.storyboard?.instantiateViewControllerWithIdentifier("RootViewController") as? RootViewController else{return}
                
                self.navigationController?.pushViewController(destination, animated: true)
            }
            else
            {
                guard let err = error else{return}
                print("\(err.localizedDescription)")
            }}
    
    
    @IBAction func loginfacebbok(sender: AnyObject)
        
    {
        self.activityview.hidden = false
        self.activityview.startAnimating()
        
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        
        
        fbLoginManager.logInWithReadPermissions(["email"], handler: { (result, error) -> Void in
            
            if (error == nil)
            {
                let fbloginresult : FBSDKLoginManagerLoginResult = result
                
                if result.isCancelled
                {
                    print("....User cancelled...")
                    self.activityview.hidden = true
                }
                else if(fbloginresult.grantedPermissions.contains("email"))
                {
                    self.returnUserData()
                }
            }
            else
            {
                print("....error.....")
            }
        })
    }
    
    @IBAction func registerbtn(sender: AnyObject) {
        
        guard let destination = self.storyboard?.instantiateViewControllerWithIdentifier("v2") as? NewRegisterViewController else {return}
        
        self.navigationController?.pushViewController(destination, animated: true)
        
    }
    
    
    // usermade functions....
    
    func returnUserData()
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters:["fields":"email,name,picture.type(large),id,gender"],HTTPMethod: "GET")
        
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            guard ((error) != nil)
                else {
                    let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
                    _ = ["accessToken": accessToken, "user": result]
                    
                    guard let name = result.valueForKey("name") as? String,email = result.valueForKey("email") as? String,id = result.valueForKey("id") as? String,gender = result.valueForKey("gender") as? String,strdisplayPicture = (result.objectForKey("picture")?.objectForKey("data")?.objectForKey("url") as? String) else{return}
                    
                    self.fbName = name
                    self.fbEmail = email
                    self.fbId = id
                    self.fbgender = gender
                    self.fbdisplayPic = strdisplayPicture
                    
                    self.facebookapi()
                    
                    return
            }
        })
    }
    
    func facebookapi()
    {
        
        guard let name = self.fbName,email = self.fbEmail,id = self.fbId,gender = self.fbgender,dp = self.fbdisplayPic, lat = mylat ,lng = mylon, destination = self.storyboard?.instantiateViewControllerWithIdentifier("RootViewController") as?RootViewController else{return}
        
        HTTPManager.mainapi(APIManager.fb_url, withParameters: ["fullname": name, "fb_id": id,"gender": gender,"profile_picture": dp,"lat": lat, "lng": lng, "device_token": "123", "address": "Sector 28","city": "Chandigarh","country": "India"], success: { (response) -> () in
            print(response)
            guard let myresponse = response else{return}
            let json = JSON(myresponse)
            self.token = json["token"].stringValue
            self.array1 = User.changeDictToUserArray(json["user_profile"].arrayValue)
            for( var i = 0; i < self.array1.count;i++)
            {
                guard let myAddress = self.array1[i].address else {return}
                destination.senddata(name, id: id, email: email, gender: gender,displayPic: dp, token : self.token, address: myAddress)
                
            }
            self.activityview.hidden = true
            self.navigationController?.pushViewController(destination, animated: true)
        
            }, failure: { (NSError) -> () in
                print(".....error....")
                print(NSError)
                
        })
        
    }
    
    func addstructure()
    {
        gmailbtn.layer.borderWidth=1.0
        gmailbtn.layer.masksToBounds = false
        gmailbtn.layer.borderColor = UIColor.whiteColor().CGColor
        gmailbtn.layer.cornerRadius = 25
        gmailbtn.clipsToBounds = true
        
        facebookbtn.layer.borderWidth=1.0
        facebookbtn.layer.masksToBounds = false
        facebookbtn.layer.borderColor = UIColor.whiteColor().CGColor
        facebookbtn.layer.cornerRadius = 25
        facebookbtn.clipsToBounds = true
        
        
    }
    
    
    
}
