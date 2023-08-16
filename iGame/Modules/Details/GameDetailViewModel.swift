//
//  GameDetailViewModel.swift
//  iGame
//
//  Created by Fauzi Achmad B D on 16/08/23.
//

import Foundation

class GameDetailViewModel {
    
    @Published var game: Game?
    
    let service: GameDetailServiceable
    
    init(service: GameDetailServiceable = NetworkService.shared) {
        self.service = service
    }
    
    func fetchData(id: Int) async {
        
        Task {
            let results = await service.getGameById(id)
            switch results {
            case .success(let game):
                self.game = game
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
}
