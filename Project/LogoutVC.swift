//
//  MainVC.swift
//  Project
//
//  Created by siqi on 2/23/17.
//  Copyright © 2017 aau. All rights reserved.
//

import UIKit

class LogoutVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = UIColor(red: 0.659, green: 0.792, blue: 0.812, alpha: 1)
    }

    override func viewWillAppear(_ animated: Bool) {
        title = ""
    }


    @IBAction func Logout(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rootNavi = storyboard.instantiateViewController(withIdentifier: "rootnavi") as! UINavigationController
        let appDelegate = UIApplication.shared
        if let window = appDelegate.keyWindow {
            window.rootViewController = rootNavi
        }
    }
}
