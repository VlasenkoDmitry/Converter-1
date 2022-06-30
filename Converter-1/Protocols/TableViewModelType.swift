//
//  TableViewModelType.swift
//  Converter-1
//
//  Created by Ap on 7.06.22.
//

import Foundation

protocol TableViewModelType {
    func getNumberOfRows() -> Int
    func getCellViewModel(indexPath: IndexPath) -> TableViewCellViewModelType?
}
