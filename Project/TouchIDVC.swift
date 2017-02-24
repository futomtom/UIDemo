//
//  MainVCViewController.swift
//  Project
//
//  Created by alexfu on 2/19/17.
//  Copyright © 2017 aau. All rights reserved.
//

import UIKit
import LocalAuthentication


class TouchIDVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    
    @IBAction func DoPay(_ sender: Any) {
        touchIDAuth()
        
    }
    
    func touchIDAuth(){
        //检查Touch ID是否可用
        let authenticationContext = LAContext()
        var error: NSError?
        let isTouch = authenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,error: &error)
        if isTouch{
            //获取指纹验证结果
            authenticationContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "需要验证您的指纹来确认您的身份信息", reply: {
                (success, error) -> Void in
                if success{
                    print("恭喜，您通过了Touch ID指纹验证！")
                }else{
                    print("抱歉，您未能通过Touch ID指纹验证！\n\(error)")
                }
            })
        }else{
            print("抱歉，Touch ID不可以使用！\n\(error)")
        }
    }

}
