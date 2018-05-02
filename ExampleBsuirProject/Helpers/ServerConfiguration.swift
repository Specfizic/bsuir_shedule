//
//  ServerConfiguration.swift
//  Zcale
//
//  Created by Andrew Rolya on 1/30/18.
//  Copyright © 2018 Andrew Rolya. All rights reserved.
//

import UIKit

enum Environment {
    case Production
    
    func toString() -> String {
        switch self {
        case .Production: return "PRODUCTION"
        }
    }
}

enum ServerDomain: String {
    case production = "students.bsuir.by"
}

struct ServerConfiguration {
    static let environment = Environment.Production
    
    static var apiURL: String {
        switch environment {
        case .Production:
            return "https://\(ServerDomain.production.rawValue)"
        }
    }
    
    static var apiVersion: String {
        return "api/v1"
    }
    
    static var requestBaseURL: String {
        return ServerConfiguration.apiURL + "/" + ServerConfiguration.apiVersion + "/"
    }
}
