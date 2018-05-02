//
//  RestApiError.swift
//  Zcale
//
//  Created by Andrew Rolya on 1/30/18.
//  Copyright © 2018 Andrew Rolya. All rights reserved.
//

import Foundation

enum RestApiResponseSubErrorDomain: String {
    case phoneNumber = "phoneNumber"
    case regCode = "regCode"
}

enum RestApiResponseSubErrorMessage: String {
    case notFound = "NOT_FOUND"
    case wrongRegCode = "WRONG_REG_CODE"
    case wrongAccessRegistration = "WRONG_ACCESS_REGISTRATION"
    case wrongAcsessMaxAttempts = "WRONG_ACCESS_MAX_ATTEMPTS"
}

enum RestApiError: Error {
    case invalideAPIRequest
    case invalideResponse
    case serverError(RestApiResponseError)
    case unspecified
    
    fileprivate func errorDescription(_ error: RestApiResponseError) -> String {
        guard let subError = error.errors?.first, let subErrorDescription = subErrorDescription(subError) else {
            guard let code = error.code, let message = error.message else {
                return "L10n.invalidRequest.string"
            }
            return "\(code) \(message)"
        }
        
        return subErrorDescription
    }
    
    fileprivate func subErrorDescription(_ subError: RestApiResponseSubError) -> String? {
        guard let message = subError.message, let subErrorMessage = RestApiResponseSubErrorMessage(rawValue: message) else {
            return nil
        }
        
        switch subErrorMessage {
        case .notFound:
            return "L10n.invalidRequest.string"
        case .wrongRegCode:
            return "L10n.invalidSmsCode.string"
        case .wrongAccessRegistration:
            return "L10n.errorWrongAccessRegistration.string"
        case .wrongAcsessMaxAttempts:
            return "L10n.errorWrongAccessMaxAttempts.string"
        }
    }
    
}

extension RestApiError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalideAPIRequest:
            return "L10n.invalidRequest.string"
        case .unspecified:
            return "L10n.unspecifiedError.string"
        case .serverError(let response):
            return errorDescription(response)
        case .invalideResponse:
            return "L10n.invalidResponse.string"
        }
    }
}
