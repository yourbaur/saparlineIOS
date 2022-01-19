//
//  MyTicketsModel.swift
//  SaparLine
//
//  Created by Rustem Madigassymov on 11/20/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import Foundation

struct MyTicketsModel: Codable {
    var id: Int?
    var number: Int?
    var price: Int?
    var status: String?
    var departure_time: String?
    var destination_time: String?
    var from_city: String?
    var from_station: String?
    var to_city: String?
    var to_station: String?
    var car_state_number: String?
    var car_type: String?
    var car_type_count_places: Int?
    var first_name: String?
    var phone: String?
    var iin: String?
    
    mutating func configure(model: MyTicketsModel) {
        self.id = model.id
        self.price = model.price
        self.status = model.status
        self.departure_time = model.departure_time
        self.destination_time = model.destination_time
        self.from_city = model.from_city
        self.to_city = model.to_city
        self.from_station = model.from_station
        self.to_station = model.to_station
        self.car_state_number = model.car_state_number
        self.car_type = model.car_type
        self.car_type_count_places = model.car_type_count_places
        self.first_name = model.first_name
        self.phone = model.phone
        self.iin = model.iin
    }
}
