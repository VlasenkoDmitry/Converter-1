//
//  Validation.swift
//  Converter-1
//
//  Created by Ap on 30.06.22.
//

import Foundation
import UIKit

class Validation {
    
    func validateTextField(textField: UITextField) -> String {
        var result = ""
        if let text = textField.text {
            if text == "." {
                result = "0"
            }
            if text.prefix(1) == "0" {
                result = text
                result.removeFirst()
            }
            if let numberPoints = textField.text?.filter({ $0 == "." }).count {
                if numberPoints > 1 {
                    result = text
                    result.removeLast()
                }
            }
        } else {
            result = "0"
        }
        return result
    }
}
