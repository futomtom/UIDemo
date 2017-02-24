//
//  MainVC.swift
//  Project
//
//  Created by alexfu on 2/23/17.
//  Copyright © 2017 aau. All rights reserved.
//

import UIKit

class EmailVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

   

    @IBAction func createDidTap(_ sender: Any) {
        let mainTabVC = storyboard?.instantiateViewController(withIdentifier: "maintab") as! UITabBarController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if let window = appDelegate.window{
            window.rootViewController = mainTabVC
        }
    }
}
