//
//  Сonversionata.swift
//  Converter-1
//
//  Created by Ap on 6.06.22.
//

import Foundation
import UIKit

class ConversionData: ConversionDataProtocol {

    private let amount: String?
    private let from: String?
    private let to: String?
    private var result: String?
    private var image: UIImage?
    
    init(amount: String?, from: String?, to: String?, result: String?, image: UIImage?) {
        self.amount = amount
        self.from = from
        self.to = to
        self.result = result
        self.image = image
    }
    
    func getResult() -> String? {
        return result
    }
    
    func getImage() -> UIImage? {
        return image
    }
    
    func getToCurrence() -> String? {
        return to
    }
    
    func setResult(result: String?) {
        self.result = result
    }
    
    func setImage(image: UIImage?) {
        self.image = image
    }
}


