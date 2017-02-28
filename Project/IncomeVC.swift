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

class Quota {
    var name:String = ""
    var limit:Int = 0
    
    init(name:String, limit:Int) {
        self.name = name
        self.limit = limit
    }
}

class IncomeVC: UIViewController, UITextFieldDelegate {
    let sectionName = ["Dream Saving","Fixed Expenses","Discretionary Money" ]
    var setting = Setting.share
    var editmode = 0
    @IBOutlet weak var incomeField: UITextField!
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
            setting.fixexQuota.append(Quota(name: "", limit: 0))
            expandableTableView.reloadSections(IndexSet(integer: 1), with: .fade)
        } else {
            setting.discretQuota.append(Quota(name: "", limit: 0))
            expandableTableView.reloadSections(IndexSet(integer: 2), with: .fade)
        }
        editmode = sender.tag
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
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 1 {
            if editmode == 1 {
                let quota = setting.fixexQuota.last!
                quota.name = textField.text!
            } else {
                let quota = setting.discretQuota.last!
                quota.name = textField.text!
            }
        } else {
            if editmode == 1 {
                let quota = setting.fixexQuota.last!
                quota.limit = Int(textField.text!) ?? 0
                expandableTableView.reloadData()
            } else {
                let quota = setting.discretQuota.last!
                quota.limit = Int(textField.text!) ?? 0
                expandableTableView.reloadData()
            }
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
            return   setting.fixexQuota.count + 1
            
        case 2:
            return  setting.discretQuota.count + 1
        default:
            return 0
        }
    }
    
    func expandableTableView(_ expandableTableView: LUExpandableTableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let fixedQuota = setting.fixexQuota
        let discretQuota = setting.discretQuota
        
        
        if indexPath.section == 1 {
            if indexPath.row == fixedQuota.count {
                let cell = expandableTableView.dequeueReusableCell(withIdentifier: "buttoncell") as! ButtonCell
                cell.addButton.tag = 1
                return  cell
                
            } else {
                let cell = expandableTableView.dequeueReusableCell(withIdentifier: "itemcell") as! QuotaCell
                cell.displayItem(item: fixedQuota[indexPath.row])
                return  cell
                }
        }
        
        if indexPath.section == 2 {
            if indexPath.row == discretQuota.count {
                let cell = expandableTableView.dequeueReusableCell(withIdentifier: "buttoncell")  as! ButtonCell
                 cell.addButton.tag = 2
                return  cell
                
            } else {
                let cell = expandableTableView.dequeueReusableCell(withIdentifier: "itemcell") as! QuotaCell
                cell.displayItem(item: discretQuota[indexPath.row])
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
        
        var amount = 0
        switch section {
        case 0:
            amount = setting.saving
        case 1:
            amount = setting.getTotal(setting.fixexQuota)
        case 2:
            amount = setting.getTotal(setting.discretQuota)
        default:
           break
        }
        sectionHeader.label.text = sectionName[section]
        sectionHeader.expandCollapseButton.setTitle("\(amount)", for: .normal)
        
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

