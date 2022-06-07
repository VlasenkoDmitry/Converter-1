//
//  Сonversion.swift
//  Converter-1
//
//  Created by Ap on 6.06.22.
//

import Foundation
import UIKit

class ConversionData {
    let amount: String?
    let from: String?
    var to: String?
    var result: String?
    var image: UIImage?
    
    init(amount: String?, from: String?, to: String?, result: String?, image: UIImage?) {
        self.amount = amount
        self.from = from
        self.to = to
        self.result = result
        self.image = image
    }
}


