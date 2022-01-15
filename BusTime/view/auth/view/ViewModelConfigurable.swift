//
//  ViewModelConfigurable.swift
//  BusTime
//
//  Created by greetgo on 9/3/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import Foundation

protocol ViewModelConfigurable {
    var errorMessage: String {get set}
    var parameters: Parameters {get set}
    func getParameters() -> Parameters?
    func isValid() -> Bool
}
