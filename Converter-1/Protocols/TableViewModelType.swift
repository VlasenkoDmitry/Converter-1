//
//  TableViewModelType.swift
//  Converter-1
//
//  Created by Ap on 7.06.22.
//

import Foundation

protocol TableViewModelType {
    func numberOfRows() -> Int
    func cellViewModel(indexPath: IndexPath) -> TableViewCellViewModelType?
}
