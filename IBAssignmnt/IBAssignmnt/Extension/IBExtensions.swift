//
//  IBExtensions.swift
//  IBAssignmnt
//
//  Created by Ichrak BORGI on 1/10/2021.
//

import Foundation
import CryptoKit
import UIKit

extension String {
    
/*
  1- Max lettres 7
     2- "-" in the middle
     3- prevent special character
     4- prevent numbers
     5- 3 lettres then "-" then 3 lettres
     6- Taping the same lettre is not mentioned ( allowed)
     7- reverse the string
*/
    
    //Only lettrers or "-"
    var isNumberOrSpecialCharacter: Bool{
        let disallowedCharacterSet = NSCharacterSet(charactersIn: "0123456789!@#$%^&*()_+{}[]|\"<>,.~`/:;?=\\¥'£•¢")
        let isnotValidCharacter =
            self.rangeOfCharacter(from: disallowedCharacterSet as CharacterSet) != nil
        return isnotValidCharacter
    }
    
    var containsEmoji: Bool {
            for scalar in unicodeScalars {
                switch scalar.value {
                case 0x1F600...0x1F64F, // Emoticons
                     0x1F300...0x1F5FF, // Misc Symbols and Pictographs
                     0x1F680...0x1F6FF, // Transport and Map
                     0x2600...0x26FF,   // Misc symbols
                     0x2700...0x27BF,   // Dingbats
                     0xFE00...0xFE0F,   // Variation Selectors
                     0x1F900...0x1F9FF, // Supplemental Symbols and Pictographs
                     0x1F1E6...0x1F1FF: // Flags
                    return true
                default:
                    continue
                }
            }
            return false
        }
    
    //index 4 should be "-"
    func match(_ location: Int, _ newString: String) -> Bool{
       
        let length = self.utf16.count
        var match = [String]()

        
        if length < 8 {
            if location == 3 {
                match = matches(for: "-", in: newString)
                if match.count == 0 {
                    if newString.isEmpty == true {
                        return true
                    }
                    return false
                }
               return true
               
            }else{
                
                match = matches(for: "[a-z]", in: newString)
                if match.count == 0 {
                    if newString.isEmpty == true {
                        return true
                    }
                    return false
                }
               return true
               
            }
        }
        return false
        
       
    }
    
    //Check
    func matches(for regex: String, in text: String) -> [String] {

        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: text,
                                        range: NSRange(text.startIndex..., in: text))
            return results.map {
                String(text[Range($0.range, in: text)!])
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
 
    //Reverse String
    //Random Shuffle
    func reverseString() -> String{
        
        let listItems = self.components(separatedBy: "-")
        var newlList = [String]()
        for string in listItems{
        
            var a = Array(string)
            a.shuffleArray()
            let shuffledWord = String(a)
            newlList.append(String(shuffledWord))
            
        }
        newlList.shuffle()
        let reversedString = newlList.joined(separator: "-")
      
        return  reversedString
    }
    
    //decrypt data
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self, options: Data.Base64DecodingOptions(rawValue: 0)) else {
             return nil
         }

         return String(data: data as Data, encoding: String.Encoding.utf8)
    }
    //encrypt data
    func toBase64() -> String {
        guard let data = self.data(using: String.Encoding.utf8) else {
              return ""
          }

          return String(data.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0)))
          
    }
    
   //Save data to preference
    func saveText(){
        let text  =  self.toBase64
        UserDefaults.standard.setValue(text, forKey: ENCODED_DATA)
        UserDefaults.standard.synchronize()
    }
  
}


extension Array {
    mutating func shuffleArray() {
        for i in 0..<(count - 1) {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            guard i != j else { continue}
            self.swapAt(i, j)
        }
    }
}

extension UIView {
    
    func addCorner(){
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
    }
 
}
