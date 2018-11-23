//
//  ViewController.swift
//  MemeMe 1.0
//
//  Created by SARA ALHUMUD on 3/12/1440 AH.
//  Copyright © 1440 SARA ALHUMUD. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var cancelBtn: UIBarButtonItem!
    @IBOutlet weak var shareBtn: UIBarButtonItem!
    @IBOutlet weak var cameraBtn: UIBarButtonItem!
    @IBOutlet weak var albumBtn: UIBarButtonItem!
    @IBOutlet weak var memeView: UIView!
    @IBOutlet weak var topField: UITextField!
    @IBOutlet weak var bottomField: UITextField!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var toolBar: UIToolbar!
    
    @IBAction func cancelBtn(_ sender: Any) {
        lunchState()
    }
    
    @IBAction func shareBtn(_ sender: Any) {
        let memedImage = generateMemedImage()
        let shareController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        
        present(shareController, animated: true, completion: nil)
        
        shareController.completionWithItemsHandler = {activity, completed, items, error -> Void in
            if completed {
                self.save(memedImage: memedImage)
                self.dismiss(animated: true , completion: nil)
            }
        }
    }
    
    @IBAction func cameraBtn(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.sourceType = .camera
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func albumBtn(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.sourceType = .photoLibrary
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print(info)
        dismiss(animated: true, completion: nil)
        
        if let selectedImg = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            img.image = selectedImg
            shareBtn.isEnabled = true

        } else {
            print("Failed")
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
    }
    
    func lunchState(){
        shareBtn.isEnabled = false
        img.image = nil
        topField.text = "Top"
        bottomField.text = "Bottom"
        cameraBtn.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        topField.resignFirstResponder()
        bottomField.resignFirstResponder()
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == "Top" || textField.text == "Bottom" {
            textField.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func specifyTextAttributes(){
        let textAttributes: [String: Any] = [
            NSAttributedStringKey.strokeColor.rawValue: UIColor.black,
            NSAttributedStringKey.foregroundColor.rawValue: UIColor.white,
            NSAttributedStringKey.strokeWidth.rawValue: -2.5,
            NSAttributedStringKey.font.rawValue: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!
        ]
        
        topField.defaultTextAttributes = textAttributes
        bottomField.defaultTextAttributes = textAttributes
        topField.borderStyle = .none
        bottomField.borderStyle = .none
        topField.textAlignment = .center
        bottomField.textAlignment = .center
        
    }
    
    @objc func keyboardWillShow(_ notification: Notification){
        
        if bottomField.isFirstResponder {
            view.frame.origin.y -= getKeyboradHeight(notification)
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification){
        view.frame.origin.y = CGFloat(0.0)
    }
    
    func getKeyboradHeight(_ notification: Notification) -> CGFloat{
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
        
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)

    }
    
    func save(memedImage: UIImage){
        let meme = Meme(topText: topField.text ?? "", bottomText: bottomField.text ?? "", orginalText: img.image!, memedImage: memedImage)
        print(meme)
    }
    
    func generateMemedImage() -> UIImage {
        navBar.isHidden = true
        toolBar.isHidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        navBar.isHidden = false
        toolBar.isHidden = false
        
        return memedImage
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        lunchState()
        topField.delegate = self
        bottomField.delegate = self
        
        specifyTextAttributes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraBtn.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        subscribeToKeyboardNotifications()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

