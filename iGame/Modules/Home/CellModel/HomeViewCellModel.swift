//
//  HomeViewCellModel.swift
//  iGame
//
//  Created by Fauzi Achmad B D on 15/08/23.
//

import Foundation

struct HomeViewCellModel: Hashable {
    
    let id: UUID
    let isLoading: Bool
    let gameId: Int?
    let item: GameCardCellModel?
    
    init(item: GameCardCellModel?, isLoading: Bool = true, gameId: Int? = nil) {
        self.id = UUID()
        self.item = item
        self.isLoading = isLoading
        self.gameId = gameId
    }
    
    static func == (lhs: HomeViewCellModel, rhs: HomeViewCellModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}

extension Array where Element == HomeViewCellModel {
    static func createPlaceholders() -> [HomeViewCellModel] {
        return [
            HomeViewCellModel(item: nil),
            HomeViewCellModel(item: nil),
            HomeViewCellModel(item: nil)
        ]
    }
    
    static func createMock() -> [HomeViewCellModel] {
        return [
            .init(item: .init(title: "Test", releaseDate: "2023-12-10", rating: 5.0, imageUrl: "test image")),
            .init(item: .init(title: "Test", releaseDate: "2023-12-10", rating: 5.0, imageUrl: "test image")),
            .init(item: .init(title: "Test", releaseDate: "2023-12-10", rating: 5.0, imageUrl: "test image"))
        ]
    }
}
