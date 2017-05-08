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
    var income:Int!
    var changeIndex = 0 
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
        sender.tintColor = UIColor.black
        name = names[sender.tag]
        
    }
 
    @IBAction func closedidTapped(_ sender: Any) {
        var setting = Setting.share
        var text = expenseField.text
        text = text?.replacingOccurrences(of: "$", with: "")
        let quota = Int(text!) ?? 0
        let item = Quota(name: name, limit: quota)
        item.imageName = name
        if expenseType == 1 {
            setting.fixexQuota.append(item)
            let fixtotal = setting.getTotal(setting.fixexQuota)
            let discrettotal = income - setting.saving - fixtotal
            let avg = Int(discrettotal/7)
            let lastone = discrettotal - avg * 6
            setting.discretQuota.removeAll()
            setting.discretQuota.append(Quota(name: "Groceries", limit: avg))
            setting.discretQuota.append(Quota(name: "Gifts", limit: avg))
            setting.discretQuota.append(Quota(name: "Eating Out", limit: avg))
            setting.discretQuota.append(Quota(name: "Fun", limit: avg))
            setting.discretQuota.append(Quota(name: "Costume", limit: avg))
            setting.discretQuota.append(Quota(name: "Household", limit: avg))
            setting.discretQuota.append(Quota(name: "Utilities", limit: lastone))
 
        } else {
            setting.discretQuota.insert(item, at: changeIndex)
            let fee = -item.limit
            let count =  setting.discretQuota.count
            let remain = count - changeIndex - 1
            print(remain)
            let avg = Int(fee/remain)
            let lastone = fee - avg * (remain )
            
            for i in changeIndex + 1  ..< count {
                if i == count - 1 {
                    setting.discretQuota[i].limit = setting.discretQuota[i].limit + avg //lastone
                } else {
                    setting.discretQuota[i].limit = setting.discretQuota[i].limit + avg
                }
            }
            
            //append(item)
        }
        
        dismiss(animated: true, completion: nil)
    }

}
