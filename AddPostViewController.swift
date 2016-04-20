//
//  AddPostViewController.swift
//  DoorChat
//
//  Created by cbluser113 on 22/12/1937 SAKA.
//  Copyright © 1937 SAKA Aseem14. All rights reserved.
//

import UIKit

class AddPostViewController: MainViewController ,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPopoverControllerDelegate
{

    @IBOutlet weak var door_title: UILabel!
    @IBOutlet weak var door_image: UIImageView!
    @IBOutlet weak var post_text_view: UITextView!
    @IBOutlet weak var media_btn: UIButton!
  
    var token: String?
    var mydoor_image : String?
    var mydoor_title : String?
    var selectedimage: UIImage?
    var post_type : String?
    var picker:UIImagePickerController? = UIImagePickerController()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        door_title.text = self.mydoor_title
        self.door_image.sd_setImageWithURL(NSURL(string: (self.mydoor_image)!))
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    
   
    @IBAction func back_btn(sender: AnyObject)  {
        guard let destination = self.storyboard?.instantiateViewControllerWithIdentifier("PostViewController") as? PostViewController else {return}
        self.delegate?.postpage(destination)
        navigationController?.popViewControllerAnimated(true)
    }
   
    
    @IBAction func add_media(sender: AnyObject) {
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
    @IBAction func add_post(sender: AnyObject)
    {
        self.add_post()
        guard let destination = self.storyboard?.instantiateViewControllerWithIdentifier("PostViewController") as? PostViewController else {return}
        self.delegate?.postpage(destination)
        navigationController?.popViewControllerAnimated(true)
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
        media_btn.setImage(selectedimage, forState: UIControlState.Normal)
        media_btn.layer.borderWidth=1.0
        media_btn.layer.masksToBounds = false
        media_btn.layer.borderColor = UIColor.blackColor().CGColor
        media_btn.layer.cornerRadius = media_btn.frame.height/2
        media_btn.clipsToBounds = true
        
    }

    @IBAction func private_btn(sender: AnyObject) {
        post_type = "0"
    }
    
    @IBAction func global_btn(sender: AnyObject) {
        post_type = "1"

    }
    
    func add_post()
    {
        guard let mypost = self.post_type, mytoken = self.token, mydoor_id = self.door_id else{return}
        HTTPManager.postFileWithParameters(APIManager.add_door_post, paramerters: ["token": mytoken, "door_id":mydoor_id,"post_desc":post_text_view.text,"post_type": mypost], profilePic: self.selectedimage , success: { (response) -> () in
            print(response)
        
            }) { (error) -> () in
        }
    }
}
