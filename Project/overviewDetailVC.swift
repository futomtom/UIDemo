//
//  ViewController.swift
//  LUExpandableTableViewExample
//
//  Created by Laurentiu Ungur on 21/11/2016.
//  Copyright © 2016 Laurentiu Ungur. All rights reserved.
//

import UIKit
import SideMenu

var date = ["4/12","4/3"]
var eatNames = [["Cafe Medeleine", "The Bird"],["McDonald's"]]
 var eatPrices = [[18,3],[6]]

    class overviewDetailVC: UIViewController {
        var parentVC: OverviewVC?
        var selectItem = 0 
         let setting = Setting.share
   
        var GrocerisNames = [["shampoo", "gift card"],["blanket"]]
     
         var GrocerisPrices = [[58,9],[16]]
        
        @IBOutlet weak var tableView: UITableView!
        override func viewDidLoad() {
    
            
            super.viewDidLoad()
            setupSideMenu()
            tableView.sectionHeaderHeight = 44
            
        }

 
        
        
        fileprivate func setupSideMenu() {
            // Define the menus
            let menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? UISideMenuNavigationController
            menuLeftNavigationController?.leftSide = true
            SideMenuManager.menuLeftNavigationController = menuLeftNavigationController
        }
        
        
        @IBAction func addNew(_ sender: Any) {
            let alertPopUp = UIAlertController(title: "Item", message: "", preferredStyle: .alert)
            alertPopUp.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            
            let okAction = UIAlertAction(title: "OK", style: .default) { action -> Void in
                  let dateField = alertPopUp.textFields![0]
                let nameField = alertPopUp.textFields![1]
                let quotaField = alertPopUp.textFields![2]
              
                
                let dateString = dateField.text!
                let name = nameField.text!
                //        print("\(name)!")
                let quota = Int(quotaField.text!)!
               
                //         print("\(quota)!")
                if self.selectItem == 0 {
                    date.insert(dateString, at: 0)
                    eatNames.insert([name], at: 0)
                    eatPrices.insert([quota], at: 0)
                } else  {
                    date.insert(dateString, at: 0)
                    self.GrocerisNames.insert([name], at: 0)
                    self.GrocerisPrices.insert([quota], at: 0)
                }
                self.tableView.reloadData()
            }
            alertPopUp.addAction(okAction)
            alertPopUp.addTextField { (textField) in
                textField.placeholder = "mm/dd"
            }
            alertPopUp.addTextField { (textField) in
                textField.placeholder = "name"
            }
            alertPopUp.addTextField { (textField) in
                textField.placeholder = "0"
            }
            
            alertPopUp.view.tintColor = .blue
            self.present(alertPopUp, animated: true, completion: nil)
        }
}


extension overviewDetailVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return date.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return date[section]
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectItem == 0 {
             return eatNames[section].count
        } else {
             return GrocerisNames[section].count
        }
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListCell
        
        if selectItem == 0 {
             cell.displayItem3(eatNames[indexPath.section][indexPath.row],price: eatPrices[indexPath.section][indexPath.row])
            
        } else {
             cell.displayItem3(GrocerisNames[indexPath.section][indexPath.row],price: GrocerisPrices[indexPath.section][indexPath.row])
        }
        

        return cell
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        var total = 0
        if selectItem == 0 {
            for itemArray in eatPrices {
                for item in itemArray  {
                    total += item
                }
            }
           parentVC?.used[0]=total
         
        } else {
            for itemArray in GrocerisPrices {
                for item in itemArray {
                    total += item
                }
            }
            parentVC?.used[1]=total
        }
    }
}
