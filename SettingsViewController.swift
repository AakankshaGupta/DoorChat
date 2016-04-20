//
//  SettingsViewController.swift
//  DoorChat
//
//  Created by Aseem14 on 02/03/16.
//  Copyright © 2016 Aseem14. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func moveBack(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func moveOut(sender: AnyObject) {
        navigationController?.popToRootViewControllerAnimated(true)
    }
}
