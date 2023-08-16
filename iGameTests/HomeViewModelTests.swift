//
//  HomeViewModelTests.swift
//  iGameTests
//
//  Created by Fauzi Achmad B D on 17/08/23.
//

import XCTest
@testable import iGame

class HomeViewModelTests: XCTestCase {

    var viewModel: HomeViewModel!
    var mockService: MockHomeService!

    override func setUp() {
        super.setUp()

        mockService = MockHomeService()
        viewModel = HomeViewModel(service: mockService)
    }

    override func tearDown() {
        viewModel = nil
        mockService = nil
        super.tearDown()
    }

    func testFetchData_Success() async {
        // Given
        let expectedResultCount = 6
        mockService.mockResult = .success(MockData.mockGameList())

        // When
        await viewModel.fetchData()

        // Then
        XCTAssertEqual(viewModel.totalItems, expectedResultCount)
    }

    func testFetchData_Failure() async {
        // Given
        let expectedResultCount = 0
        mockService.mockResult = .failure(.badRequest)

        // When
        await viewModel.fetchData()

        // Then
        XCTAssertEqual(viewModel.totalItems, expectedResultCount)
    }

    func testCheckIfEnableFetchData() async {
        // Given
        let currentRow = 4
        mockService.mockResult = .success(MockData.mockGameList())
        await viewModel.fetchData()
        viewModel.isRequestInFlight = false

        // When
        viewModel.checkIfEnableFetchData(currentRow: currentRow)

        // Then
        XCTAssertTrue(mockService.getGamesCalled)
    }
}
