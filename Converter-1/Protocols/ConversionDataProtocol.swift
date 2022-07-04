//
//  ConversionData.swift
//  Converter-1
//
//  Created by Ap on 4.07.22.
//

import Foundation
import UIKit

protocol ConversionDataProtocol {
    func getResult() -> String?
    func getImage() -> UIImage?
    func getToCurrence() -> String?
    func setResult(result: String?)
    func setImage(image: UIImage?)
}
