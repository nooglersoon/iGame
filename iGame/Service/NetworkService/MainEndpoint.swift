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
                URLQueryItem(name: "key", value: apiKey)
            ]
        case .getGameById:
            return [
                URLQueryItem(name: "key", value: apiKey)
            ]
        }
    }
    
    var apiKey: String {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "apiKey") as? String else {
            return ""
        }
        return apiKey
    }
    
}
