//
//  RegisterViewModel.swift
//  BusTime
//
//  Created by greetgo on 9/8/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import Foundation
class RegisterViewModel: ViewModelConfigurable {
    
    var errorMessage: String = "Заполните поля"
    var parameters  : Parameters = [:]

    var phone: String = String()
    var password: String = String()
    var role: String = String()

    func setPhone(_ phone: String) -> Void {
        let text = phone
        let phoneNumber = String(text.suffix(text.count-2)).replacingOccurrences(of: " ", with: "")
        self.phone = phoneNumber
    }
    
    func setPassword(_ password: String) -> Void {
        self.password = password
    }
    
    func setRole(_ role: String) -> Void {
        self.role = role
    }

    func isValid() -> Bool {
        guard phone    != "" else { errorMessage = "Введите номер телефона"; return false}
        guard password != "" else { errorMessage = "Введите пароль"; return false}
        guard role     != "" else { errorMessage = "Выберите амплуа"; return false}
        return true
    }

    func getParameters() -> Parameters? {
        guard isValid() else {return nil}
        parameters["phone"]        = phone
        parameters["password"]     = password
        parameters["role"]         = role
        return parameters
    }
}
