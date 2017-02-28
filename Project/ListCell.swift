//
//  ListCellTableViewCell.swift
//  Project
//
//  Created by Alex on 2/27/17.
//  Copyright © 2017 aau. All rights reserved.
//

import UIKit

class ListHeaderCell: UITableViewCell {
    
    @IBOutlet weak var money: UILabel!
    @IBOutlet weak var date: UILabel!
    
    func displayItem() {
        money.text = "600"
        date.text = "2/2017"
      
    }
    

    
}

class ListCell: UITableViewCell {

    @IBOutlet weak var first: UILabel!
    @IBOutlet weak var second: UILabel!
    @IBOutlet weak var used: UILabel!
    @IBOutlet weak var remain: UILabel!
    
    
    
    func displayItem() {
        first.text = "600"
        second.text = "2/2017"
        used.text = "100"
        remain.text = "140"
    }

}
