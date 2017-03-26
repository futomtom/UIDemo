//
//  ListCellTableViewCell.swift
//  Project
//
//  Created by Alex on 2/27/17.
//  Copyright © 2017 aau. All rights reserved.
//

import UIKit

class ListHeaderCell: UITableViewCell {
   var remain = 0
    
    @IBOutlet weak var money: UILabel!
    @IBOutlet weak var date: UILabel!
    
    func displayItem() {
        money.text = "" // "\(remain)"
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let result = formatter.string(from: date)
        self.date.text = result
      
    }
    

    
}

class ListCell: UITableViewCell {

    @IBOutlet weak var first: UILabel!
   
    @IBOutlet weak var used: UILabel!
    @IBOutlet weak var remain: UILabel!
    
    
    
    func displayItem(_ quota:Quota,expense:Int) {
        first.text = quota.name
        used.text = "$\(expense)"
        let remainMoney = quota.limit - expense
        remain.text = "$\(remainMoney)/$\(quota.limit)"
    }
    
    func displayItem2(_ quota:Quota,expense:Int) {
        first.font =  UIFont.boldSystemFont(ofSize: 20.0)
        first.text = quota.name
        used.font =  UIFont.boldSystemFont(ofSize: 20.0)
        used.text = "$\(expense)"
        let remainMoney = quota.limit - expense
        remain.font =  UIFont.boldSystemFont(ofSize: 20.0)
        remain.text = "$\(remainMoney)/$\(quota.limit)"
    }

}
