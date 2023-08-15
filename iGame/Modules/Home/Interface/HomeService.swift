//
//  HomeService.swift
//  iGame
//
//  Created by Fauzi Achmad B D on 15/08/23.
//

import Foundation

protocol HomeServiceable {
    func getGames() async -> Result<GameList, RequestError>
}

enum HomeEndpoint {
    case getGames
}

extension HomeEndpoint: Endpoint {
    var path: String {
        switch self {
        case .getGames: return "/api/games"
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
        return [
            URLQueryItem(name: "page", value: "1"),
            URLQueryItem(name: "page_size", value: "10"),
            URLQueryItem(name: "key", value: "d2f1740082ac4bfc8e0ad4f1ed969196")
        ]
    }
    
}
