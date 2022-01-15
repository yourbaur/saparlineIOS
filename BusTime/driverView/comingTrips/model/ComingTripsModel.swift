//
//  ComingTripsModel.swift
//  BusTime
//
//  Created by greetgo on 10/23/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import Foundation

struct ComingTripsModel: Codable {
    let id: Int
    let departure_time: String
    let destination_time: String
    let car: CarModel
    let from: ComingTripsCityModel
    let to: ComingTripsCityModel
    let min_price: Int?
    let max_price: Int?
    let count_free_places: Int?
    let created_at: String?
}
struct ComingTripsCityModel: Codable {
    let city_id: Int
    let city: String
    let station_id: Int
    let station: String
}
