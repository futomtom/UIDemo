//
//  MainVC.swift
//  Project
//
//  Created by alexfu on 2/23/17.
//  Copyright © 2017 aau. All rights reserved.
//

import UIKit

class Step1VC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.items?[1].isEnabled = false
        tabBarController?.tabBar.items?[2].isEnabled = false
        
    }

   
}
