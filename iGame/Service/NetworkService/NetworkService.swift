//
//  NetworkService.swift
//  iGame
//
//  Created by Fauzi Achmad B D on 15/08/23.
//

import Foundation

class NetworkService: HTTPClient {
    
    static let shared = NetworkService()
    
    private init () {}
    
}

extension NetworkService: HomeServiceable, GameDetailServiceable {
 
    func getGames(page: Int) async -> Result<GameList, RequestError> {
        return await sendRequest(endpoint: MainEndpoint.getGames(page), responseModel: GameList.self)
    }
    
    func getGameById(_ id: Int) async -> Result<Game, RequestError> {
        return await sendRequest(endpoint: MainEndpoint.getGameById(id), responseModel: Game.self)
    }
    
}
