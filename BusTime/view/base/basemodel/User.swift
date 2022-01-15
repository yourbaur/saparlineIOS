//
//  User.swift
//  LTGas
//
//  Created by Tuigynbekov Yelzhan on 2/8/20.
//  Copyright © 2020 Tuigynbekov Yelzhan. All rights reserved.
//

import Foundation

struct User: Codable {
    let token: String
    let user: UserDetail?
}

struct UserDetail: Codable {
    let id: Int
    let role: String
    let name: String?
    let surname: String?
    let phone: String
    let avatar: String?
    let sound: Int?
    let lang: String?
    let push: Int?
    let passport_image: String?
    let identity_image: String?
    let car: UserCar?
    let confirmation: String?
}
struct Whatsapp:Codable {
    let whatsapp:String?
}

struct UserCar: Codable {
    let id: Int
    let user_id: Int
    let state_number: String
    let car_type_id: Int
    let image: String?
    let tv: Int
    let conditioner: Int
    let baggage: Int
    let type: String
    let count_places: Int
}
