//
//  HomeService.swift
//  iGame
//
//  Created by Fauzi Achmad B D on 15/08/23.
//

import Foundation

protocol HomeServiceable {
    func getGames(page: Int) async -> Result<GameList, RequestError>
}

protocol GameDetailServiceable {
    func getGameById(_ id: Int) async -> Result<Game, RequestError>
}
