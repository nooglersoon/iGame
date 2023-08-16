//
//  HomeViewModel.swift
//  iGame
//
//  Created by Fauzi Achmad B D on 16/08/23.
//

import Foundation
import CoreData

class FavoritesViewModel {
    
    @Published var isRequestInFlight: Bool = false
    @Published var currentPage: Int = 0
    @Published var items: [HomeViewCellModel] = [
        HomeViewCellModel(item: nil),
        HomeViewCellModel(item: nil),
        HomeViewCellModel(item: nil)
    ]
    
    var totalItems: Int {
        items.count
    }
    
    let viewContext: NSManagedObjectContext
    
    init(
        viewContext: NSManagedObjectContext = PersistenceManager.shared.container.viewContext
    ) {
        self.viewContext = viewContext
    }
    
    func fetchData() async {
        
        // Create a fetch request for the "Game" entity
        let fetchRequest: NSFetchRequest<GameModel> = GameModel.fetchRequest()
        
        do {
            // Fetch the data using the fetch request
            let context = viewContext
            let fetchedItems = try context.fetch(fetchRequest)
            
            
            items =  fetchedItems.map({ game in
                return .init(
                    item: .init(
                        title: game.name ?? "",
                        releaseDate: game.released ?? "",
                        rating: game.rating,
                        imageUrl: game.imageUrl ?? ""),
                    isLoading: false,
                    gameId: Int(game.id))
            })
            
        } catch {
            print("Error fetching data: \(error)")
        }
    }
    
    private func updateItems(isFirstLoad: Bool, newItems: [HomeViewCellModel]) {
        if isFirstLoad {
            items = newItems
        } else {
            items += newItems
        }
    }
    
}
