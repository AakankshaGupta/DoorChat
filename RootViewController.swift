//
//  RootViewController.swift
//  DoorChat
//
//  Created by Aseem14 on 03/03/16.
//  Copyright © 2016 Aseem14. All rights reserved.
//

import UIKit
import SwiftyJSON


class RootViewController : LatitudeLongitudeViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate, UIScrollViewDelegate, BtnMovedDelegate
{
    
    @IBOutlet weak var LeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var height_constraint: NSLayoutConstraint!
    @IBOutlet weak var movingView: UIView!
    @IBOutlet weak var mysidepanel: UIButton!
    @IBOutlet weak var mymap: UIButton!
    @IBOutlet weak var myneighbourhood: UIButton!
    @IBOutlet weak var mydoors: UIButton!
    @IBOutlet weak var sidepanelbtn: UIButton!
    
    
    var main_obj = MainViewController()
    var first_obj = FirstViewController()
        var savedarray: [User] = []
    var saved_user = User()
    
    var dummy_array : [User]?
   
    
    var lat_arr : [String] = []
    var lng_arr : [String] = []
    var door_id_arr : [String] = []
    var door_title_arr : [String] = []
    var door_total_members_arr : [String] = []
    var door_tym_arr : [String] = []
    
    
     override func viewDidLoad()
    {
        super.viewDidLoad()
        
    }
    
      override func viewDidAppear(animated: Bool)
      {
        super.viewDidAppear(true)
        
               self.locationset()
        self.addpageviewcontroller()
      
      
    pageviewcontroller?.delegate = self
        pageviewcontroller?.dataSource = self
        guard let _ = UIApplication.sharedApplication().delegate?.window??.addSubview(side) else{return}
        var count1: [User]?
        
        count1 = self.db.fetchdata()
        if(count1!.count > 0)
        {
            print("....coredata....")
            guard let dp = count1?.last?.Profile_Picture else{return}
            side.ProfilePic.sd_setImageWithURL(NSURL(string: (dp)))
            side.ProfilePic1.sd_setImageWithURL(NSURL(string: (dp)))
            side.ProfileName.text = count1?.last?.FullName
            side.ProfileAddress.text = count1?.last?.address
            print(self.savedarray)
        }
        
        else
        {
            guard let dp = fbdisplayPic else {return}
            
            print("...api..")
            self.fetch_doors_api()
            side.ProfilePic.sd_setImageWithURL(NSURL(string: (dp)))
            side.ProfilePic1.sd_setImageWithURL(NSURL(string: (dp)))
            side.ProfileName.text = fbName
            side.ProfileAddress.text = fbAddress
            saved_user.Profile_Picture = dp
            
            saved_user.FullName = fbName
            saved_user.address = fbAddress
            saved_user.token = fbtoken
            saved_user.door_id = ""
            saved_user.door_title = ""
            saved_user.door_image = ""
            savedarray.append(saved_user)
            db.saveDetails(savedarray)
        }
        
    }
      override func viewDidDisappear(animated: Bool)
    {
        super.viewDidDisappear(true)
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("recognizeTapGesture:"))
        guard let _ = UIApplication.sharedApplication().delegate?.window??.removeGestureRecognizer(tapGesture) else{return}
        
    }
    
    func addpageviewcontroller()
    {
        self.pageviewcontroller = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        self.pageviewcontroller?.view.frame = CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height-100)
        
        self.fetch_doors_api()
        
        self.addChildViewController(self.pageviewcontroller!)
        self.view.addSubview((self.pageviewcontroller?.view)!)
        
        self.myneighbourhood.setTitleColor(UIColor(
            red:85.0/255.0,
            green:89.0/255.0,
            blue:100.0/255.0,
            alpha:1.0), forState: UIControlState.Normal)
        self.pageviewcontroller?.didMoveToParentViewController(self)
        
    }
    
    
    func pageViewController(var pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController?
    {
    
        if(viewController is NeighbourViewController)
        {
            guard let destination = self.storyboard?.instantiateViewControllerWithIdentifier("MainViewController") as? MainViewController else {return nil }
            self.myneighbourhood.setTitleColor(UIColor(
                red:85.0/255.0,
                green:89.0/255.0,
                blue:100.0/255.0,
                alpha:1.0), forState: UIControlState.Normal)
            self.mydoors.setTitleColor(UIColor.whiteColor(),forState: UIControlState.Normal)
            pageViewController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
            return destination

        }
        else if(viewController is MainViewController)
        {
            
            return nil
        }
    
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
    if(completed)
    {
        if(previousViewControllers[0] is MainViewController)
        {
            UIView.animateWithDuration(0.5, animations: {self.movingView.frame.origin.x = self.myneighbourhood.frame.origin.x},completion: {
                (value: Bool) in
                
            }
            )
    }
        else if(previousViewControllers[0] is NeighbourViewController)
        {
            UIView.animateWithDuration(0.5, animations: {self.movingView.frame.origin.x = self.mydoors.frame.origin.x},completion: {
                (value: Bool) in
                
            })

        }
        
        }
    
    }
    
    func pageViewController(var pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController?
    {
        
           if(viewController is MainViewController)
        {
          
     guard let destination = self.storyboard?.instantiateViewControllerWithIdentifier("NeighbourViewController") as? NeighbourViewController else {return nil }
       pageViewController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
            self.mydoors.setTitleColor(UIColor(
                red:85.0/255.0,
                green:89.0/255.0,
                blue:100.0/255.0,
                alpha:1.0), forState: UIControlState.Normal)
            self.myneighbourhood.setTitleColor(UIColor.whiteColor(),forState: UIControlState.Normal)
            return destination
        }
        else if(viewController is NeighbourViewController)
        {

            return nil
        }
      
        return nil
    }
    
    @IBAction func doorsbtn(sender: AnyObject)
    {
        self.fetch_doors_api()
       
        
            self.myneighbourhood.setTitleColor(UIColor(
                red:85.0/255.0,
                green:89.0/255.0,
                blue:100.0/255.0,
                alpha:1.0), forState: UIControlState.Normal)
        self.mymap.setImage(UIImage(named: "toggle_map"), forState: UIControlState.Normal)
        self.mydoors.setTitleColor(UIColor.whiteColor(),forState: UIControlState.Normal)
        UIView.animateWithDuration(0.5, animations: {self.movingView.frame.origin.x = self.mydoors.frame.origin.x
            self.view.updateConstraints()}, completion: nil)
        
    }
    
    @IBAction func sidepanelbtn(sender: AnyObject) {
        tapGesture = UITapGestureRecognizer(target: self, action: Selector("recognizeTapGesture:"))
        view.addGestureRecognizer(tapGesture!)
       
       UIView.animateWithDuration(0.5, animations:
        {
            self.side.frame = CGRectMake(0, 0, self.screenSize.width/1.2, self.screenSize.height)
        })
    }
    
    @IBAction func mapbtn(sender: AnyObject)
    {
        guard let destination = self.storyboard?.instantiateViewControllerWithIdentifier("MapViewController") as? MapViewController else {return }
        destination.array1 = self.array1
        self.mymap.setImage(UIImage(named: "toggle_list"), forState: UIControlState.Normal)
        self.pageviewcontroller!.setViewControllers([destination], direction: .Forward, animated: false, completion:nil)
    }
    
    
    @IBAction func neighboursbtn(sender: AnyObject)
    {
        
      
        guard let destination = self.storyboard?.instantiateViewControllerWithIdentifier("NeighbourViewController") as? NeighbourViewController else {return  }

        UIView.animateWithDuration(0.5, animations: { self.movingView.frame.origin.x = self.myneighbourhood.frame.origin.x
            self.view.updateConstraints()
            self.mydoors.setTitleColor(UIColor(
                red:85.0/255.0,
                green:89.0/255.0,
                blue:100.0/255.0,
                alpha:1.0), forState: UIControlState.Normal)
self.myneighbourhood.setTitleColor(UIColor.whiteColor(),forState: UIControlState.Normal)}, completion: nil)
       self.mymap.setImage(UIImage(named: "toggle_map"), forState: UIControlState.Normal)
        self.pageviewcontroller!.setViewControllers([destination], direction: .Forward, animated: false, completion:nil)
        
        
        }
    
    
    
    func recognizeTapGesture(recognizer: UITapGestureRecognizer)
    {
        
        UIView.animateWithDuration(0.5, animations:
            {
                
                self.side.frame = CGRectMake(0, 0, -(self.screenSize.width/1.2), self.screenSize.height)
        })
        view.removeGestureRecognizer(tapGesture!)
    }
    
    func senddata(name: String,id: String, email:String,gender: String,displayPic: String, token: String, address: String)
        
    {
        self.fbName = name
        self.fbId = id
        self.fbgender = gender
        self.fbEmail = email
        self.fbdisplayPic = displayPic
        self.fbtoken = token
        self.fbAddress = address
        
    }
    
    func fetch_doors_api()
    {
        print(self.fbtoken)
        
        HTTPManager.mainapi(APIManager.my_door_list, withParameters: ["token": self.fbtoken!, "page": "2", "order": ""], success: { (response) -> () in
            print(response)
            print("........successs.......")
            guard let myresponse = response else{return}
            let json = JSON(myresponse)
            self.array1 = User.changeDictToUserArray(json["content"].arrayValue)
            
            if(self.array1.count != 0)
            {
            guard let destination = self.storyboard?.instantiateViewControllerWithIdentifier("MainViewController") as? MainViewController else{return}
            destination.main_array = self.array1
                self.dummy_array = self.array1
            
            destination.delegate = self
                
                            destination.fb_token = self.fbtoken
                let viewControllers = [destination]
                
                self.pageviewcontroller?.setViewControllers(viewControllers, direction: .Forward, animated: false, completion: { _ in
                    
                })
                self.view.bringSubviewToFront((self.pageviewcontroller?.view)!)
            }
            else{
                guard let destination = self.storyboard?.instantiateViewControllerWithIdentifier("NoFeedsViewController") as? NoFeedsViewController else {return }
                
                destination.token = self.fbtoken
                
                self.navigationController?.pushViewController(destination, animated: true)
                
            }
            }
            )
            { (error) -> () in
                
        }
        
    }
    
    func fetch_myneighbour_api()
    {
        guard let latitude = mylat, longitude = mylon else
        {return}
        HTTPManager.mainapi(APIManager.my_neighbour_list, withParameters: ["token": self.fbtoken!,"page": "12", "order": "", "my_lat":latitude,"my_lng": longitude], success: { (response) -> () in
            print(response)
            guard let myresponse = response else{return}
            let json = JSON(myresponse)
            self.array1 = User.changeDictToUserArray(json["content"].arrayValue)
            if( self.array1.count > 0)
            {
                
            guard let destination = self.storyboard?.instantiateViewControllerWithIdentifier("MainViewController") as? MainViewController else{return}
                destination.main_array = self.array1
                destination.fb_token = self.fbtoken
                let viewControllers = [destination]
                self.pageviewcontroller?.setViewControllers(viewControllers, direction: .Forward, animated: false, completion: { _ in
                })
            }
            else
            {
                guard let destination = self.storyboard?.instantiateViewControllerWithIdentifier("MainViewController") as? MainViewController else{return}
                destination.main_array = []
                destination.fb_token = self.fbtoken
                let viewControllers = [destination]
                self.pageviewcontroller?.setViewControllers(viewControllers, direction: .Forward, animated: false, completion: { _ in
                })
                
            }
            }) { (error) -> () in
        }
    }
    
    
    func moveUp()
    {
        self.view.layoutIfNeeded()
        UIView.animateWithDuration(0.25, animations:
            {
                self.pageviewcontroller?.view.frame = CGRectMake(0,44, self.view.frame.size.width, self.view.frame.size.height-54)
                self.height_constraint.constant = 0
                
                self.view.layoutIfNeeded()
                
            }, completion: {
                (value: Bool) in
        })
    }
    
    func moveDown()
    {
        self.view.layoutIfNeeded()
        UIView.animateWithDuration(0.25, animations:
            {
                
                self.pageviewcontroller?.view.frame = CGRectMake(0,104, self.view.frame.size.width, self.view.frame.size.height-104)
                self.height_constraint.constant = 50
                
            }, completion: {
                (value: Bool) in
                
        })
        
        
    }
    
    func postpage(destination: UIViewController)
    {
         let viewControllers = [destination]
         self.pageviewcontroller?.view.frame = CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height-100)
          self.height_constraint.constant = 50
          self.mymap.setImage(UIImage(named: "toggle_list"), forState: UIControlState.Normal)
        
        self.pageviewcontroller?.setViewControllers(viewControllers, direction: .Forward, animated: false, completion: { _ in
        })
        
    }

      
}
