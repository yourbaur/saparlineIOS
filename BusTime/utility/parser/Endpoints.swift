//
//  Endpoints.swift
//  Helper
//
//  Created by Tuigynbekov Yelzhan on 11/21/19.
//  Copyright © 2019 Yelzhan Tuigynbekov. All rights reserved.
//

import Foundation
enum Endpoints: EndpointType {

    case get(url: String, parameters: Parameters?, token: String?)
    case post(url: String, parameters: Parameters?, token: String?)
    case multipartFormData(url: String, parameters: Parameters?, token: String?)
    case deleteRequest(url: String, parameters: Parameters?, token: String?)

    var baseUrl: URL {
        return URL(string: "http://194.4.56.241:8888/api/v1/")!
    }

    var path: String {
        switch self {
        case .get(let url, _, _):
            return url
        case .post(let url, _, _):
            return url
        case .multipartFormData(let url, _, _):
            return url
        case .deleteRequest(let url,_, _):
            return url
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .post(_, _, _):
            return .post
        case .multipartFormData(_, _, _):
            return .post
        case .deleteRequest(_, _, _):
            return .delete
        default:
            return .get
        }
    }

    var task: HTTPTask {
        switch self {
        case .get(_, let parameters, let token):
            var urlParameters: Parameters = [:]
            var headers: HTTPHeaders = [:]
            if let params = parameters {
                urlParameters = params
            }
            if let token = token {
                headers["token"] = token
            }
            return .requestParametersAndHeaders(bodyParameters: nil, urlParameters: urlParameters, additionalHeaders: headers)
        case .post(_, let parameters, let token):
            var bodyParameters: Parameters = [:]
            var headers: HTTPHeaders = [:]
            if let params = parameters {
                bodyParameters = params
            }
            if let token = token {
                headers["token"] = token
            }
            return .requestParametersAndHeaders(bodyParameters: bodyParameters, urlParameters: nil, additionalHeaders: headers)
        case let .multipartFormData(_, parameters, token):
            var bodyParameters: Parameters = [:]
            var headers: HTTPHeaders = [:]
            if let params = parameters {
                bodyParameters = params
            }
            if let token = token {
                headers["token"] = token
            }
            return .multipartFormData(bodyParameters: bodyParameters, urlParameters: nil, additionalHeader: headers)
        case let .deleteRequest(_, parameters, token):
            var bodyParameters: Parameters = [:]
            var headers: HTTPHeaders = [:]
            if let params = parameters {
                bodyParameters = params
            }
            if let token = token {
                headers["token"] = token
            }
            return .requestParametersAndHeaders(bodyParameters: bodyParameters, urlParameters: nil, additionalHeaders: headers)
        }
    }
}
