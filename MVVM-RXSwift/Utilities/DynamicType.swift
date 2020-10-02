//
//  DynamicType.swift
//  MVVM-RXSwift
//
//  Created by Nitkarsh Gupta on 02/10/20.
//

import Foundation

class DynamicType<T> {
    typealias Listener = (T) -> ()
    var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    func bind(listener: @escaping Listener) {
        self.listener = listener
        listener(value)
    }
    
    init(_ value: T) {
        self.value = value
    }
}
