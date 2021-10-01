//
//  IBMainViewController.swift
//  IBAssignmnt
//
//  Created by Ichrak BORGI on 1/10/2021.
//

import Foundation

import UIKit
import CryptoKit

class IBMainViewController: UIViewController {
    @IBOutlet weak var textfield: UITextField!
   
    @IBOutlet weak var button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let defaults = UserDefaults.standard
      
       
       
    }


}

extension IBMainViewController: UITextFieldDelegate {
    
    private func textFieldDidBeginEditing(textField: UITextField!) {    //delegate method

    }

    private func textFieldShouldEndEditing(textField: UITextField!) -> Bool {  //delegate method
        return false
    }

    private func textFieldShouldReturn(textField: UITextField!) -> Bool {   //delegate method
      textField.resignFirstResponder()

        return true
    }
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
    
    @IBAction func showPopPup(){
        textfield.text = textfield.text?.reverseString()
      
    }
    
   
 
}

