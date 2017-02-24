//
//  MainVC.swift
//  Project
//
//  Created by alexfu on 2/23/17.
//  Copyright © 2017 aau. All rights reserved.
//

import UIKit

class ChooseIconVC: UIViewController {
 
    var parentVC:DetailVC!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func doneDidTap(_ sender: Any) {
        parentVC.iconChoosed = true
        dismiss(animated: true, completion: nil)
    }
  
}
