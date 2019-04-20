//
//  BooksListViewModel.swift
//  Storytel
//
//  Created by BinaryBoy on 4/18/19.
//  Copyright (c) 2019 BinaryBoy. All rights reserved.
//
import Foundation

enum ItemTableViewCellType {
    case header(headerTitle: String)
    case cellItem(book: Book)
    case error(message: String)
    case empty
    case loading

}
protocol ViewModelDelegate: class {
    func updateData(itemsForTable: [ItemTableViewCellType])
    func showLoading(index: IndexPath)
    func hideLoading(index: IndexPath)
}
class BooksListViewModel {
    
    // input
    var newsRepository: BooksRepository!
    // output
    weak var delegate: ViewModelDelegate? {
        didSet {
            guard let delegate = delegate,!itemsForTable.isEmpty else {
                return
            }
            delegate.updateData(itemsForTable: itemsForTable)
        }
    }

    
    var query: String!
    
    fileprivate var page = 1
    fileprivate var canLoadMore = true
    // internal
    var itemsForTable: [ItemTableViewCellType] = [ItemTableViewCellType]()
    
    var loadingIndexPath:IndexPath {
        return IndexPath(row: self.itemsForTable.count, section: 0)
    }
    
    init(query:String,newsRepository: BooksRepository = WebBooksRepository()) {
        self.newsRepository = newsRepository
        self.query = query
    }
    func refreshData() {
        self.itemsForTable.append(.header(headerTitle: query))
        getData(newsRepository: self.newsRepository, for: query)
    }
    
    func loadMoreData(_ index: IndexPath) {
        print(index.item)
            itemsForTable.append(.loading)
            delegate?.showLoading(index: loadingIndexPath)
            getData(newsRepository: self.newsRepository, for: self.query)
    }
    
    private func getData(for query:String = "harry") {
        self.itemsForTable = []
        page = 1
        getData(newsRepository: self.newsRepository, for: query.lowercased())
    }
    
}

// MARK: Setup

extension BooksListViewModel {
    
    
    private func getData(newsRepository: BooksRepository,for query:String) {
        self.newsRepository = newsRepository
        self.query = query

        guard (newsRepository is WebBooksRepository && Reachability.isConnectedToNetwork() == true) else {
            self.itemsForTable = [.error(message: StorytelError.noInternetConnection.localizedDescription)]
            self.delegate?.updateData(itemsForTable: itemsForTable)
            return
        }
        
        newsRepository.getItems(for: query, page: page) { [weak self] result in
            guard let self =  self else{
                return
            }
            switch result {
            case .succeed(let searchResult):

                guard  let books = searchResult?.items, books.count > 0,let nextPage = Int(searchResult?.nextPage ?? "0") else {
                    self.itemsForTable.append(.empty)
                    self.delegate?.updateData(itemsForTable: self.itemsForTable )
                    return
                }

                let newItems:[ItemTableViewCellType] = self.createItemsForTable(books: books)
                self.page = nextPage
                if let lastItem = self.itemsForTable.last{
                    switch lastItem {
                    case .loading:
                        self.itemsForTable.removeLast()
                        self.delegate?.hideLoading(index: self.loadingIndexPath)
                    default:
                        break
                    }
                }

                
                self.itemsForTable.append(contentsOf: newItems)
                self.delegate?.updateData(itemsForTable: self.itemsForTable )
                
            case .failed(let error):
                self.itemsForTable = [.error(message: error?.localizedDescription ?? StorytelError.unknownError.localizedDescription)]
                self.delegate?.updateData(itemsForTable: self.itemsForTable )
            }
        }
    }

    private func createItemsForTable(books: [Book]) -> [ItemTableViewCellType] {
        var itemsForTable: [ItemTableViewCellType] = []
        
        for book in books {
            itemsForTable.append(.cellItem(book: book))
        }
        
        return itemsForTable
    }
}
