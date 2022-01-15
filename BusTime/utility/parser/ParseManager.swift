
//  JTI
//  Created by Nursultan on 10/17/19.
//  Copyright © 2019 Nursultan. All rights reserved.

import Foundation
class ParseManager {

    static let shared = ParseManager()
    let networkManager: NetworkManager = Router(parser: CustomParser())
    private init() {}

    func multipartFormData<T: Decodable>(url: String, parameters: Parameters? = nil, completion: @escaping (T?, String?) -> ()) -> Void {
        let token = UserManager.shared.getCurrentUser()?.token
        print("LOG: ", parameters as Any, token as Any)

        let endpoint = Endpoints.multipartFormData(url: url, parameters: parameters, token: token)
        let dispatch = DispatchQueue.global(qos: .utility)

        dispatch.async {
            self.networkManager.request(endpoint) { (result: Result<T>) in
                switch result {
                case .failure(let error):
                    DispatchQueue.main.async {
                        if error == "Could not connect to the server." || error == "The Internet connection appears to be offline."{
                                AppCenter.shared.startNoInternet()
                            DispatchQueue.main.async {
                                completion(nil, error)
                            }
                        }
                        else {
                            completion(nil, error)
                        }
                        
                    }
                case .success(let value):
                    DispatchQueue.main.async {
                        completion(value, nil)
                    }
                }
            }
        }
    }

    func postRequest<T: Decodable>(url: String, parameters: Parameters? = nil, completion: @escaping (T?, String?) -> ()) -> Void {
        let token = UserManager.shared.getCurrentUser()?.token
        print("LOG: ", parameters as Any, token as Any)

        let endpoint = Endpoints.post(url: url, parameters: parameters, token: token)
        let dispatch = DispatchQueue.global(qos: .utility)

        dispatch.async {
            self.networkManager.request(endpoint) { (result: Result<T>) in
                switch result {
                case .success(let value):
                    DispatchQueue.main.async {
                        completion(value, nil)
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        if error == "Could not connect to the server." || error == "The Internet connection appears to be offline."{
                                AppCenter.shared.startNoInternet()
                            DispatchQueue.main.async {
                                completion(nil, error)
                            }
                        }
                        else {
                            completion(nil, error)
                        }
                        
                    }
                }
            }
        }
    }

    func getRequest<T: Decodable>(url: String, parameters: Parameters? = nil, completion: @escaping (T?, String?) -> ()) -> Void {
        let token = UserManager.shared.getCurrentUser()?.token
        print("LOG: ", parameters as Any, token as Any)

        let endpoint = Endpoints.get(url: url, parameters: parameters, token: token)
        let dispatch = DispatchQueue.global(qos: .utility)

        dispatch.async {
            self.networkManager.request(endpoint) { (result: Result<T>) in
                switch result {
                case .failure(let error):
                    DispatchQueue.main.async {
                        if error == "Could not connect to the server." || error == "The Internet connection appears to be offline."{
                                AppCenter.shared.startNoInternet()
                            DispatchQueue.main.async {
                                completion(nil, error)
                            }
                        }
                        else {
                            completion(nil, error)
                        }
                        
                    }
                case .success(let value):
                    DispatchQueue.main.async {
                        completion(value, nil)
                    }
                }
            }
        }
    }
    
    func deleteRequest<T: Decodable>(url: String, parameters: Parameters? = nil, completion: @escaping (T?, String?) -> ()) -> Void {
        
        let token = UserManager.shared.getCurrentUser()?.token
        print("LOG: ", parameters as Any, token as Any)

        let endpoint = Endpoints.deleteRequest(url: url, parameters: parameters, token: token)
        let dispatch = DispatchQueue.global(qos: .utility)

        dispatch.async {
            self.networkManager.request(endpoint) { (result: Result<T>) in
                switch result {
                case .failure(let error):
                    DispatchQueue.main.async {
                        if error == "Could not connect to the server." || error == "The Internet connection appears to be offline."{
                                AppCenter.shared.startNoInternet()
                            DispatchQueue.main.async {
                                completion(nil, error)
                            
                            }
                        }
                        else {
                            completion(nil, error)
                        }
                        
                    }
                case .success(let value):
                    DispatchQueue.main.async {
                        completion(value, nil)
                    }
                }
            }
        }
    }
}
