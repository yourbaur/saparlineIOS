//
//  StationsModel.swift
//  BusTime
//
//  Created by greetgo on 10/6/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import Foundation

struct StationsModel: Codable {
    let id: Int
    let name: String
    let city_id: Int
}


struct StationsModel2: Codable {
    //let id: Int?
    let stations: String?
    let station_id: Int?
}
