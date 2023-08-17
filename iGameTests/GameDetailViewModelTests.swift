//
//  iGameTests.swift
//  iGameTests
//
//  Created by Fauzi Achmad B D on 15/08/23.
//

import XCTest
import CoreData
@testable import iGame

class GameDetailViewModelTests: XCTestCase {

    var viewModel: GameDetailViewModel!
    var mockService: MockGameDetailService!
    var mockViewContext: NSManagedObjectContext!

    override func setUp() {
        super.setUp()

        mockService = MockGameDetailService()
        mockViewContext = mockPersistentContainer.viewContext

        viewModel = GameDetailViewModel(service: mockService, viewContext: mockViewContext)
    }

    override func tearDown() {
        viewModel = nil
        mockService = nil
        mockViewContext = nil
        super.tearDown()
    }

    func testFetchData_Success() async {
        // Given
        let mockGame = MockData.mockGame()
        mockService.mockResult = .success(MockData.mockGame())

        // When
        await viewModel.fetchData(id: 1)

        // Then
        XCTAssertEqual(viewModel.game?.name, mockGame.name)
        XCTAssertFalse(viewModel.isFavorite) // Adjust the expected result based on your mock data
    }

    func testFetchData_Failure() async {
        // Given
        mockService.mockResult = .failure(.badRequest)

        // When
        await viewModel.fetchData(id: 1)

        // Then
        XCTAssertNil(viewModel.game)
        XCTAssertFalse(viewModel.isFavorite)
    }

    func testToggleFavoritesButton_AddFavorite() {
        // Given
        let mockGame = MockData.mockGame()
        viewModel.game = mockGame

        // When
        viewModel.toggleFavoritesButton()

        // Then
        XCTAssertTrue(viewModel.isFavorite)
    }

    func testToggleFavoritesButton_RemoveFavorite() {
        // Given
        let mockGame = MockData.mockGame()
        viewModel.game = mockGame
        viewModel.isFavorite = true

        // When
        viewModel.toggleFavoritesButton()

        // Then
        XCTAssertFalse(viewModel.isFavorite)
    }
    
    // Mock Persistent Container
    var mockPersistentContainer: NSPersistentContainer {
        
        let container = NSPersistentContainer(name: "iGame")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false // Make it simpler in test env
        
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { (description, error) in
            // Check if the data store is in memory
            precondition( description.type == NSInMemoryStoreType )
            
            // Check if creating container wrong
            if let error = error {
                fatalError("Create an in-mem coordinator failed \(error)")
            }
        }
        return container
    }
}
