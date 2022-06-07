//
//  TableViewCellViewModel.swift
//  Converter-1
//
//  Created by Ap on 6.06.22.
//

import Foundation
import UIKit

class TableViewCellViewModel: TableViewCellViewModelType {
    var resultObject: ConversionData
    
    init(result: ConversionData) {
        self.resultObject = result
    }
    
    var result: String {
        return resultObject.result ?? ""
    }
    
    var currencyNameTo: String {
        return resultObject.to ?? ""
    }
    
    var image: UIImage? {
        return resultObject.image ?? UIImage(named: "xmark")
    }
    
}


