//
//  MainVC.swift
//  Project
//
//  Created by siqi on 2/23/17.
//  Copyright © 2017 aau. All rights reserved.
//

import UIKit

class ChooseIconVC: UIViewController {
 
    var parentVC:DetailVC!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }



    @IBAction func iconDidTap(_ sender: Any) {
      parentVC.iconChoosed = true
      dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func chooseAlbum(_ sender: Any) {
        parentVC.iconChoosed = true
        dismiss(animated: true, completion: nil)

        
    }
   
}