//
//  HomeViewModel.swift
//  iGame
//
//  Created by Fauzi Achmad B D on 16/08/23.
//

import Foundation

class HomeViewModel {
    
    @Published var isRequestInFlight: Bool = false
    @Published var currentPage: Int = 0
    @Published var items: [CardCollectionViewCellModel] = [
        CardCollectionViewCellModel(item: nil),
        CardCollectionViewCellModel(item: nil),
        CardCollectionViewCellModel(item: nil)
    ]
    
    var totalItems: Int {
        items.count
    }
    
    let service: HomeServiceable
    
    init(service: HomeServiceable = NetworkService.shared) {
        self.service = service
    }
    
    func fetchData() async {
        
        guard !isRequestInFlight else { return }
        currentPage += 1
        isRequestInFlight = true
        
        let results = await service.getGames(page: currentPage)
        switch results {
        case .success(let lists):
            self.isRequestInFlight = false
            if let results = lists.results {
                let items: [CardCollectionViewCellModel] = results.map { item in
                    return .init(
                        item: .init(
                            title: item.name ?? "",
                            releaseDate: item.released ?? "",
                            rating: item.rating ?? 0,
                            imageUrl: item.backgroundImage ?? ""), gameId: item.id
                    )
                }
                updateItems(isFirstLoad: currentPage == 1, newItems: items)
            }
        default:
            updateItems(isFirstLoad: currentPage == 1, newItems: [])
            isRequestInFlight = false
            break
        }
    }
    
    func checkIfEnableFetchData(currentRow: Int) {
        guard
            !isRequestInFlight,
            totalItems > 3,
            totalItems - currentRow == 2
        else { return }
        Task {
            await fetchData()
        }
    }
    
    private func updateItems(isFirstLoad: Bool, newItems: [CardCollectionViewCellModel]) {
        if isFirstLoad {
            items = newItems
        } else {
            items += newItems
        }
    }
    
}
