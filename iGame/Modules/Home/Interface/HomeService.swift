//
//  HomeService.swift
//  iGame
//
//  Created by Fauzi Achmad B D on 15/08/23.
//

import Foundation

protocol HomeServiceable {
    func getGames() async -> Result<GameList, RequestError>
    func getGames(page: Int) async -> Result<GameList, RequestError>
}

protocol GameDetailServiceable {
    func getGameById(_ id: Int) async -> Result<Game, RequestError>
}

enum HomeEndpoint {
    case getGames
    case getGamesPage(Int)
    case getGameById(Int)
}

extension HomeEndpoint: Endpoint {
    var path: String {
        switch self {
        case .getGames, .getGamesPage: return "/api/games"
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
        case .getGames:
            return [
                URLQueryItem(name: "page", value: "1"),
                URLQueryItem(name: "page_size", value: "10"),
                URLQueryItem(name: "key", value: "d2f1740082ac4bfc8e0ad4f1ed969196")
            ]
        case let .getGamesPage(page):
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
