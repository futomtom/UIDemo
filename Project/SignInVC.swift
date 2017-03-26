//
//  MainVC.swift
//  Project
//
//  Created by siqi on 2/23/17.
//  Copyright © 2017 aau. All rights reserved.
//

import UIKit


class SignInVC: UIViewController, UITextFieldDelegate {

    
    var setting = Setting.share
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = UIColor(red:0.659,  green:0.792,  blue:0.812, alpha:1)
        
 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        title = ""
   //comment this
     
        userNameField.text = "suqi"
        passwordField.text = "123456"
     
    }
    
    @IBAction func okDidTap(_ sender: UIButton) {
        setting.oldUser = true 
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.processToHomePage()
        
    }
    

 
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if let nextField = view.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
        }
    
        return false
    }

  
}
