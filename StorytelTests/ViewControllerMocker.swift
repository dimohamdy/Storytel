//
//  ViewControllerMocker.swift
//  StorytelTests
//
//  Created by BinaryBoy on 4/20/19.
//  Copyright © 2019 BinaryBoy. All rights reserved.
//

import Foundation
@testable import Storytel

extension BooksListViewController {
    
    static func setUpViewControllers() -> BooksListViewController {
        
        // Arrange: setup ViewController with data source
        let booksListViewController = BooksListBuilder.viewController(query: "Harry", dataSource: WebBooksRepository()) as? BooksListViewController
        
        // Arrange: setup ViewModel With Mocked Data
        let viewModel = getViewModelWithMockData()
        
        booksListViewController?.viewModel = viewModel
        booksListViewController?.viewModel.delegate =  booksListViewController
        
        booksListViewController?.loadView()
        booksListViewController?.viewDidLoad()
        
        return booksListViewController!
    }
    
    static func getViewModelWithMockData() -> BooksListViewModel {
        let session = URLSessionMock()
        let manager = NetworkManager(session: session)
        // Create data and tell the session to always return it
        session.data = getData()
        let webBooksRepository: WebBooksRepository = WebBooksRepository(networkManager: manager)
        return BooksListViewModel(query: "Harry", booksRepository: webBooksRepository)
    }
}

