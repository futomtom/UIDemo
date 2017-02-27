//
//  ViewController.swift
//  LUExpandableTableViewExample
//
//  Created by Laurentiu Ungur on 21/11/2016.
//  Copyright © 2016 Laurentiu Ungur. All rights reserved.
//

import UIKit
import SideMenu
import PieCharts
    
    class ProgressVC: UIViewController {
       
        
        override func viewDidLoad() {
            super.viewDidLoad()
            setupSideMenu()
            
            
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
