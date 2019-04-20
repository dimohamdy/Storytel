//
//  BooksListBuilder.swift
//  Storytel
//
//  Created by BinaryBoy on 4/18/19.
//  Copyright (c) 2019 BinaryBoy. All rights reserved.
//

import UIKit

struct BooksListBuilder {

    static func viewController(query:String,dataSource: BooksRepository) -> UIViewController {
        let viewModel = BooksListViewModel(query: query, newsRepository: dataSource)
        let viewController: BooksListViewController = BooksListViewController(withViewModel: viewModel)

        return viewController
    }

    
    static func navigationController(query:String,dataSource: BooksRepository) -> UINavigationController {
        
        return UINavigationController(rootViewController: BooksListBuilder.viewController(query: query, dataSource: dataSource))
    }
}
