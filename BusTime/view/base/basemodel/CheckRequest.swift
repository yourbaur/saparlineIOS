//
//  CheckRequest.swift
//  LTGas
//
//  Created by Tuigynbekov Yelzhan on 2/11/20.
//  Copyright © 2020 Tuigynbekov Yelzhan. All rights reserved.
//

import Foundation

struct CheckRequest: Codable {
    let orderId:Int?
    
    struct ResultObj<T: Decodable>: Decodable {
        let result: T
        
    }
}
