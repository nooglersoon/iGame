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
    let item: Game?
    
    init(item: Game?, isLoading: Bool = true) {
        self.id = UUID()
        self.item = item
        self.isLoading = isLoading
    }
    
    static func == (lhs: HomeViewCellModel, rhs: HomeViewCellModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}
