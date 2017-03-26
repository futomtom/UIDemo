//
//  MainVC.swift
//  Project
//
//  Created by siqi on 2/23/17.
//  Copyright © 2017 aau. All rights reserved.
//

import UIKit
import TextFieldEffects




class Setting {
    static let share = Setting()
    var duration = 0
    var dream = ""
    var price = 0
    var fix = 0
    var discret = 0
    var income = 0
    var saving = 0
    var oldUser:Bool = false
    var icon = 0
    var image: URL?
    var fixexQuota:[Quota] = []
    var discretQuota:[Quota] = []
    
    var expenses = [[Expenses(name:"Shell",price:30),Expenses(name:"Chevron",price:25)],
                    [Expenses(name:"Dim Sum",price:60),Expenses(name:"Burger King",price:10)],
                    [Expenses(name:"shopping",price:45),Expenses(name:"movie",price:16)]
                    ]
   public func  getTotal(_ quota:[Quota]) -> Int {
        var total = 0
        for item in quota {
            total = total + item.limit
        }
        return total
    }
    
    
   public func getRemain() -> Int {
        let fixTotal = getTotal(fixexQuota)
        let discretTotal = getTotal(discretQuota)
        let remain = income - fixTotal - discretTotal
        return remain
        
    }
    
}

class DetailVC: UIViewController {
    
    @IBOutlet weak var picker: UIPickerView!
    var setting = Setting.share

    @IBOutlet weak var IconImageView: UIImageView!
    @IBOutlet weak var chooseButton: UIButton!
 //   @IBOutlet weak var incomeField: UITextField!
    @IBOutlet weak var dreamField: JiroTextField!

    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var priceField: JiroTextField!
    var iconChoosed: Bool {
        set {
            doneButton.isHidden = !iconChoosed
            fillImage()

        }
        get {
            return true
        }
    }

    @IBOutlet weak var doneButton: BorderButton!


    func fillImage() {
        if setting.icon == 0 {
            let imagePath = getDocumentsDirectory().appendingPathComponent("goal.jpg")

            IconImageView.image = UIImage(contentsOfFile: imagePath.path)
            chooseButton.setTitle("", for: .normal)

        } else {
            IconImageView.image = UIImage(named: "dream\(setting.icon)")
            chooseButton.setTitle("", for: .normal)
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        get {
            return true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = UIColor(red: 0.659, green: 0.792, blue: 0.812, alpha: 1)
         

        let setting = Setting.share
    }

    override func viewWillAppear(_ animated: Bool) {
        title = ""
    }
    

    @IBAction func ChooseIcon(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "chooseicon") as! ChooseIconVC
        vc.parentVC = self
        present(vc, animated: true)

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "great" {
    //        setting.income = Int(incomeField.text!) ?? 0
            setting.dream = dreamField.text!
            setting.price = Int(priceField.text!) ?? 0
        }
    }

    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
}

extension DetailVC: UIPickerViewDataSource, UIPickerViewDelegate {
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }

    func pickerView (_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return component == 0 ? 10 :11
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return component == 0 ? "\(row ) year":"\(row + 1) month"
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print (component)
      setting.duration = pickerView.selectedRow(inComponent: 0) * 12 +  pickerView.selectedRow(inComponent: 1) + 1
        print(setting.duration)
    }
}
