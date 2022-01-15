//
//  Parser.swift
//  NetworkManager
//
//  Created by Yerassyl Zhassuzakhov on 4/30/19.
//  Copyright © 2019 Yerassyl Zhassuzakhov. All rights reserved.
//

import Foundation

public protocol Parser {
    func parse<T: Decodable>(data: Data?, response: URLResponse?, error: Error?) -> Result<T>
}

public class CustomParser: Parser {
    public init() {}
    
    public func parse<T>(data: Data?, response: URLResponse?, error: Error?) -> Result<T> where T : Decodable {
        if let error = error {
            return .failure(error.localizedDescription)
        }
        guard let response = response as? HTTPURLResponse else { return .failure("Response is not in HTTPResponse format") }
        switch response.statusCode {
        case 200...499:
            guard let data = data else { return .failure(NetworkResponse.noData.rawValue) }

            checkForJson(data)

            return decode(data: data)
        case 300...399:
            return .failure(NetworkResponse.redirect.rawValue)
        case 500...501:
            //guard let data = data else { return .failure(NetworkResponse.noData.rawValue) }
            //let error = String(data: data, encoding: .utf8)!
            //print("JSONSTRING:", error)
            return .failure(NetworkResponse.internalServerError.rawValue)
        case 600:
            return .failure(NetworkResponse.outdated.rawValue)
        default:
            return .failure(NetworkResponse.failed.rawValue)
        }
    }
    
    private func decode<T: Decodable>(data: Data) -> Result<T> {
        let decoder = JSONDecoder()
        do {
            let response = try decoder.decode(T.self, from: data)
            return Result.success(response)
        } catch {
            if let message = try? decoder.decode(String.self, from: data) {
                return Result.failure(message)
            }
            return Result.failure(error.localizedDescription)
        }
    }

    private func checkForJson(_ data: Data) -> Void {
        do {
            let error = String(data: data, encoding: .utf8)!
            print("JSONSTRING:", error)
            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            print(json)
        } catch {
            print("Error json: ", error.localizedDescription)
        }
    }
}
