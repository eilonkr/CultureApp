//
//  CultureNetworkManager.swift
//  CultureApp
//
//  Created by Eilon Krauthammer on 22/03/2021.
//

import Foundation


struct CultureAPIManager {
    
    static func getArticles(then callback: @escaping (Result<[Article], Error>) -> Void) {
        CultureEndpoint.articles.make(expect: ResponseData.self) { result in
            switch result {
                case .success(let response):
                    callback(.success(response.data))
                case .failure(let error):
                    callback(.failure(error))
            }
        }
    }
    
}
