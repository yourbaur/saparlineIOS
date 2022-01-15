
//  LTGas
//  Created by Tuigynbekov Yelzhan on 11/8/19.
//  Copyright © 2019 Yelzhan Tuigynbekov. All rights reserved.

import Foundation
class UserManager {
    
    // MARK: - properties
    static let shared = UserManager()
    private let userDefaults = UserDefaults.standard
    static let confirmId = "confirmId"
    
    // MARK: - keys
    private let userIdentifier = "userIdentifier"
    private init() {}
    
    
    // MARK: - create session
    func createSession(withUser user: User) {
        let encoder = JSONEncoder()
        if let userData = try? encoder.encode(user) {
            userDefaults.set(userData, forKey: userIdentifier)
            userDefaults.synchronize()
        } else {
            print("can't save user session")
        }
    }
    func getCurrentUser() -> User? {
        let decoder = JSONDecoder()
        if let data = userDefaults.data(forKey: userIdentifier) {
            if let user = try? decoder.decode(User.self, from: data) {
                return user
            }
        }
        return nil
    }
    
    func setConfirm(to confirm: Bool) {
        userDefaults.set(confirm, forKey: "confirmId")
    }
    func getConfirm() -> Bool? {
        return userDefaults.bool(forKey: "confirmId")
    }
    func setOrderId(to confirm: String) {
        userDefaults.set(confirm, forKey: "orderId")
    }
    func getOrderId() -> String? {
        return userDefaults.string(forKey: "orderId")
    }
    func setText(to confirm: String) {
        userDefaults.set(confirm, forKey: "textId")
    }
    func getText() -> String? {
        return userDefaults.string(forKey: "textId")
    }
    // MARK: - User type
    func setTypeUser(withArray type: String) {
        userDefaults.setValue(type, forKey: "typeUser")
    }
    func getTypeUser() -> String? {
        return userDefaults.string(forKey: "typeUser")
    }
    
    
    
    
    // MARK: - isSessionActive
    func isSessionActive() -> Bool {
        return getCurrentUser() != nil
    }
    func deleteCurrentSession() {
        userDefaults.set(nil, forKey: "typeUser")
        userDefaults.set(nil, forKey: userIdentifier)
        userDefaults.synchronize()
    }
}
