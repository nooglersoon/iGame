//
//  MockNetworkService.swift
//  iGame
//
//  Created by Fauzi Achmad B D on 17/08/23.
//

import Foundation

// Mock HomeService for testing
class MockHomeService: HomeServiceable {
    var mockResult: Result<GameList, RequestError> = .success(MockData.mockGameList())

    var getGamesCalled = false
    
    func getGames(page: Int) async -> Result<GameList, RequestError> {
        getGamesCalled = true
        return mockResult
    }
}

// Mock GameDetailService for testing
class MockGameDetailService: GameDetailServiceable {
    var mockResult: Result<Game, RequestError> = .success(MockData.mockGame())

    var getGamesCalled = false
    var getGameByIdCalled = false
    
    func getGameById(_ id: Int) async -> Result<Game, RequestError> {
        getGameByIdCalled = true
        return mockResult
    }
}

struct MockData {

    static func createMockGame(id: Int, name: String, released: String, rating: Double, backgroundImage: String) -> Game {
        return Game(
            id: id,
            slug: "\(name.lowercased().replacingOccurrences(of: " ", with: "-"))-\(id)",
            name: name,
            released: released,
            description: "Mock description for \(name)",
            tba: false,
            backgroundImage: backgroundImage,
            rating: rating,
            ratingTop: 100,
            ratings: [],
            ratingsCount: 0,
            reviewsTextCount: 0,
            added: 0,
            addedByStatus: nil,
            metacritic: 0,
            playtime: 0,
            suggestionsCount: 0,
            updated: "",
            userGame: nil,
            reviewsCount: 0,
            saturatedColor: "#FFFFFF",
            dominantColor: "#000000",
            platforms: [],
            parentPlatforms: [],
            genres: [],
            stores: [],
            clip: nil,
            tags: [],
            esrbRating: nil,
            shortScreenshots: []
        )
    }

    static func createMockGameArray() -> [Game] {
        let game1 = createMockGame(id: 1, name: "Game 1", released: "2023-01-01", rating: 4.5, backgroundImage: "game1_background.jpg")
        let game2 = createMockGame(id: 2, name: "Game 2", released: "2023-02-15", rating: 3.8, backgroundImage: "game2_background.jpg")
        let game3 = createMockGame(id: 3, name: "Game 3", released: "2023-03-30", rating: 4.2, backgroundImage: "game3_background.jpg")
        let game4 = createMockGame(id: 1, name: "Game 4", released: "2023-01-01", rating: 4.5, backgroundImage: "game1_background.jpg")
        let game5 = createMockGame(id: 2, name: "Game 5", released: "2023-02-15", rating: 3.8, backgroundImage: "game2_background.jpg")
        let game6 = createMockGame(id: 3, name: "Game 6", released: "2023-03-30", rating: 4.2, backgroundImage: "game3_background.jpg")
        return [game1, game2, game3, game4, game5, game6]
    }
    
    static func mockGameList() -> GameList {
        return GameList(count: nil, next: nil, previous: nil, results: createMockGameArray(), seoTitle: nil, seoDescription: nil, seoKeywords: nil, seoH1: nil, noindex: nil, nofollow: nil, description: nil, filters: nil, nofollowCollections: nil)
    }
    
    static func mockGame() -> Game {
        return createMockGame(id: 1, name: "GTA 6", released: "2023-10-10", rating: 5.0, backgroundImage: "image")
    }
    
}
