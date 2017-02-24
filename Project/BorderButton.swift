//
//  BorderButton.swift
//
//  Created by Ryo Eguchi on 2016/12/14.
//  Copyright © 2016年 Ryo Eguchi. All rights reserved.
//

import UIKit


class BorderButton: UIButton {
    
     var borderColor: UIColor!
     var borderWidth: CGFloat!
     var cornerRadius: CGFloat!
    
    required init(coder aDecoder: NSCoder) {
        //if (!(self=super.init(frame: frame))) return self// 
        super.init(coder: aDecoder)!
        
        layer.cornerRadius = 4
        layer.borderWidth = 1
        layer.borderColor = UIColor(red:0.545,  green:0.694,  blue:0.718, alpha:1).cgColor
        
        //return self
    }
    
    func setBorderColor(borderColor: UIColor) {
        self.borderColor = borderColor
        self.layer.borderColor = self.borderColor.cgColor
    }
    
    func setBorderWidth(borderWidth: CGFloat) {
        self.borderWidth = borderWidth
        self.layer.borderWidth = borderWidth
    }
    

    
    func setCornerRadius(cornerRadius: CGFloat) {
        self.cornerRadius = cornerRadius
        self.layer.cornerRadius = cornerRadius
    }
    
}
