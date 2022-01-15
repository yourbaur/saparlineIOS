//
//  PolicyModel.swift
//  SaparLine
//
//  Created by Rustem Madigassymov on 11/30/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import Foundation

struct PolicyModel: Codable {
    let id: Int
    let terms_of_use: String?
    let privacy_policy: String?
    let contact: String?
    let whatsapp: String?
}
