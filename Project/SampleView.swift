//
//  SampleView.swift
//  CustomizableActionSheet
//
//  Created by beryu on 2015/12/27.
//  Copyright © 2015年 blk. All rights reserved.
//

import UIKit

@objc protocol SampleViewDelegate {
    func dismissSheet()
    func doneSheet()
    
}

class SampleView: UIView {
    @IBOutlet weak var picker: UIPickerView!
    
  weak var delegate: SampleViewDelegate?
    @IBAction func cancelDidTapped(_ sender: Any) {
        delegate?.dismissSheet()
    }
    
    @IBAction func doneSheet(_ sender: Any) {
         delegate?.doneSheet()
    }
    
  
 }


