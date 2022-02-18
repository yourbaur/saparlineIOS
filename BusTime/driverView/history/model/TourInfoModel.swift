//
//  TourInfoModel.swift
//  SaparLine
//
//  Created by Cheburek on 17.02.2022.
//  Copyright © 2022 thousand.com. All rights reserved.
//

import Foundation

struct TourInfoModel: Codable {
    let id: Int?
    let city_id: Int?
    let resting_place_id: Int?
    let meeting_place_id: Int?
    let car_id: Int?
    let title: String?
    let departure_time: String?
    let destination_time: String?
    let description: String?
    let tour_price: Int?
    let seat_price: Int?
    let created_at: String?
    let updated_at: String?
    let city: City?
    let resting_place: Rest?
    let meeting_place: Meeting?
    let car: Car?
    let images: [Images]?
}

struct City: Codable {
    let id: Int?
    let name: String?
}

struct Rest: Codable {
    let id: Int?
    let city_id: Int?
    let title: String?
    let description: String?
    let active: Int?
    let created_at: String?
    let updated_at: String?
}

struct Meeting: Codable {
    let id: Int?
    let city_id: Int?
    let title: String?
    let latitude: String?
    let longitude: String?
    let created_at: String?
    let updated_at: String?
}

struct Car: Codable {
    let id: Int?
    let user_id: Int?
    let state_number: String?
    let car_type_id: Int?
    let is_confirmed: Int?
    let image: String?
    let image1: String?
    let image2: String?
    let avatar: String?
    let rating: String?
    let criterion1: String?
    let criterion2: String?
    let criterion3: String?
    let passport_image: String?
    let passport_image_back: String?
    let identify_image: String?
    let identify_image_back: String?
    let tv: Int?
    let conditioner: Int?
    let baggage: Int?
}

struct Images: Codable {
    let id: Int?
    let tour_id: Int?
    let image: String?
    let created_at: String?
    let updated_at: String?
}
