//
//  MainVC.swift
//  Project
//
//  Created by siqi on 2/23/17.
//  Copyright © 2017 aau. All rights reserved.
//

import UIKit

class PerfectVC: UIViewController {
    let setting = Setting.share

    @IBOutlet weak var dreamLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!

    @IBOutlet weak var durationLabel: UILabel!

    @IBOutlet weak var priceLabel: UILabel!

    @IBOutlet weak var incomeLabel: UILabel!

    @IBOutlet weak var discretLabel: UILabel!



    @IBOutlet weak var fixfeeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = UIColor(red: 0.659, green: 0.792, blue: 0.812, alpha: 1)
        setupLabel()

    }
    func fillImage() {
        if setting.icon == 0 {
            let imagePath = getDocumentsDirectory().appendingPathComponent("goal.jpg")
            iconImageView.image = UIImage(contentsOfFile: imagePath.path)
        } else {
            iconImageView.image = UIImage(named: "dream\(setting.icon)")
        }
    }

    func setupLabel() {
        dreamLabel.text = setting.dream
        fillImage()
        durationLabel.text = "\(setting.duration)month"
        priceLabel.text = "$\(setting.price)"
        fixfeeLabel.text = "$\(setting.fix)"
        incomeLabel.text = "$\(setting.income)"
        discretLabel.text = "$\(setting.discret)"
    }

    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }


    override func viewWillAppear(_ animated: Bool) {
        title = ""
    }


    @IBAction func OKDidTap(_ sender: Any) {
        let confettiView = SAConfettiView(frame: self.view.bounds)
        confettiView.type = .triangle
        self.view.addSubview(confettiView)

        confettiView.startConfetti()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.processToHomePage() }



    }

}
