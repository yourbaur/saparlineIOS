//
//  LoginViewModel.swift
//  BusTime
//
//  Created by greetgo on 9/3/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import Foundation
class LoginViewModel: ViewModelConfigurable {
    
    var errorMessage: String = "Заполните поля"
    var parameters  : Parameters = [:]

    var phone: String = String()
    var password: String = String()

    func setPhone(_ phone: String) -> Void {
        let text = phone
        let phoneNumber = String(text.suffix(text.count-2)).replacingOccurrences(of: " ", with: "")
        self.phone = phoneNumber
    }
    
    func setPassword(_ password: String) -> Void {
        self.password = password
    }

    func isValid() -> Bool {
        guard phone    != "" else { errorMessage = "Введите номер телефона"; return false}
        guard password != "" else { errorMessage = "Введите пароль"; return false}
        return true
    }

    func getParameters() -> Parameters? {
        guard isValid() else {return nil}
        parameters["phone"]        = phone
        parameters["password"]     = password
        parameters["device_type"]  = "ios"
        parameters["device_token"] = AppDelegate.deviceToken
        return parameters
    }
}
