//
//  MainVC.swift
//  Project
//
//  Created by siqi on 2/23/17.
//  Copyright © 2017 aau. All rights reserved.
//

import UIKit

class GreatVC: UIViewController {

    @IBOutlet weak var label: UILabel!
    var setting = Setting.share
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = UIColor(red:0.659,  green:0.792,  blue:0.812, alpha:1)
       
        let saving = setting.duration > 0 ? Int(ceil(Double(setting.price / setting.duration))):0
        setting.saving = saving 
        label.numberOfLines = 6
        
        label.text =  "Congrats! \n You already have your dream! Now let's play with your budget.You should save at least $\(saving) per month in the next \(setting.duration) months."
    }
    
    override func viewWillAppear(_ animated: Bool) {
        title = ""
    }



}
