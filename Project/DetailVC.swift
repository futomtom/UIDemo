//
//  MainVC.swift
//  Project
//
//  Created by siqi on 2/23/17.
//  Copyright © 2017 aau. All rights reserved.
//

import UIKit




class Setting {
    static let share = Setting()
    var duration = 0
    var dream = ""
    var price = 0
    var fix = 0
    var discret = 0
    var income = 0
    var saving = 0 
    var icon = 0
    var image: URL?
    var fixexQuota = [ Quota(name:"Rent",limit:800),Quota(name:"Cell phone",limit:40),Quota(name:"Transportation",limit:60) ]
    var discretQuota = [ Quota(name:"Gas",limit:45),Quota(name:"Eating Out",limit:80),Quota(name:"Entertainment",limit:200),Quota(name:"Utilities",limit:200) ]
    var expenses = [[Expenses(name:"Shell",price:30),Expenses(name:"Chevron",price:25)],
                    [Expenses(name:"Dim Sum",price:60),Expenses(name:"Burger King",price:10)],
                    [Expenses(name:"shopping",price:45),Expenses(name:"movie",price:16)]
                    ]
    func  getTotal(_ quota:[Quota]) -> Int {
        var total = 0
        for item in quota {
            total = total + item.limit
        }
        return total
    }
    
}

class DetailVC: UIViewController {
    @IBOutlet weak var picker: UIPickerView!
    var setting = Setting.share

    @IBOutlet weak var IconImageView: UIImageView!
    @IBOutlet weak var chooseButton: UIButton!
    @IBOutlet weak var dreamField: UITextField!

    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var priceField: UITextField!
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
        return 1
    }


    func pickerView (_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        return 6
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row + 1) month"
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        setting.duration = row + 1
    }

}
