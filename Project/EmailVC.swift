//
//  MainVC.swift
//  Project
//
//  Created by siqi on 2/23/17.
//  Copyright © 2017 aau. All rights reserved.
//

import UIKit

class EmailVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

   

    @IBAction func createDidTap(_ sender: Any) {
        let mainTabVC = storyboard?.instantiateViewController(withIdentifier: "step1") as! UINavigationController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if let window = appDelegate.window{
            window.rootViewController = mainTabVC
        }
    }
}
