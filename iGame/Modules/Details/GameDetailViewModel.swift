//
//  GameDetailViewModel.swift
//  iGame
//
//  Created by Fauzi Achmad B D on 16/08/23.
//

import Foundation
import CoreData

class GameDetailViewModel {
    
    @Published var game: Game?
    @Published var isFavorite: Bool = false
    
    private var gameModel: GameModel?
    
    let service: GameDetailServiceable
    let viewContext: NSManagedObjectContext
    
    init(
        service: GameDetailServiceable = NetworkService.shared,
        viewContext: NSManagedObjectContext = PersistenceManager.shared.container.viewContext
    ) {
        self.service = service
        self.viewContext = viewContext
    }
    
    func fetchData(id: Int) async {
        
        Task {
            let results = await service.getGameById(id)
            switch results {
            case .success(let game):
                self.game = game
                self.checkIfFavorite()
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    func checkIfFavorite() {
        
        guard
            let game,
            let id = game.id
        else { return }
        
        // Create a fetch request for the "Game" entity
        let fetchRequest: NSFetchRequest<GameModel> = GameModel.fetchRequest()

        // Set a predicate to filter based on the specific ID
        let idPredicate = NSPredicate(format: "id == %@", NSNumber(value: id))
        fetchRequest.predicate = idPredicate

        do {
            // Fetch the data using the fetch request
            let context = viewContext
            let fetchedItems = try context.fetch(fetchRequest)
            
            if let item = fetchedItems.first {
                self.gameModel = item
                self.isFavorite = true
            } else {
                print("Item with specific ID not found")
            }
        } catch {
            print("Error fetching data: \(error)")
        }
    }
    
    func toggleFavoritesButton() {
        
        guard
            let game
        else { return }
        
        if isFavorite {
            if let gameModel {
                viewContext.delete(gameModel)
            }
            isFavorite = false
        } else {
            let favoriteGame = GameModel(context: viewContext)
            favoriteGame.id = Int16(Int(game.id ?? 0))
            favoriteGame.name = game.name
            favoriteGame.released = game.released
            favoriteGame.rating = game.rating ?? 0.0
            favoriteGame.imageUrl = game.backgroundImage
            isFavorite = true
        }
        
        // Safely save the data to viewContext
        do {
            try viewContext.save()
        } catch {}
        
    }
    
}
