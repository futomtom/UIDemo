//
//  ViewController.swift
//  LUExpandableTableViewExample
//
//  Created by Laurentiu Ungur on 21/11/2016.
//  Copyright © 2016 Laurentiu Ungur. All rights reserved.
//

import UIKit
import SideMenu

    class OverviewVC: UIViewController {
         let setting = Setting.share
        var itemNames = ["Eating Out", "Groceries","Entertainment","Car","Clothes & Shoes","Household","" ]
        var used = [27,62,23,42,0,12,166]
        var limits = [100,150,120,100,100,50,620]
        
        @IBOutlet weak var tableView: UITableView!
        override func viewDidLoad() {
    
            
            super.viewDidLoad()
            setupSideMenu()
            tableView.sectionHeaderHeight = 44
            tableView.tableFooterView = UIView() 
        }

        @IBAction func openMenu(_ sender: Any) {
            present(SideMenuManager.menuLeftNavigationController!, animated: true, completion: nil)
            // present(SideMenuManager.menuRightNavigationController!, animated: true, completion: nil)
        }
        
        override func viewWillAppear(_ animated: Bool) {
            tableView.reloadData()
        }
        
        
        fileprivate func setupSideMenu() {
            // Define the menus
            let menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? UISideMenuNavigationController
            menuLeftNavigationController?.leftSide = true
            SideMenuManager.menuLeftNavigationController = menuLeftNavigationController
        }
}


extension OverviewVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "headcell") as! ListHeaderCell
        cell.remain = setting.getRemain()
        cell.displayItem()
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return setting.oldUser ? itemNames.count:0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListCell
        let quota = Quota(name: itemNames[indexPath.row], limit: limits[indexPath.row])
        if indexPath.row == itemNames.count - 1 {
            cell.displayItem2(quota,expense:used[indexPath.row])
        } else {
            cell.displayItem(quota,expense:used[indexPath.row])
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "overviewdetail") as! overviewDetailVC
        vc.parentVC = self
        vc.selectItem = indexPath.row
        navigationController?.pushViewController(vc, animated: true)
       
    }
    
    
    
}
