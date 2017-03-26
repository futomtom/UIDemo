//
//  ItemListVC.swift
//  Project
//
//  Created by alexfu on 3/26/17.
//  Copyright © 2017 aau. All rights reserved.
//

import UIKit

class ItemListVC: UITableViewController {
    var tableviewItems:[Expenses] = []
    var total = 0

    override func viewDidLoad() {
        
        super.viewDidLoad()
        for item in tableviewItems {
            total = total + item.price
        }
        
        tableviewItems =  tableviewItems.sorted{ $0.price > $1.price }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tableviewItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ExpenseCell
        cell.displayItem(item: tableviewItems[indexPath.row])
        return cell
    }
    
  

    @IBAction func done(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "paymoney") as! PayMoneyVC
        
        vc.total = total
        present(vc, animated: true, completion: nil)
    }

}
