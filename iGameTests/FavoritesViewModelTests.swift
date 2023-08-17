//
//  FavoritesViewModelTests.swift
//  iGameTests
//
//  Created by Fauzi Achmad B D on 17/08/23.
//

import XCTest
import CoreData
@testable import iGame

class FavoritesViewModelTests: XCTestCase {

    var viewModel: FavoritesViewModel!
    var mockViewContext: NSManagedObjectContext!

    override func setUp() {
        super.setUp()

        // Create an in-memory persistent container for testing
        mockViewContext = mockPersistentContainer.viewContext

        viewModel = FavoritesViewModel(viewContext: mockViewContext)
    }

    override func tearDown() {
        viewModel = nil
        mockViewContext = nil
        super.tearDown()
    }

    func testFetchData() async {
        // Given
        let mockGameModel1 = createMockGameModel(id: 1, name: "Game 1", released: "2023-01-01", rating: 4.5)
        let mockGameModel2 = createMockGameModel(id: 2, name: "Game 2", released: "2023-02-15", rating: 3.8)
        // Add more mock game models if needed
        saveMockGameModels([mockGameModel1, mockGameModel2])

        // When
        await viewModel.fetchData()

        // Then
        XCTAssertEqual(viewModel.totalItems, 2)
    }

    // Helper method to create a mock GameModel
    private func createMockGameModel(id: Int, name: String, released: String, rating: Double) -> GameModel {
        let gameModel = GameModel(context: mockViewContext)
        gameModel.id = Int16(id)
        gameModel.name = name
        gameModel.released = released
        gameModel.rating = rating
        return gameModel
    }

    // Helper method to save mock GameModels
    private func saveMockGameModels(_ gameModels: [GameModel]) {
        do {
            try mockViewContext.save()
        } catch {
            XCTFail("Failed to save mock GameModels: \(error)")
        }
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

