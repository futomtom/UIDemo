//
//  MainVC.swift
//  Project
//
//  Created by siqi on 2/23/17.
//  Copyright © 2017 aau. All rights reserved.
//

import UIKit

class PerfectVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = UIColor(red:0.659,  green:0.792,  blue:0.812, alpha:1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        title = ""
    }


    @IBAction func OKDidTap(_ sender: Any) {
        let confettiView = SAConfettiView(frame: self.view.bounds)
        confettiView.type = .triangle
        self.view.addSubview(confettiView)

        confettiView.startConfetti()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.processToHomePage()        }
        
        
        
    }
  
}
