//
//  NewRegisterViewController.swift
//  DoorChat
//
//  Created by Aseem14 on 24/02/16.
//  Copyright © 2016 Aseem14. All rights reserved.
//

import UIKit

class NewRegisterViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPopoverControllerDelegate
{

    @IBOutlet weak var imagebtn: UIButton!
    @IBOutlet weak var usergender: UISegmentedControl!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var fullname: UITextField!
    
    var m: Int = 0
    var picker:UIImagePickerController? = UIImagePickerController()
    var selectedimage: UIImage?
    
    var gender: String = ""
   
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    @IBAction func nextregisterscreen(sender: AnyObject)
    {
    
        guard let destination = self.storyboard?.instantiateViewControllerWithIdentifier("v21") as?RegisterViewController else{return}
       
        guard let uname = username.text else {return}
        guard let fname = fullname.text else{ return}
        guard let uimage = selectedimage else {return}
        
        destination.senddata(fname, username1: uname, image1: uimage, gender: gender)
        
        self.navigationController?.pushViewController(destination, animated: true)
    
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
        
        picker?.delegate = self
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        
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
        imagebtn.layer.borderWidth=1.0
        imagebtn.layer.masksToBounds = false
        imagebtn.layer.borderColor = UIColor.whiteColor().CGColor
        imagebtn.layer.cornerRadius = imagebtn.frame.height/2
        imagebtn.clipsToBounds = true

    }
    
    func dismissKeyboard()
    {
        view.endEditing(true)
        
    }
   
    @IBAction func gendersegmentcontrol(sender: AnyObject) {
        if(usergender.selectedSegmentIndex == 0)
        {
            self.gender = "male"
        }
        else
        {
            self.gender = "female"
        }
        
        }
    
    
    @IBAction func mainscreen(sender: AnyObject)
    {
        
    navigationController?.popToRootViewControllerAnimated(true)

    }


}
