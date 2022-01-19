//
//  TravelShowModel.swift
//  BusTime
//
//  Created by greetgo on 9/17/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import Foundation

struct TravelShowModel: Codable {
    let travel: TravelList?
    let places: [PlacesModel]?
}

struct PlacesModel: Codable {
    let id: Int
    let driver: DriverDetailModel
    let passenger: DriverDetailModel?
    let car: CarModel
    let from: PlaceModel
    let to: PlaceModel
    let price: Int
    let booking_time: String?
    let status: String
    let number: Int
}
struct PassengerModel: Codable {
    let id: Int
    let driver: DriverDetailModel
    let passenger: DriverDetailModel?
    let car: CarModel
    let from: PlaceModel
    let to: PlaceModel
    let price: Int?
    let booking_time: String?
    let status: String
    let number: [Int]
   
}
struct DriverDetailModel: Codable {
    let id: Int
    let name: String?
    let phone: String
    let avatar: String?
}

struct PassengerInfoModel {
    var seat: [String]?
    var iin: String?
    var name: String?
    var phone: String?
    var placeBack: [String]?
}
