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
    
    @IBOutlet weak var name: UILabel!

    @IBOutlet weak var quota: UILabel!
  
  
    
    func displayItem(item:Quota) {
 //       ItemField.tag = indexPath.section*100 + indexPath.row * 10
//        moneyField.tag = indexPath.section*100 + indexPath.row * 10 + 1
        name.text = item.name
        quota.text = "\(item.limit)"
    }
}

