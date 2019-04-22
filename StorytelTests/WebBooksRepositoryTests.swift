//
//  WebBooksRepositoryTests.swift
//  StorytelTests
//
//  Created by BinaryBoy on 4/18/19.
//  Copyright © 2019 BinaryBoy. All rights reserved.
//

import XCTest
@testable import Storytel

class WebBooksRepositoryTests: XCTestCase {
    var webBooksRepository: WebBooksRepository!
    
    override func setUp() {
        // Arrange: setup ViewModel
        webBooksRepository = WebBooksRepository()
    }

    func testGetItemsFromAPI() {
        // Act: get data from API .
        webBooksRepository.books(for: "Harry", page: nil) { result in
                switch result {
                case .success(let data):
                    guard let books = data.items, books.count > 0 else {
                        return
                    }
                    // Assert: Verify it's have a data.
                    XCTAssertGreaterThan(books.count, 0)
                    XCTAssertEqual(books.count, 10)
                default:
                    XCTFail("Can't get Data")
                }
                
        }
    }
}
