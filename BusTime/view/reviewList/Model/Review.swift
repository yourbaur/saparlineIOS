//
//  Review.swift
//  SaparLine
//
//  Created by Bauyrzhan on 12.03.2021.
//  Copyright © 2021 thousand.com. All rights reserved.
//

import Foundation

struct Review:Codable {
    let feedbackList: FeedbackList?
    let ratingInfo: [RatingInfo]?
}

struct FeedbackList: Codable {
    let current_page:Int?
    let data:[Feedback]?
    
}

struct Feedback:Codable {
    let name:String?
    let surname:String?
    let avatar:String?
    let text:String?
    let rating:Float?
    let criterion1:Float?
    let criterion2:Float?
    let criterion3:Float?
}

struct RatingInfo:Codable {
    let rating: Float?
    let criterion1: Float?
    let criterion2: Float?
    let criterion3: Float?
}
