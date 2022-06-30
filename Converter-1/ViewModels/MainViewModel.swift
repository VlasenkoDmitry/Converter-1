//
//  MainViewModel.swift
//  Converter-1
//
//  Created by Ap on 6.06.22.
//

import Foundation
import UIKit

class MainViewModel: TableViewModelType {
    
    var editableAmount: Bindable<String?> = Bindable("0")
    var networkManager = NetworkManager()
    var arrayConversionData: [ConversionData]?
    
    func conversion(amount: String, from: String, to: [String], completion: @escaping()->()) {
        /// cleaning the array to protect against old information
        arrayConversionData = []
        for element in to {
            arrayConversionData?.append(ConversionData(amount: amount, from: from, to: element, result: nil, image: nil))
        }
        
        /// grouping the download to synchronize its display on the screen
        let dispatchGroup = DispatchGroup()
        for element in to {
            
            ///download result
            dispatchGroup.enter() // +1
            DispatchQueue.global(qos: .utility).async {
                
                self.networkManager.getRequestConversion(amount: amount, from: from, to: element) { [weak self] resultFromRequest in
                    if let resultFromRequest = resultFromRequest {
                        if let firstNegative = self?.arrayConversionData?.first(where: { $0.to == resultFromRequest.to }) {
                            firstNegative.result = resultFromRequest.result
                        }
                    }
                    dispatchGroup.leave()
                }
            }
            
            ///download imageData
            dispatchGroup.enter() // +1
            DispatchQueue.global(qos: .utility).async {
                self.networkManager.dowmloadImage(url: URL(string: "www....")!) { [element] imageData in
                    if let imageData = imageData {
                        if let firstNegative = self.arrayConversionData?.first(where: { $0.to == element }) {
                            firstNegative.image = UIImage(data: imageData)
                        }
                        dispatchGroup.leave()
                    }
                }
            }
        }

        dispatchGroup.wait()
        
        ///working after download all results and imagesData
        dispatchGroup.notify(queue: .main) {
            completion()
        }
    }
    
    /// counting the number of arrayConversion Data to find out how many rows there will be in the tableview
    func getNumberOfRows() -> Int {
        return arrayConversionData?.count ?? 2
    }
    
    /// creating separate viewModels for each cell of tableView
    func getCellViewModel(indexPath: IndexPath) -> TableViewCellViewModelType? {
        guard let array = arrayConversionData else { return nil }
        return TableViewCellViewModel(result: array[indexPath.row])
    }
}
