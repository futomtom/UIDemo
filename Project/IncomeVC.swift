//
//  MainVC.swift
//  Project
//
//  Created by siqi on 2/23/17.
//  Copyright © 2017 aau. All rights reserved.
//

import UIKit

class Expenses {
    var name:String = ""
    var price:Int = 0
    
    init(name:String, price:Int) {
        self.name = name
        self.price = price
    }
    
}

class IncomeVC: UIViewController {
    let sectionName = ["Dream Service","Fixed Expenses","Discretionary Money" ]
    var setting = Setting.share
    
    @IBOutlet weak var incomeField: UITextField!
    
    
    var fixed:[Expenses]=[Expenses(name:"Eat",price:100),Expenses(name:"Rent",price:200)]
    var discret:[Expenses]=[Expenses(name:"Commute",price:100),Expenses(name:"Entertainment",price:200)]
    // MARK: - Properties
    
    @IBOutlet weak var expandableTableView: LUExpandableTableView!
    
    fileprivate let sectionHeaderReuseIdentifier = "MySectionHeader"
    
    // MARK: - ViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = UIColor(red:0.659,  green:0.792,  blue:0.812, alpha:1)
        navigationController?.navigationItem.title = "Income"
        view.addSubview(expandableTableView)
        expandableTableView.register(UINib(nibName: "MyExpandableTableViewSectionHeader", bundle: Bundle.main), forHeaderFooterViewReuseIdentifier: sectionHeaderReuseIdentifier)
        
        expandableTableView.expandableTableViewDataSource = self
        expandableTableView.expandableTableViewDelegate = self
        expandableTableView.tableFooterView = UIView()
    }
  
    @IBAction func addNewItem(_ sender: UIButton) {
        
        
        if sender.tag == 1 {
            
        } else {
            
            
        }
    }

    
    override func viewWillAppear(_ animated: Bool) {
        title = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
       textField.resignFirstResponder()
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "flow3" {
            setting.income = Int(incomeField.text!) ?? 0
            setting.fix = 600
            setting.discret = 200
        }
    }


}

// MARK: - LUExpandableTableViewDataSource

extension IncomeVC: LUExpandableTableViewDataSource {
    func numberOfSections(in expandableTableView: LUExpandableTableView) -> Int {
        return 3
    }
    
    func expandableTableView(_ expandableTableView: LUExpandableTableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 1:
            return fixed.count + 1
        case 2:
            return discret.count + 1 
        default:
            return 0
        }
    }
    
    func expandableTableView(_ expandableTableView: LUExpandableTableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        if indexPath.section == 1 {
            if indexPath.row == fixed.count {
                let cell = expandableTableView.dequeueReusableCell(withIdentifier: "buttoncell") as! ButtonCell
                cell.addButton.tag = 1
                return  cell
                
            } else {
                let cell = expandableTableView.dequeueReusableCell(withIdentifier: "itemcell") as! ItemCell
                cell.displayItem(item: fixed[indexPath.row])
                return  cell
                }
        } else {
            if indexPath.row == fixed.count {
                let cell = expandableTableView.dequeueReusableCell(withIdentifier: "buttoncell")  as! ButtonCell
                 cell.addButton.tag = 2
                return  cell
                
            } else {
                let cell = expandableTableView.dequeueReusableCell(withIdentifier: "itemcell") as! ItemCell
                cell.displayItem(item: discret[indexPath.row])
                return  cell
            }
        }

        return UITableViewCell()
    }
    
    
    
    
    func expandableTableView(_ expandableTableView: LUExpandableTableView, sectionHeaderOfSection section: Int) -> LUExpandableTableViewSectionHeader {
        guard let sectionHeader = expandableTableView.dequeueReusableHeaderFooterView(withIdentifier: sectionHeaderReuseIdentifier) as? MyExpandableTableViewSectionHeader else {
            assertionFailure("Section header shouldn't be nil")
            return LUExpandableTableViewSectionHeader()
        }
        
        sectionHeader.label.text = sectionName[section]
        
        return sectionHeader
    }
}

// MARK: - LUExpandableTableViewDelegate

extension IncomeVC: LUExpandableTableViewDelegate {
    func expandableTableView(_ expandableTableView: LUExpandableTableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        /// Returning `UITableViewAutomaticDimension` value on iOS 9 will cause reloading all cells due to an iOS 9 bug with automatic dimensions
        return 50
    }
    
    func expandableTableView(_ expandableTableView: LUExpandableTableView, heightForHeaderInSection section: Int) -> CGFloat {
        /// Returning `UITableViewAutomaticDimension` value on iOS 9 will cause reloading all cells due to an iOS 9 bug with automatic dimensions
        return 69
    }
    
    // MARK: - Optional
    
    func expandableTableView(_ expandableTableView: LUExpandableTableView, didSelectRowAt indexPath: IndexPath) {
        
        
        print("Did select cell at section \(indexPath.section) row \(indexPath.row)")
    }
    
    func expandableTableView(_ expandableTableView: LUExpandableTableView, didSelectSectionHeader sectionHeader: LUExpandableTableViewSectionHeader, atSection section: Int) {
        print("Did select cection header at section \(section)")
    }
    
    func expandableTableView(_ expandableTableView: LUExpandableTableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("Will display cell at section \(indexPath.section) row \(indexPath.row)")
    }
    
    func expandableTableView(_ expandableTableView: LUExpandableTableView, willDisplaySectionHeader sectionHeader: LUExpandableTableViewSectionHeader, forSection section: Int) {
        print("Will display section header for section \(section)")
    }
}

