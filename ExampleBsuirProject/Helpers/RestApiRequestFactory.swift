//
//  RestApiRequestFactory.swift
//  Zcale
//
//  Created by Andrew Rolya on 1/30/18.
//  Copyright © 2018 Andrew Rolya. All rights reserved.
//

import Foundation
import Alamofire

public enum RestApiRequestFactory: URLRequestConvertible {
    case requestSheduleGroup(String)
    
    public func asURLRequest() throws -> URLRequest {
        let requestTupple: (path: String, method: Alamofire.HTTPMethod, parametersEncoding: ParameterEncoding , parameters: [String: Any]?, requestHeaders: [String: String]?, baseURL: String) = {
            switch self {
            case .requestSheduleGroup(let groupName):
                let url = "studentGroup/schedule"
                let params: [String : Any] = ["studentGroup" : groupName]
                return (url, .get, Alamofire.URLEncoding.default, params, nil, ServerConfiguration.requestBaseURL)
            }
        }()
        
        guard let url = NSURL(string: requestTupple.baseURL)?.appendingPathComponent(requestTupple.path) else {
            throw RestApiError.invalideAPIRequest
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = requestTupple.method.rawValue
        
        if let requestHeaders = requestTupple.requestHeaders {
            for (field, value) in requestHeaders {
                urlRequest.addValue(value, forHTTPHeaderField: field)
            }
        }
        
        return try requestTupple.parametersEncoding.encode(urlRequest, with: requestTupple.parameters)
    }
}

