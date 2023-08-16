//
//  NetworkService.swift
//  iGame
//
//  Created by Fauzi Achmad B D on 15/08/23.
//

import Foundation

class NetworkService: HTTPClient, HomeServiceable {
    
    static let shared = NetworkService()
    
    private init () {}
    
    func getGames() async -> Result<GameList, RequestError> {
        return await sendRequest(endpoint: HomeEndpoint.getGames, responseModel: GameList.self)
    }
    
}

extension NetworkService: GameDetailServiceable {
    
    func getGameById(_ id: Int) async -> Result<Game, RequestError> {
        return await sendRequest(endpoint: HomeEndpoint.getGameById(id), responseModel: Game.self)
    }
    
}
