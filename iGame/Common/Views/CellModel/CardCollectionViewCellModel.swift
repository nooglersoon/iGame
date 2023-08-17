//
//  CardCollectionViewCellModel.swift
//  iGame
//
//  Created by Fauzi Achmad B D on 15/08/23.
//

import Foundation

struct CardCollectionViewCellModel: Hashable {
    
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
    
    static func == (lhs: CardCollectionViewCellModel, rhs: CardCollectionViewCellModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}

extension Array where Element == CardCollectionViewCellModel {
    static func createPlaceholders() -> [CardCollectionViewCellModel] {
        return [
            CardCollectionViewCellModel(item: nil),
            CardCollectionViewCellModel(item: nil),
            CardCollectionViewCellModel(item: nil)
        ]
    }
    
    static func createMock() -> [CardCollectionViewCellModel] {
        return [
            .init(item: .init(title: "Test", releaseDate: "2023-12-10", rating: 5.0, imageUrl: "test image")),
            .init(item: .init(title: "Test", releaseDate: "2023-12-10", rating: 5.0, imageUrl: "test image")),
            .init(item: .init(title: "Test", releaseDate: "2023-12-10", rating: 5.0, imageUrl: "test image"))
        ]
    }
}
