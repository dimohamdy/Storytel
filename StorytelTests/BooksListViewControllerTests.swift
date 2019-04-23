//
//  BooksListViewControllerTests.swift
//  StorytelTests
//
//  Created by BinaryBoy on 4/20/19.
//  Copyright © 2019 BinaryBoy. All rights reserved.
//

import XCTest
@testable import Storytel

class BooksListViewControllerTests: XCTestCase {

    var booksListViewController: BooksListViewController!

    override func setUp() {
        super.setUp()
        booksListViewController =  BooksListViewController.setUpViewControllers()
        // Arrange: setup UINavigationController
        let navigationController = MockNavigationController(rootViewController: booksListViewController)
        UIApplication.shared.keyWindow?.rootViewController = navigationController
    }

    func testGetDataOnline() {

        let expectation = XCTestExpectation(description: #function)

        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            // Assert: Verify table have updated with data.
            let numberOfCellInFirstSection = self.booksListViewController!.booksTableView.numberOfRows(inSection: 0)
            XCTAssertEqual(numberOfCellInFirstSection, self.self.booksListViewController.viewModel.itemsForTable.count)
            XCTAssertGreaterThan(numberOfCellInFirstSection, 0)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }

    func testUI() {
        XCTAssertNotNil(booksListViewController.booksTableView, "booksTableView added to view")
    }

}

class MockNavigationController: UINavigationController {

    var pushedViewController: UIViewController?

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushedViewController = viewController
        super.pushViewController(viewController, animated: true)
    }
}
