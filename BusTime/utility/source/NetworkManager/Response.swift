//
//  GenericResponse.swift
//  Inviterkz
//
//  Created by Yerassyl Zhassuzakhov on 5/13/19.
//  Copyright © 2019 Yerassyl Zhassuzakhov. All rights reserved.
//

import Foundation

class Response<T: Decodable>: Decodable {
//    let status_code: Int
    let message: String
    let result: T?
}

class ResponseSocket<T: Decodable>: Decodable {
    let statusCode: Int
    let result: T?
}
