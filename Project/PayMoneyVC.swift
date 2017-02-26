//
//  PayMoneyVCViewController.swift
//  
//
//  Created by Alex on 2/25/17.
//
//

import UIKit
import LocalAuthentication

   var grocerybuget = 100

class PayMoneyVC: UIViewController {
    var total = 0
 

    @IBOutlet weak var TotalMoney: UILabel!
    
    @IBOutlet weak var buget: UILabel!
    
    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        TotalMoney.text = "\(total)"
        buget.text = "Your budget in Groceries is" + "\(grocerybuget)"
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
                    
                }else{
                    
                }
            })
        }else{
            print("抱歉，Touch ID不可以使用！\n\(error)")
        }
    }


  
    @IBAction func OK(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
