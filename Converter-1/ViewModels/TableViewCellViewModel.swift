//
//  TableViewCellViewModel.swift
//  Converter-1
//
//  Created by Ap on 6.06.22.
//

import Foundation
import UIKit

class TableViewCellViewModel: TableViewCellViewModelType {
    private var resultObject: ConversionData
    
    init(result: ConversionData) {
        self.resultObject = result
    }
    
    var result: String {
        return resultObject.getResult() ?? ""
    }
    
    var currencyNameTo: String {
        return resultObject.getToCurrence() ?? ""
    }
    
    var image: UIImage? {
        return resultObject.getImage() ?? UIImage(named: "xmark")
    }
    
}


