//
//  Listeners.swift
//  MVVM-RXSwift
//
//  Created by Nitkarsh Gupta on 27/09/20.
//

import Foundation

typealias ActionHandler = (Actions) -> Void

enum Actions {
    case reloadTable
}
