//
//  NetworkManager.swift
//  Converter-1
//
//  Created by Ap on 6.06.22.
//

import Foundation
import UIKit

class NetworkManager {
       
    func requestConversion(amount: String, from: String, to: String, completion: (ConversionData?)->()) {
        let random = Double.random(in: 1..<200000)
        completion(ConversionData(amount: amount, from: from, to: to, result: "\(random)", image: nil))
    }
    
    func dowmloadImage(url: URL, completion: (Data?)->()) {
        completion( UIImage(systemName: "pencil" )?.pngData())
    }
    
}
