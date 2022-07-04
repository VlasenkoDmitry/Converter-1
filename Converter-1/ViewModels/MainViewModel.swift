//
//  MainViewModel.swift
//  Converter-1
//
//  Created by Ap on 6.06.22.
//

import Foundation
import UIKit

class MainViewModel: TableViewModelType {
    
    let editableAmount: Bindable<String?> = Bindable("0")
    private let networkManager = NetworkManager()
    private let dispatchGroup = DispatchGroup()
    private var arrayConversionData: [ConversionData]?
    
    func conversion(amount: String, from: String, to: [String], completion: @escaping()->()) {
        arrayConversionData = []
        for element in to {
            arrayConversionData?.append(ConversionData(amount: amount, from: from, to: element, result: nil, image: nil))
        }
        for currency in to {
            downloadResult(amount: amount, from: from, to: currency)
            downloadImageData(amount: amount, from: from, to: currency)
        }
        dispatchGroup.wait()
        dispatchGroup.notify(queue: .main) {
            completion()
        }
    }
    
    private func downloadResult(amount: String, from: String, to: String) {
        dispatchGroup.enter()
        DispatchQueue.global(qos: .utility).async {
            
            self.networkManager.getRequestConversion(amount: amount, from: from, to: to) { [weak self] resultFromRequest in
                if let resultFromRequest = resultFromRequest {
                    if let firstNegative = self?.arrayConversionData?.first(where: { $0.getToCurrence() == resultFromRequest.getToCurrence() }) {
                        firstNegative.setResult(result: resultFromRequest.getResult())
                    }
                }
                self?.dispatchGroup.leave()
            }
        }
    }
    
    private func downloadImageData(amount: String?, from: String?, to: String?) {
        dispatchGroup.enter() // +1
        DispatchQueue.global(qos: .utility).async {
            self.networkManager.fakeDownloadImage(url: URL(string: "www....")!) { [weak self] imageData in
                if let imageData = imageData {
                    if let firstNegative = self?.arrayConversionData?.first(where: { $0.getToCurrence() == to }) {
                        firstNegative.setImage(image: UIImage(data: imageData))
                    }
                    self?.dispatchGroup.leave()
                }
            }
        }
    }
    
    
    /// to find out how many rows there will be in the tableview
    func getNumberOfRows() -> Int {
        return arrayConversionData?.count ?? 2
    }
    
    /// creating separate viewModels for each cell of tableView
    func getCellViewModel(indexPath: IndexPath) -> TableViewCellViewModelType? {
        guard let array = arrayConversionData else { return nil }
        return TableViewCellViewModel(result: array[indexPath.row])
    }
}
