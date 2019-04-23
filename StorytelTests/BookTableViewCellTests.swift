//
//  BookTableViewCellTests.swift
//  StorytelTests
//
//  Created by BinaryBoy on 4/20/19.
//  Copyright © 2019 BinaryBoy. All rights reserved.
//

import XCTest
@testable import Storytel

class BookTableViewCellTests: XCTestCase {

    var cell: BookTableViewCell!
    var booksListViewController: BooksListViewController!

    override func setUp() {
        super.setUp()
        booksListViewController =  BooksListViewController.setUpViewControllers()
        // Arrange: setup UINavigationController
        let navigationController = MockNavigationController(rootViewController: booksListViewController)
        UIApplication.shared.keyWindow?.rootViewController = navigationController
    }

    func testUI() {
        XCTAssertNotNil(booksListViewController.booksTableView, "booksTableView added to view")
    }

    func testUIForCell() {
        if let cell = booksListViewController.booksTableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? BookTableViewCell {
            XCTAssertNotNil(cell.bookCoverImageView, "bookCoverImageView added to cell")
            XCTAssertNotNil(cell.bookTitleLabel, "bookTitleLabel added to cell")
            XCTAssertNotNil(cell.authorsLabel, "authorsLabel added to cell")
            XCTAssertNotNil(cell.narratorsLabel, "narratorsLabel added to cell")
            XCTAssertNotNil(cell.cardView, "booksTableView added to cell")
            XCTAssertNotNil(cell.stackView, "v added to cell")

        }

    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
