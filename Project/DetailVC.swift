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
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = UIColor(red:0.659,  green:0.792,  blue:0.812, alpha:1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        title = ""
    }

    @IBAction func ChooseIcon(_ sender: Any) {
       let vc = storyboard?.instantiateViewController(withIdentifier: "chooseicon") as! ChooseIconVC
        vc.parentVC = self
       present(vc, animated: true)
        
    }
}
