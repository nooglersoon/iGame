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
