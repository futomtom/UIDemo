//
//  MainVC.swift
//  Project
//
//  Created by siqi on 2/23/17.
//  Copyright © 2017 aau. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
    var iconChoosed:Bool  {
        set {
            doneButton.isHidden = !iconChoosed
        }
        get {
            return true
        }
        
    }
    
    @IBOutlet weak var doneButton: BorderButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func ChooseIcon(_ sender: Any) {
       let vc = storyboard?.instantiateViewController(withIdentifier: "chooseicon") as! ChooseIconVC
        vc.parentVC = self
       present(vc, animated: true)
        
    }
}
