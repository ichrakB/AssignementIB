//
//  IBMainViewController.swift
//  IBAssignmnt
//
//  Created by Ichrak BORGI on 1/10/2021.
//

import Foundation
import UIKit


let ENCODED_DATA = "EncryptedData"
class IBMainViewController: UIViewController {
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var button: IBRoundButton!
    @IBOutlet weak var poppupView: UIView!
    @IBOutlet weak var poppupViewMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        customizeView()
        
       
    }
    
    //Customize MainView
    
    func customizeView(){
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.checkAction))
        self.view.addGestureRecognizer(gesture)
        self.poppupView.isHidden = true
        self.view.bringSubviewToFront(self.poppupView)
        self.textfield.becomeFirstResponder()
        if oldText().isEmpty == false {
            self.textfield.text = oldText()
        }
       
    }
    //Retrieve encryptedData
    func oldText() -> String{
        guard let encryptedData =  UserDefaults.standard.value(forKey: ENCODED_DATA) as? String else {
            return ""
        }
        return encryptedData.fromBase64()!
    }

}

extension IBMainViewController: UITextFieldDelegate {
    
    
    private func textFieldShouldEndEditing(textField: UITextField!) -> Bool {
        return false
    }

    private func textFieldShouldReturn(textField: UITextField!) -> Bool {
     
        textField.resignFirstResponder()
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       
        if string.isNumberOrSpecialCharacter == true
        || string.containsEmoji == true   {
          
            return false
        }else {
            if string.isEmpty == true{
                return false
            }
            let newString = textField.text! + string
            
            if newString.match(range.location, string) ==  true {
                return true
            }
            return false
           
        }
 
    }
    
    @IBAction func showPopPup(){
      //  textfield.text = textfield.text?.reverseString()
        self.customizePopup()
        guard let text =  self.poppupViewMessage.text  else {
            return
        }
        self.poppupViewMessage.text =  text +  (textfield.text?.reverseString())!
        self.poppupView.isHidden = false
       
    }
    @IBAction func closePopPup(){
      //  textfield.text = textfield.text?.reverseString()
        self.poppupView.isHidden = true
       
    }
    @IBAction func saveText(){
     
        guard let text =  textfield.text?.reverseString() else {
            return
        }
       
            UserDefaults.standard.setValue(text.toBase64(), forKey: "EncryptedData")
            UserDefaults.standard.synchronize()
        textfield.text = text
        closePopPup()
     }
    
    func customizePopup(){
        self.poppupView.addCorner()
    }
    
    
    @objc func checkAction(sender : UITapGestureRecognizer) {
        if self.poppupView.isHidden == false {
            self.closePopPup()
        }
    }
}

