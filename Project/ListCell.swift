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
        money.text = "\(remain)"
        date.text = "4/2017"
      
    }
    

    
}

class ListCell: UITableViewCell {

    @IBOutlet weak var first: UILabel!
   
    @IBOutlet weak var used: UILabel!
    @IBOutlet weak var remain: UILabel!
    
    
    
    func displayItem(_ quota:Quota,expense:Int) {
        first.text = quota.name
        used.text = "\(expense)"
        let remainMoney = quota.limit - expense
        remain.text = "\(remainMoney)/\(quota.limit)"
    }

}
