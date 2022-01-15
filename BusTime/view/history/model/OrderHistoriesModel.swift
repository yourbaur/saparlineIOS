//
//  OrderHistoriesModel.swift
//  BusTime
//
//  Created by greetgo on 9/16/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import Foundation

struct OrderHistoriesModel: Codable {
    let id: Int
    let number: Int
    let price: Int
    let status: String
    let departure_time: String
    let destination_time: String
    let from_city: String
    let from_station: String
    let to_city: String
    let to_station: String
    let car_state_number: String
    let car_type: String
    let created_at: String
}

//[
//    {
//        "id": 1,
//        "number": 1,
//        "price": 3500,
//        "status": "waiting_pay",
//        "departure_time": "2020-09-14 10:34:32",
//        "destination_time": "2020-09-08 10:34:32",
//        "from_city": "Алматы",
//        "from_station": "Сайран",
//        "to_city": "Тараз",
//        "to_station": "Автовогзал",
//        "car_state_number": "0366ss08",
//        "car_type": "Автобус"
//    }
//]
