//
//  MainVC.swift
//  Project
//
//  Created by siqi on 2/23/17.
//  Copyright © 2017 aau. All rights reserved.
//

import UIKit

class Expenses {
    var name: String = ""
    var price: Int = 0

    init(name: String, price: Int) {
        self.name = name
        self.price = price
    }
}

class Quota {
    var imageName = ""
    var name: String = ""
    var limit: Int = 0

    init(name: String, limit: Int) {
        self.name = name
        self.limit = limit
    }
}

class IncomeVC: UIViewController , UITextFieldDelegate{
    let sectionName = ["Dream Saving", "Fixed Expenses", "Discretionary Money"]
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
        navigationController?.navigationBar.tintColor = UIColor(red: 0.659, green: 0.792, blue: 0.812, alpha: 1)
        navigationController?.navigationItem.title = "Income"
        view.addSubview(expandableTableView)
        expandableTableView.register(UINib(nibName: "MyExpandableTableViewSectionHeader", bundle: Bundle.main), forHeaderFooterViewReuseIdentifier: sectionHeaderReuseIdentifier)

        expandableTableView.expandableTableViewDataSource = self
        expandableTableView.expandableTableViewDelegate = self
        expandableTableView.tableFooterView = UIView()
        
    }

    @IBAction func addNewItem(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "expensevc") as! ExpensePopVC
        vc.expenseType = sender.tag
              
        present(vc, animated: true, completion: nil)
        

    }


override func viewWillAppear(_ animated: Bool) {
    title = ""
    expandableTableView.reloadData()
    if setting.fixexQuota.count > 0 {  //something
        let income = Int(incomeField.text!)
        
        
        let discrettotal = income! - setting.saving - setting.getTotal(setting.fixexQuota)
        let avg = Int(discrettotal/7)
        setting.discretQuota.removeAll()
        setting.discretQuota.append(Quota(name: "Groceries", limit: avg))
        setting.discretQuota.append(Quota(name: "Gifts", limit: avg))
        setting.discretQuota.append(Quota(name: "Eating Out", limit: avg))
        setting.discretQuota.append(Quota(name: "Fun", limit: avg))
        setting.discretQuota.append(Quota(name: "Costume", limit: avg))
        setting.discretQuota.append(Quota(name: "Household", limit: avg))
        setting.discretQuota.append(Quota(name: "Utilities", limit: avg))
        
    }

}
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
            textField.resignFirstResponder()
        return false
    }
    
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "flow3" {
        setting.income = Int(incomeField.text!) ?? 0
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
            return setting.fixexQuota.count + 1

        case 2:
            return setting.discretQuota.count + 1
        default:
            return 0
        }
    }
    
    func expandableTableView(_ expandableTableView: LUExpandableTableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            setting.discretQuota.remove(at: indexPath.row)
            expandableTableView.reloadData()
        }
    }

    func expandableTableView(_ expandableTableView: LUExpandableTableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let fixedQuota = setting.fixexQuota
        let discretQuota = setting.discretQuota
        
        if indexPath.section == 1 {
            if indexPath.row == fixedQuota.count {
                let cell = expandableTableView.dequeueReusableCell(withIdentifier: "buttoncell") as! ButtonCell
                cell.addButton.tag = 1
                return cell

            } else {
                let cell = expandableTableView.dequeueReusableCell(withIdentifier: "itemcell") as! QuotaCell
                cell.displayItem(item: fixedQuota[indexPath.row])

                return cell
            }
        }

        if indexPath.section == 2 {
            if indexPath.row == discretQuota.count {
                let cell = expandableTableView.dequeueReusableCell(withIdentifier: "buttoncell") as! ButtonCell
                cell.addButton.tag = 2
                return cell

            } else {
                let cell = expandableTableView.dequeueReusableCell(withIdentifier: "itemcell") as! QuotaCell
                cell.displayItem(item: discretQuota[indexPath.row])

                return cell
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
            setting.fix = amount
        case 2:
            amount = setting.getTotal(setting.discretQuota)
            setting.discret = amount
        default:
            break
        }
        sectionHeader.label.text = sectionName[section]
        sectionHeader.expandCollapseButton.setTitle("\(amount)", for: .normal)
        sectionHeader.layer.borderColor=UIColor.lightGray.cgColor
        sectionHeader.layer.borderWidth=0.5
        
        return sectionHeader
    }
    
    func expandableTableView(_ expandableTableView: LUExpandableTableView, didSelectRowAt indexPath: IndexPath) {
        
        let row = indexPath.row
        
        let alertPopUp = UIAlertController(title: "qouta", message: "", preferredStyle: .alert)
        
        
        alertPopUp.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        
        let okAction = UIAlertAction(title: "OK", style: .default) { action -> Void in
            let nameField = alertPopUp.textFields![0]
            let quotaField = alertPopUp.textFields![1]
            
            let name = nameField.text!
            //        print("\(name)!")
            let quota = Int(quotaField.text!)!
            //         print("\(quota)!")
            if indexPath.section == 1 {
                self.setting.fixexQuota[row] = Quota(name: name, limit: quota)
            }
            
            if indexPath.section == 2 {
                self.setting.discretQuota[row] = Quota(name: name, limit: quota)
                
            }
            self.expandableTableView.reloadData()
        }
        alertPopUp.addAction(okAction)
        
        var quota = Quota(name: "", limit: 0)
        if indexPath.section == 1 {
            quota = setting.fixexQuota[indexPath.row]
        } else if indexPath.section == 2 {
            quota = setting.discretQuota[indexPath.row]
        }
        
        
        
        alertPopUp.addTextField { (textField) in
            textField.text = quota.name
        }
        alertPopUp.addTextField { (textField) in
            textField.text = "\(quota.limit)"
        }
        alertPopUp.view.tintColor = .blue
        self.present(alertPopUp, animated: true, completion: nil)
    }
    
    
    
    
}

// MARK: - LUExpandableTableViewDelegate

extension IncomeVC: LUExpandableTableViewDelegate {
    func expandableTableView(_ expandableTableView: LUExpandableTableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        /// Returning `UITableViewAutomaticDimension` value on iOS 9 will cause reloading all cells due to an iOS 9 bug with automatic dimensions
        return 50
    }
    
    func expandableTableView(_ expandableTableView: LUExpandableTableView, didSelectSectionHeader sectionHeader: LUExpandableTableViewSectionHeader, atSection section: Int) {
        print(section)
    }
    


    func expandableTableView(_ expandableTableView: LUExpandableTableView, heightForHeaderInSection section: Int) -> CGFloat {
        /// Returning `UITableViewAutomaticDimension` value on iOS 9 will cause reloading all cells due to an iOS 9 bug with automatic dimensions
        return 69
    }
    
 
}

