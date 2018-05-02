//
//  RestApiService.swift
//  Zcale
//
//  Created by Andrew Rolya on 1/30/18.
//  Copyright © 2018 Andrew Rolya. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

typealias RestApiBaseMapClosure = (BaseMapResponse?, Error?)->(Void)

class RestApiResponseSubError {
    var domain: String?
    var reason: String?
    var message: String?
    
    required init?(map: Map) {
        
    }
}

extension RestApiResponseSubError: Mappable {
    func mapping(map: Map) {
        domain <- map[RestApiResponseErrorKey.domain.rawValue]
        reason <- map[RestApiResponseErrorKey.reason.rawValue]
        message <- map[RestApiResponseErrorKey.message.rawValue]
    }
}

enum RestApiResponseErrorKey : String {
    case error = "error"
    case code = "code"
    case message = "message"
    case errors = "errors"
    case domain = "domain"
    case reason = "reason"
}

enum RestApiResponseKey: String {
    case error = "error"
    case data = "data"
}

class RestApiResponseError {
    var code: Int?
    var message: String?
    var errors: [RestApiResponseSubError]?
    
    var error: Error {
        return RestApiError.serverError(self)
    }
    
    required init?(map: Map) {
        
    }
}

class BaseMapResponse: Mappable {
    var error: RestApiResponseError?
    //var data: T?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        error <- map[RestApiResponseKey.error.rawValue]
        //data <- map[RestApiResponseKey.data.rawValue]
    }
}

class RestApiService {
    
    fileprivate static let manager: SessionManager = {
        let certificates = ServerTrustPolicy.certificates()
        let serverTrustPolicy: ServerTrustPolicy = .pinCertificates(certificates: certificates, validateCertificateChain: true, validateHost: true)
        let serverTrustPolicies = [
                                    ServerDomain.production.rawValue : serverTrustPolicy,
                                ]
        
        return Alamofire.SessionManager.default
    }()
    
    @discardableResult
    func sendMappableRequest<T: Mappable>(_ request: URLRequest?, completion:((T?,Error?)->Void)?) -> DataRequest? {
        if let request = request {
            return RestApiService.manager.request(request).validate().responseObject { (response: DataResponse<T>) in
                completion?(response.result.value, response.error)
            }
        } else {
            completion?(nil, RestApiError.invalideAPIRequest)
            return nil
        }
    }
}

class BaseRestService {
    let restApiService = RestApiService()
}
