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
        
        navigationController?.navigationBar.isHidden = true
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
