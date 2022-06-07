//
//  Box.swift
//  MVVM-2
//
//  Created by Ivan Akulov on 15/05/2018.
//  Copyright © 2018 Ivan Akulov. All rights reserved.
//

import Foundation

class Bindable<T> {
    typealias Listener = (T) -> Void
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    private var listener: Listener?
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
