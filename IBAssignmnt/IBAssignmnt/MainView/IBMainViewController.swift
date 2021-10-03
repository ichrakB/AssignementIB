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
        
        self.poppupView.addCorner()
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
    //Check the input
    //The text input should have 6 letters + "_" in the middle
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string.isNumberOrSpecialCharacter == true
            || string.containsEmoji == true   {
            
            return false
        }else {
            
            let newString = textField.text! + string
            
            if newString.match(range.location, string) ==  true {
                return true
            }
            return false
            
        }
        
    }
    
    //Action to show the popup
    @IBAction func showPopPup(){
        
        guard let text =  self.poppupViewMessage.text  else {
            return
        }
        guard let reversedText = textfield.text?.reverseString()  else {
            return
        }
        self.poppupViewMessage.text =  text +  reversedText
        self.poppupView.isHidden = false
        
    }
    //Action to close the popup
    @IBAction func closePopPup(){
        //  textfield.text = textfield.text?.reverseString()
        self.poppupView.isHidden = true
        
    }
    //Action to SAVE the text
    @IBAction func saveText(){
        
        guard let text =  textfield.text?.reverseString() else {
            return
        }
        
        UserDefaults.standard.setValue(text.toBase64(), forKey: ENCODED_DATA)
        UserDefaults.standard.synchronize()
        textfield.text = text
        closePopPup()
    }
    
    
    
    @objc func checkAction(sender : UITapGestureRecognizer) {
        if self.poppupView.isHidden == false {
            self.closePopPup()
        }
    }
}

