//
//  NeighbourViewController.swift
//  DoorChat
//
//  Created by cbluser113 on 26/12/1937 SAKA.
//  Copyright © 1937 SAKA Aseem14. All rights reserved.
//

import UIKit
import SwiftyJSON

class NeighbourViewController: LatitudeLongitudeViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
