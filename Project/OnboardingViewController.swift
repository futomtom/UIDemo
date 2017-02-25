//
//  OnboardingViewController.swift
//  Athlee-Onboarding
//
//  Created by mac on 06/07/16.
//  Copyright © 2016 Athlee. All rights reserved.
//

import UIKit
import OnboardingKit

public final class OnboardingViewController: UIViewController {

  // MARK: Outlets 
  
  @IBOutlet weak var onboardingView: OnboardingView!
  @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var pageItemButton: UIButton!
  
  // MARK: Properties 
  
  private let model = DataModel()
  
  // MARK: Life cycle 
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    
    nextButton.alpha = 0
    
    onboardingView.dataSource = model
    onboardingView.delegate = model
    
    model.didShow = { page in
      if page == 4 {
        UIView.animate(withDuration: 0.3) {
          self.nextButton.alpha = 1
        }
        self.pageItemButton.isHidden = false
      } else {
         self.pageItemButton.isHidden = true
        }
    }
    
    model.willShow = { page in
      if page != 4 {
        self.nextButton.alpha = 0
      }
    }
  }
    @IBAction func nextDidTap(_ sender: UIButton) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.processToMainPage()
        
    }
  
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
