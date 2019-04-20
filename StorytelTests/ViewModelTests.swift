//
//  ViewModelTests.swift
//  StorytelTests
//
//  Created by BinaryBoy on 4/18/19.
//  Copyright © 2019 BinaryBoy. All rights reserved.
//

import XCTest
@testable import Storytel

class ViewModelTests: XCTestCase {
    var viewModel: BooksListViewModel!

    func testGetDataOnline() {
        let expectation = XCTestExpectation(description: #function)

        // Arrange: Mock Data from API

        let session = URLSessionMock()
        let manager = NetworkManager(session: session)
        // Create data and tell the session to always return it
        session.data = getData()

        let webBooksRepository: WebBooksRepository = WebBooksRepository(networkManager: manager)
        // Arrange: setup ViewModel
        // Act: get data from API .
        viewModel = BooksListViewModel(query: "Harry", booksRepository: webBooksRepository)
        DispatchQueue.main.async {
            // Assert: Verify it's have a data.
            XCTAssertGreaterThan(self.viewModel.itemsForTable.count, 0)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)

    }

    func testNotGetDataOnline() {
        let expectation = XCTestExpectation(description: #function)

        // Arrange: Mock Data from API

        let session = URLSessionMock()
        let manager = NetworkManager(session: session)
        // Create data and tell the session to always return it
        session.data = nil

        let webBooksRepository: WebBooksRepository = WebBooksRepository(networkManager: manager)
        // Arrange: setup ViewModel
        // Act: get data from API .
        viewModel = BooksListViewModel(query: "Harry", booksRepository: webBooksRepository)
        DispatchQueue.main.async {
            // Assert: Verify it's have a data.
            XCTAssertEqual(self.viewModel.itemsForTable.count, 1)
            if let firstItem = self.viewModel.itemsForTable.first {
                switch firstItem {
                case .error:
                    XCTAssert(true, "We found Error Item")
                default:
                    XCTFail("We dont't found Error Item")

                }
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 5)

    }
    
    func testHeader() {
        let expectation = XCTestExpectation(description: #function)
        
        // Arrange: Mock Data from API
        
        let session = URLSessionMock()
        let manager = NetworkManager(session: session)
        // Create data and tell the session to always return it
        session.data = getData()

        let webBooksRepository: WebBooksRepository = WebBooksRepository(networkManager: manager)
        // Arrange: setup ViewModel
        // Act: get data from API .
        viewModel = BooksListViewModel(query: "Harry", booksRepository: webBooksRepository)
        DispatchQueue.main.async {
            // Assert: Verify it's have a data.
            if let firstItem = self.viewModel.itemsForTable.first {
                switch firstItem {
                case .header(let header):
                    XCTAssert(true, "We found Header")
                    XCTAssertEqual(header, "Harry")
                default:
                    XCTFail("We dont't found Header Item")
                }
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 5)
        
    }

}
