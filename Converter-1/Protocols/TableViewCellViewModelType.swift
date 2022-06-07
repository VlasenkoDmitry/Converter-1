//
//  TableViewCellViewModelType.swift
//  Converter-1
//
//  Created by Ap on 7.06.22.
//

import Foundation
import UIKit

protocol TableViewCellViewModelType: AnyObject {
    var result: String { get }
    var currencyNameTo: String { get }
    var image: UIImage? { get }
}
