//
//  Endpoint.swift
//  iGame
//
//  Created by Fauzi Achmad B D on 16/08/23.
//

import Foundation

enum MainEndpoint {
    case getGames(Int)
    case getGameById(Int)
}

extension MainEndpoint: Endpoint {
    var path: String {
        switch self {
        case .getGames: return "/api/games"
        case let .getGameById(id): return "/api/games/\(id)"
        }
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var header: [String : String]? {
        nil
    }
    
    var body: [String : Any]? {
        nil
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case let .getGames(page):
            return [
                URLQueryItem(name: "page", value: "\(page)"),
                URLQueryItem(name: "page_size", value: "10"),
                URLQueryItem(name: "key", value: "d2f1740082ac4bfc8e0ad4f1ed969196")
            ]
        case .getGameById:
            return [
                URLQueryItem(name: "key", value: "d2f1740082ac4bfc8e0ad4f1ed969196")
            ]
        }
    }    
}
