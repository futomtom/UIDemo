//
//  ViewController.swift
//  StencilView
//
//  Created by Swarup on 28/6/16.
//  Copyright © 2016 swarup. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var textView: StencilView!
    @IBOutlet weak var textView2: StencilView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
         self.textView.drawText("Siqi")
         self.textView2.drawText("Chen")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4)) {
            self.toLogin()
        }
        
    }
    
    
    func toLogin() {
        let rootNavi = storyboard?.instantiateViewController(withIdentifier: "rootnavi") as! UINavigationController
        let appDelegate = UIApplication.shared
        if let window = appDelegate.keyWindow{
            window.rootViewController = rootNavi
        }
    }
}

