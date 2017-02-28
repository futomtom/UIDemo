//
//  MainVC.swift
//  Project
//
//  Created by siqi on 2/23/17.
//  Copyright © 2017 aau. All rights reserved.
//

import UIKit
import SwiftValidator

class EmailVC: UIViewController, UITextFieldDelegate,ValidationDelegate {
    /**
     This method will be called on delegate object when validation is successful.
     
     - returns: No return value.
     */
    let validator = Validator()
    
    @IBOutlet weak var emialField: UITextField!
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var comfirmField: UITextField!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var comfirmLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = UIColor(red:0.659,  green:0.792,  blue:0.812, alpha:1)
        
        validator.styleTransformers(success:{ (validationRule) -> Void in
    
            // clear error label
            validationRule.errorLabel?.isHidden = true
            validationRule.errorLabel?.text = ""
            if let textField = validationRule.field as? UITextField {
                textField.layer.borderColor = UIColor.green.cgColor
                textField.layer.borderWidth = 0.5
                
            }
        }, error:{ (validationError) -> Void in
            print("error")
            validationError.errorLabel?.isHidden = false
            validationError.errorLabel?.text = validationError.errorMessage
            if let textField = validationError.field as? UITextField {
                textField.layer.borderColor = UIColor.red.cgColor
                textField.layer.borderWidth = 1.0
            }
        })
        
        validator.registerField(emialField, errorLabel: emailLabel, rules: [RequiredRule(), EmailRule()])
        validator.registerField(userNameField, errorLabel: userNameLabel , rules: [RequiredRule()])
       
        validator.registerField(passwordField, errorLabel: passwordLabel, rules: [RequiredRule(), ConfirmationRule(confirmField: comfirmField)])
        validator.registerField(comfirmField, errorLabel: comfirmLabel, rules: [RequiredRule(), MinLengthRule(length: 6)])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        title = ""
   //comment this
        emialField.text = "suqi@ii.com"
        userNameField.text = "suqi"
        passwordField.text = "123456"
        comfirmField.text = "123456"
    }
    
    @IBAction func okDidTap(_ sender: UIButton) {
         validator.validate(self)
        
    }
    func validationSuccessful() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "step1")
        show(vc!, sender: nil)
    }
    func validationFailed(_ errors:[(Validatable, ValidationError)]) {
        print("Validation FAILED!")
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
