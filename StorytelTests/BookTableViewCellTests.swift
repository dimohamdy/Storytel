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
            XCTAssertNotNil(cell.bookCoverImageView, "booksTableView added to view")
            XCTAssertNotNil(cell.bookTitleLabel, "booksTableView added to view")
            XCTAssertNotNil(cell.authorsLabel, "booksTableView added to view")
            XCTAssertNotNil(cell.narratorsLabel, "booksTableView added to view")
            XCTAssertNotNil(cell.cardView, "booksTableView added to view")
            XCTAssertNotNil(cell.stackView, "booksTableView added to view")

        }


    }


    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
