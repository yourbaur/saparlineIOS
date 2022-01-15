//
//  TravelListModel.swift
//  BusTime
//
//  Created by greetgo on 9/15/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import Foundation

struct TravelListModel: Codable {
    let count: Int?
    let pages: Int?
    let offset: Int?
    let limit: String?
    let page: Int?
    let data: [TravelList]?
}

struct TravelList: Codable {
    let id: Int
    let departure_time: String
    let destination_time: String
    let car: CarModel
    let from: PlaceModel?
    let to: PlaceModel?
    let min_price: Int?
    let max_price: Int?
    let count_free_places: Int?
    let stations: [StationsModel2]?
}

struct CarModel: Codable {
    let id: Int
    let user_id: Int
    let state_number: String
    let car_type_id: Int
    let image: String?
    let image1:String?
    let image2:String?
    let tv: Int
    let conditioner: Int
    let baggage: Int
    let name: String?
    let rating:Double?
    let phone:String?
    let avatar:String?
    let bank_card: String?
}

struct PlaceModel: Codable {
    let city_id: Int?
    let city: String
    let station_id: Int?
    let station: String
    let lat: String
    let lng: String
}
