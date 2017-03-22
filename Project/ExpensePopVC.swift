//
//  MainVC.swift
//  Project
//
//  Created by siqi on 2/23/17.
//  Copyright © 2017 aau. All rights reserved.
//

import UIKit

class ExpensePopVC: UIViewController {

    @IBOutlet weak var expenseField: UITextField!
    var expenseType = 0
    let names = ["Rent","Groceries","Eating Out","Utilities","Cellphone","Car","Fun","Costume","Travel","Household","Cosmetics","Healthcare","Gifts","Social","Investment","Other"]
    var name = ""
  
    var setting = Setting.share
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
    
    @IBAction func CategoryDidSelected(_ sender: UIButton) {
     
        name = names[sender.tag]
        
    }
 
    @IBAction func closedidTapped(_ sender: Any) {
        let quota = Int(expenseField.text!) ?? 0
        if expenseType == 1 {
            setting.fixexQuota.append(Quota(name: name, limit: quota))
        }
        
        if expenseType == 2 {
            setting.discretQuota.append(Quota(name: name, limit: quota))
            
        }

        
        dismiss(animated: true, completion: nil)
    }

}
