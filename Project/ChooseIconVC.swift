//
//  MainVC.swift
//  Project
//
//  Created by siqi on 2/23/17.
//  Copyright © 2017 aau. All rights reserved.
//

import UIKit

class ChooseIconVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate, UITextFieldDelegate {
 
    var parentVC:DetailVC!
    let setting = Setting.share
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }



    @IBAction func iconDidTap(_ sender: UIButton) {
      setting.icon = sender.tag
      parentVC.iconChoosed = true
      dismiss(animated: true, completion: nil)
        
        
    }
    

    
    func alert(title: String, message: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel) {
            (action) in
        }
        alertController.addAction(cancel)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if let nextField = view.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
        }
        
        return false
    }

    
    
    @IBAction func chooseAlbum(_ sender: UIButton) {
        let alertController = UIAlertController(title: "選擇功能", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let cancel = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel) {
            (action) in
            
        }
        
        
        
        let photoLibrayTappedAction = UIAlertAction(title: "選取照片", style: .default) {
            (action) in
            self.photoLibrayTapped(controller: self) {
                (picker, isSourceTypeAvailable) in
                if isSourceTypeAvailable == true {
                    self.present(picker!, animated: true, completion: nil)
                } else {
                    self.alert(title: "請允讀取相簿", message: "")
                }
            }
        }
        
        let cameraTappedAction = UIAlertAction(title: "拍照", style: UIAlertActionStyle.default) {
            (action) in
            self.cameraTapped(controller: self) {
                (picker, isSourceTypeAvailable) in
                if isSourceTypeAvailable == true {
                    self.present(picker!, animated: true, completion: nil)
                } else {
                    self.alert(title: "請允許相機功能", message: "")
                }
            }
        }
        
        alertController.addAction(cancel)
        alertController.addAction(photoLibrayTappedAction)
        alertController.addAction(cameraTappedAction)
        
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    
     func cameraTapped<T>(controller: T, completionHandler: (UIImagePickerController?, _
        
        isSourceTypeAvailable: Bool) -> Void) where T: UIImagePickerControllerDelegate, T: UINavigationControllerDelegate {
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let picker = UIImagePickerController()
            
            picker.delegate = controller
            picker.sourceType = .camera
            
            completionHandler(picker, true)
        } else {
            completionHandler(nil, false)
        }
        
    }
    
     func photoLibrayTapped<T>(controller: T, completionHandler: (UIImagePickerController?, _
        
        isSourceTypeAvailable: Bool) -> Void) where T: UIImagePickerControllerDelegate, T: UINavigationControllerDelegate {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let picker = UIImagePickerController()
            
            picker.delegate = controller
            picker.sourceType = .photoLibrary
            
            completionHandler(picker, true)
        } else {
            completionHandler(nil, false)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] {
            let imageName = "goal.jpg"
            let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
            
            if let jpegData = UIImageJPEGRepresentation(image as! UIImage, 0.4) {
                try? jpegData.write(to: imagePath)
            }
        }
        dismiss(animated: true, completion: {
             self.parentVC.iconChoosed = true
             self.dismiss(animated: true, completion: nil)
        })
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }

}
