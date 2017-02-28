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
    
    class ProgressVC: UIViewController , PieChartDelegate{
        let setting = Setting.share
       
        @IBOutlet weak var chartView: PieChart!
        @IBOutlet weak var imageView: UIImageView!
        @IBOutlet weak var maskView: UIView!
        @IBOutlet weak var highConstrain: NSLayoutConstraint!
        fileprivate static let alpha: CGFloat = 0.5
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
            chartView.layers = [createPlainTextLayer(), createTextWithLinesLayer()]
            chartView.delegate = self
        }
        
        // MARK: - PieChartDelegate
        
        func onSelected(slice: PieSlice, selected: Bool) {
            print("Selected: \(selected), slice: \(slice)")
        }
        
        // MARK: - Models
        
        fileprivate func createModels() -> [PieSliceModel] {
            
            let count = setting.expenses.count
            var models:[PieSliceModel]=[]
            
            var subtotal:[Int]=Array(repeating: 0, count: count)
            for i in 0..<count {
                for item in setting.expenses[i] {
                     subtotal[i] += item.price
                }
                models.append(PieSliceModel(value: Double(subtotal[i]), color: colors[i]))
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
        
        fileprivate func createTextWithLinesLayer() -> PieLineTextLayer {
            let lineTextLayer = PieLineTextLayer()
            var lineTextLayerSettings = PieLineTextLayerSettings()
            lineTextLayerSettings.lineColor = UIColor.lightGray
            let formatter = NumberFormatter()
            formatter.maximumFractionDigits = 1
            lineTextLayerSettings.label.font = UIFont.systemFont(ofSize: 14)
            lineTextLayerSettings.label.textGenerator = {slice in
                return formatter.string(from: slice.data.model.value as NSNumber).map{"\($0)"} ?? ""
            }
            
            lineTextLayer.settings = lineTextLayerSettings
            return lineTextLayer
        }
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

