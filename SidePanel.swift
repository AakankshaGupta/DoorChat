//
//  SidePanel.swift
//  DoorChat
//
//  Created by Aseem14 on 25/02/16.
//  Copyright © 2016 Aseem14. All rights reserved.
//

import UIKit

protocol SidePanelDelegate
{
    func checkMove()
    func UserProfile()
}


class SidePanel: UIView
{
    var delegate:SidePanelDelegate?
    
    @IBOutlet weak var ProfileAddress: UILabel!
    @IBOutlet weak var ProfileName: UILabel!
    @IBOutlet weak var ProfilePic: UIImageView!
    @IBOutlet weak var ProfilePic1: UIImageView!
        
           func loadViewFromNib() -> UIView
        {
            let bundle = NSBundle(forClass: self.dynamicType)
            let nib = UINib(nibName: "SidePanel", bundle: bundle)
            let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
            ProfilePic1.layer.borderWidth=1.0
            ProfilePic1.layer.masksToBounds = false
            ProfilePic1.layer.cornerRadius = ProfilePic1.frame.size.height/2
            ProfilePic1.layer.borderColor = UIColor(red: 168/255, green: 104/255, blue: 122/255, alpha: 0.5).CGColor
            ProfilePic1.clipsToBounds = true
           
            view.addSubview(ProfilePic1)
            
            return view
        }

        func xibSetup()
        {
            let view = loadViewFromNib()
            view.frame = bounds
            view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
            addSubview(view)
        }
        
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        xibSetup()
    }
    
   
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)!
        xibSetup()
    }
   
    @IBAction func createdoor(sender: AnyObject)
    {
       self.delegate?.checkMove()
    }
    
    @IBAction func UserProfile(sender: AnyObject)
    {
        self.delegate?.UserProfile()
    }

}


   

