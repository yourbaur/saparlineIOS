//
//  LanguageCenter.swift
//  Helper
//
//  Created by Tuigynbekov Yelzhan on 12/13/19.
//  Copyright © 2019 Yelzhan Tuigynbekov. All rights reserved.
//

import Foundation

class LanguageCenter {
    
    static let standard = LanguageCenter()
    private init() {}
    let key = "language"
    
    func getLanguage() -> String? {
        return UserDefaults.standard.string(forKey: key)
    }
    
    func setLanguageCustomer(language: String) -> Void {
        DispatchQueue.main.async {
            UserDefaults.standard.setValue(language, forKey: self.key)
            UserDefaults.standard.synchronize()
            AppCenter.shared.startCustomer()
        }
    }
    
    func setLanguageDriver(language: String) -> Void {
        DispatchQueue.main.async {
            UserDefaults.standard.setValue(language, forKey: self.key)
            UserDefaults.standard.synchronize()
            AppCenter.shared.startDriver()
        }
    }
}
