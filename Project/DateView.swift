//
//  DateView.swift
//  VKPopupViewExample
//
//  Created by Vladislav Kovalyov on 2/2/17.
//  Copyright © 2017 WOOPSS.com. All rights reserved.
//

import UIKit

class DateView: UIView
{
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var priceField: UITextField!
  
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        
    }
    
    @IBAction func submit(_ sender: Any) {
        
        
    }
    
}

