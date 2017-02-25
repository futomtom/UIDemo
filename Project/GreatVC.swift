//
//  MainVC.swift
//  Project
//
//  Created by siqi on 2/23/17.
//  Copyright © 2017 aau. All rights reserved.
//

import UIKit

class GreatVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func GreatDidTap(_ sender: Any) {
        tabBarController?.tabBar.items?[0].isEnabled = false
        tabBarController?.tabBar.items?[1].isEnabled = true
        tabBarController?.selectedIndex = 1
        
    }
}
