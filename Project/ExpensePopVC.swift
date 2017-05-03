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
    var previousButton:UIButton?
    
    @IBOutlet weak var button0: UIButton!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var button9: UIButton!
    @IBOutlet weak var button10: UIButton!
    @IBOutlet weak var button11: UIButton!
    @IBOutlet weak var button12: UIButton!
    @IBOutlet weak var button13: UIButton!
    @IBOutlet weak var button14: UIButton!
    @IBOutlet weak var button15: UIButton!

    var buttons:[UIButton] = []
    
  
    var setting = Setting.share
    override func viewDidLoad() {
        super.viewDidLoad()
         buttons = [button0,button1,button2,button3,button4,
                                 button5,button6,button7,button8,button9,button10,button11,button12,button13,button14,button15]
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = UIColor(red:0.659,  green:0.792,  blue:0.812, alpha:1)
       
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        title = ""
    }
    
    @IBAction func CategoryDidSelected(_ sender: UIButton) {
        buttons.map ({ $0.isSelected = false })
        sender.isSelected = true
        let image = UIImage(named: names[sender.tag])?.withRenderingMode(.alwaysTemplate)
        sender.setImage(image, for: .selected)
        sender.tintColor = UIColor(red:0.659,  green:0.792,  blue:0.812, alpha:1)
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
