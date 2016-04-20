//
//  CreateDoorViewController.swift
//  DoorChat
//
//  Created by Aseem14 on 26/02/16.
//  Copyright © 2016 Aseem14. All rights reserved.
//

import UIKit
import MapKit
import SwiftyJSON


class CreateDoorViewController: LatitudeLongitudeViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPopoverControllerDelegate
{
    
    @IBOutlet weak var imagebtn: UIButton!
   
    // variables...
    
    var finallat: String?
    var finallng: String?
    
    var m: Int = 0
    var picker:UIImagePickerController? = UIImagePickerController()
    var selectedimage: UIImage?
    var savedURL: String = ""
    
    
    
    var i : Int = 0
    
    var receivedtoken: String?
    
    
   
    
    
    @IBOutlet weak var doorTitle: UITextField!
    @IBOutlet weak var addressLabel: UITextField!
    @IBOutlet weak var activityview: UIActivityIndicatorView!
    
    override func viewDidLoad()
    {
        activityview.hidden = true
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("recognizeTapGesture:"))
        view.addGestureRecognizer(tapGesture)
        
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(true)
        self.locationset()
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
    }
    
    
    // IBActions...
    @IBAction func sidepanel(sender: AnyObject)
    {
        UIView.animateWithDuration(0.5, animations:
            {
                self.side.frame = CGRectMake(0, 0, self.screenSize.width/1.2, self.screenSize.height)
        })
    }
    
    
    @IBAction func gotomainscreen(sender: AnyObject)
    {
        navigationController?.popViewControllerAnimated(true)
    }
    
    
    // usermade functions...
    func recognizeTapGesture(recognizer: UITapGestureRecognizer)
    {
        
        UIView.animateWithDuration(0.5, animations:
            {
                self.side.frame = CGRectMake(0, 0, -self.screenSize.width/1.2, self.screenSize.height)
        })
        
    }
    
    @IBAction func locationbtn(sender: AnyObject) {
        if(self.addressLabel.text == "")
        {
            guard let lat = self.mylat else{return}
            guard let lng = self.mylon else {return}
            finallat = lat
            finallng = lng
            self.addressLabel.text = "\(lat),\(lng)"
        }
        else
        {
            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString(self.addressLabel.text!, completionHandler: { (placemark, error) -> Void in
                
                if((error) != nil)
                {
                    print("error", error)
                    
                    let alertController = UIAlertController(title: "Location Finder", message:
                        "Enter a valid location", preferredStyle: UIAlertControllerStyle.Alert)
                    alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                    
                    self.presentViewController(alertController, animated: true, completion: nil)
                    
                }
                    
                else {
                    if placemark!.count > 0
                    {
                        let coordinates: CLLocationCoordinate2D = (placemark?.first?.location?.coordinate)!
                        
                        self.mylat = ("\(coordinates.latitude)")
                        self.mylon = ("\(coordinates.longitude)")
                        self.finallat = self.mylat
                        self.finallng = self.mylon
                        guard let latitude = self.mylat, longitude = self.mylon else{return}
                        self.addressLabel.text = "\(latitude),\(longitude)"
                        
                    }
                }
            })}
    }
    
    
    @IBAction func createdoor(sender: AnyObject)
        
    {
        self.activityview.hidden = false
        self.activityview.startAnimating()
        
        guard let mytoken = receivedtoken,mydoorTitle = doorTitle.text, latitude = self.finallat, longitude = self.finallng  else {
            let alertController = UIAlertController(title: "Wrong Choice", message:
                "Missing parameters", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion:nil)
            return}
        
        print("....creating door....")
        print(self.finallat)
        print(self.finallng)
        
       
        
        HTTPManager.postFileWithParameters(APIManager.createdoor_url , paramerters:  ["token":mytoken,"door_lat": latitude,"door_lng": longitude, "door_title": mydoorTitle], profilePic: self.selectedimage, success:
            {
                (response) -> () in
                print(response)
                self.door_set()
                
            } ){
                (NSError) -> () in
                print("........error.......")
                print(NSError)
        }
        
        
    }
    
    
    @IBAction func addpicture(sender: AnyObject) {
        
        let alert:UIAlertController=UIAlertController(title: "Choose Image", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.Default)
            {
                UIAlertAction in
                self.openCamera()
        }
        let gallaryAction = UIAlertAction(title: "Gallary", style: UIAlertActionStyle.Default)
            {
                UIAlertAction in
                self.openGallary()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel)
            {
                UIAlertAction in
        }
        // Add the actions
        
        picker?.delegate = self
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        // Present the controller
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    func openCamera()
    {
        
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera))
        {
            guard let mypicker = picker else{return}
            mypicker.sourceType = UIImagePickerControllerSourceType.Camera
            self .presentViewController(mypicker, animated: true, completion: nil)
        }
        else
        {
            openGallary()
        }
    }
    
    func openGallary()
    {
        guard let mypicker = picker else{return}
        self.presentViewController(mypicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        picker.dismissViewControllerAnimated(true, completion: nil)
        
        selectedimage = info [UIImagePickerControllerOriginalImage] as? UIImage
        imagebtn.setImage(selectedimage, forState: UIControlState.Normal)
        
    }
    
    
    
    func sendtoken(token: String)
    {
        receivedtoken = token
    }
    
    
    func door_set()
    {
        
        guard let destination = self.storyboard?.instantiateViewControllerWithIdentifier("RootViewController") as? RootViewController, token = self.receivedtoken else {return}
        destination.fbtoken = token
        
        self.navigationController?.pushViewController(destination, animated: true)
        
    }
    
    
}


