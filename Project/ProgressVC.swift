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
    
    class ProgressVC: UIViewController , PieChartDelegate {
        let setting = Setting.share
       
        @IBOutlet weak var chartView: PieChart!
        @IBOutlet weak var imageView: UIImageView!
        @IBOutlet weak var maskView: UIView!
        @IBOutlet weak var highConstrain: NSLayoutConstraint!
        @IBOutlet weak var tableView: UITableView!
        
        @IBOutlet weak var progressLabel: UILabel!
     
        
        fileprivate static let alpha: CGFloat = 0.5
        var itemNames = ["Eating Out", "Groceries","Entertainment","Car","Clothes & Shoes","Household" ]
        var used = ["27/100","62/150","23/120","42/100","0/50","12/50"]
        var price = [27,62,23,42,0,12]
        
        

        let colors = [
            UIColor.yellow.withAlphaComponent(alpha),
            UIColor.green.withAlphaComponent(alpha),
            UIColor.purple.withAlphaComponent(alpha),
            UIColor.cyan.withAlphaComponent(alpha),
            UIColor.darkGray.withAlphaComponent(alpha),
            UIColor.red.withAlphaComponent(alpha),
            UIColor.magenta.withAlphaComponent(alpha),
            UIColor.orange.withAlphaComponent(alpha),
            UIColor.brown.withAlphaComponent(alpha),
            UIColor.lightGray.withAlphaComponent(alpha),
            UIColor.gray.withAlphaComponent(alpha),
            ]
        fileprivate var currentColorIndex = 0
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            setupSideMenu()
        }
        
        override func viewWillAppear(_ animated: Bool) {
            highConstrain.constant = 70
            
            if setting.oldUser == false {
                progressLabel.text = "0%"
                maskView.isHidden = true
                chartView.isHidden = true
                
            }
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
        
        override func viewDidAppear(_ animated: Bool) {
            
            
            chartView.models = createModels()
            chartView.layers = [createPlainTextLayer()]
            chartView.delegate = self
        }
        
        // MARK: - PieChartDelegate
        
        func onSelected(slice: PieSlice, selected: Bool) {
            print("Selected: \(selected), slice: \(slice)")
        }
        
        // MARK: - Models
        
        fileprivate func createModels() -> [PieSliceModel] {
            
            let count = itemNames.count
            var models:[PieSliceModel]=[]
            
            var subtotal:[Int]=Array(repeating: 0, count: count)
            for i in 0..<count {
                models.append(PieSliceModel(value: Double(price[i]), color: colors[i]))
            }
            
            currentColorIndex = models.count
            return models
        }
        
        
        
        // MARK: - Layers
        
        fileprivate func createPlainTextLayer() -> PiePlainTextLayer {
            
            let textLayerSettings = PiePlainTextLayerSettings()
            textLayerSettings.viewRadius = 55
            textLayerSettings.hideOnOverflow = true
            textLayerSettings.label.font = UIFont.systemFont(ofSize: 8)
            
            let formatter = NumberFormatter()
            formatter.maximumFractionDigits = 1
            textLayerSettings.label.textGenerator = {slice in
                return formatter.string(from: slice.data.percentage * 100 as NSNumber).map{"\($0)%"} ?? ""
            }
            
            let textLayer = PiePlainTextLayer()
            textLayer.settings = textLayerSettings
            return textLayer
        }
    /*
        fileprivate func createTextWithLinesLayer() -> PieLineTextLayer {
            let lineTextLayer = PieLineTextLayer()
            var lineTextLayerSettings = PieLineTextLayerSettings()
            lineTextLayerSettings.lineColor = UIColor.lightGray
            let formatter = NumberFormatter()
            formatter.maximumFractionDigits = 1
            lineTextLayerSettings.label.font = UIFont.systemFont(ofSize: 14)
            lineTextLayerSettings.label.textGenerator = {slice in
                slice.data.model.value = price
                return formatter.string(from: slice.data.model.value as NSNumber).map{"\($0)"} ?? ""
            }
            
            lineTextLayer.settings = lineTextLayerSettings
            return lineTextLayer
        }
 */
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func randomColor() -> UIColor {
        return UIColor(red: .random(), green: .random(), blue: .random(), alpha: 1.0)
    }
}

extension ProgressVC: UITableViewDataSource {

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return setting.oldUser ? itemNames.count:0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ExpenseCell
      cell.name.text = itemNames[indexPath.row]
      cell.price.text = used[indexPath.row]
        
        return cell
    }
    
    
    
}


