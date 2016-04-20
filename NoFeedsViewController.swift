//
//  NoFeedsViewController.swift
//  DoorChat
//
//  Created by Aseem14 on 02/03/16.
//  Copyright © 2016 Aseem14. All rights reserved.
//

import UIKit

class NoFeedsViewController: LatitudeLongitudeViewController {

    @IBOutlet weak var text_label: UILabel!

    var token: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.text_label.preferredMaxLayoutWidth = UIScreen.mainScreen().bounds.size.width

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    @IBAction func add_a_door(sender: AnyObject)
    {
    guard let destination = self.storyboard?.instantiateViewControllerWithIdentifier("CreateDoorViewController") as?CreateDoorViewController else {return}
        destination.receivedtoken = self.token
        self.navigationController?.pushViewController(destination, animated: true)
    }
   
    @IBAction func side_panel_btn(sender: AnyObject) {
        tapGesture = UITapGestureRecognizer(target: self, action: Selector("recognizeTapGesture:"))
        view.addGestureRecognizer(tapGesture!)

        UIView.animateWithDuration(0.5, animations:
            {
               self.side.frame = CGRectMake(0, 0, self.screenSize.width/1.2, self.screenSize.height)
            })

    }
    func recognizeTapGesture(recognizer: UITapGestureRecognizer)
    {
        
        UIView.animateWithDuration(0.5, animations:
            {
                
                self.side.frame = CGRectMake(0, 0, -(self.screenSize.width/1.2), self.screenSize.height)
        })
        view.removeGestureRecognizer(tapGesture!)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
