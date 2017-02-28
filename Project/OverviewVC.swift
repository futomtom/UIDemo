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
        
        @IBOutlet weak var tableView: UITableView!
        override func viewDidLoad() {
            super.viewDidLoad()
            setupSideMenu()
            tableView.sectionHeaderHeight = 44
            
        }

        @IBAction func openMenu(_ sender: Any) {
            present(SideMenuManager.menuLeftNavigationController!, animated: true, completion: nil)
            // present(SideMenuManager.menuRightNavigationController!, animated: true, completion: nil)
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
        cell.displayItem()
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListCell
        
        cell.displayItem()
        
        return cell
    }
    
    
    
}
