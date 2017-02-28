//
//  QuotaCell.swift
//  Project
//
//  Created by siqi on 2/24/17.
//  Copyright © 2017 aau. All rights reserved.
//

import UIKit

class ExpenseCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var price: UILabel!
    

    func displayItem(item:Expenses) {
        
        name.text = item.name
        price.text = "\(item.price)"
    }
}


class QuotaCell: UITableViewCell {
    

    @IBOutlet weak var ItemField: UITextField!
    
    @IBOutlet weak var moneyField: UITextField!
  
    
    
    
    func displayItem(item:Quota) {
        
        ItemField.text = item.name
        moneyField.text = "\(item.limit)"
    }
}

