//
//  CulutreEndpoint.swift
//  CultureApp
//
//  Created by Eilon Krauthammer on 22/03/2021.
//

import Foundation

enum CultureEndpoint: Endpoint {
    case articles
    
    private var path: String {
        switch self {
            case .articles:
                return Constants.URL.baseURLPath + "home-assignment/response.json"
        }
    }
    
    public var url: URL {
        guard let url = URL(string: path) else {
            fatalError("Invalid URL constructed from \(path)")
        }
        return url
    }
}

extension CultureEndpoint: HTTPRequest {
    var endpoint: Endpoint { self }
    var method: HTTPMethod {
        switch self {
            case .articles:
                return .get
        }
    }
    
    var headers: [String : String] { [:] }
}
