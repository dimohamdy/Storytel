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
    func showLoading()
    func hideLoading()
}
class BooksListViewModel {
    
    // input
    var booksRepository: BooksRepository!
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
    
    fileprivate var page:Int?
    fileprivate var canLoadMore = true
    // internal
    var itemsForTable: [ItemTableViewCellType] = [ItemTableViewCellType]()
    
    
    init(query:String,booksRepository: BooksRepository = WebBooksRepository()) {
        self.booksRepository = booksRepository
        self.query = query
        refreshData()
    }
    
    private func refreshData() {
        self.itemsForTable.append(.header(headerTitle: query))
        getData(booksRepository: self.booksRepository, for: query)
    }
    
    func loadMoreData(_ index: IndexPath) {
            print(index.item)
            itemsForTable.append(.loading)
            delegate?.showLoading()
            getData(booksRepository: self.booksRepository, for: self.query)
    }
    
    private func getData(for query:String = "harry") {
        self.itemsForTable = []
        page = nil
        getData(booksRepository: self.booksRepository, for: query.lowercased())
    }
    
}

// MARK: Setup

extension BooksListViewModel {
    
    
    private func getData(booksRepository: BooksRepository,for query:String) {
        self.booksRepository = booksRepository
        self.query = query

        guard (booksRepository is WebBooksRepository && Reachability.isConnectedToNetwork() == true) else {
            self.itemsForTable = [.error(message: StorytelError.noInternetConnection.localizedDescription)]
            self.delegate?.updateData(itemsForTable: itemsForTable)
            return
        }
        
        booksRepository.books(for: query, page: page) { [weak self] result in
            guard let self =  self else{
                return
            }
            switch result {
            case .success(let searchResult):

                guard  let books = searchResult.items, books.count > 0,let nextPage = Int(searchResult.nextPage ?? "0") else {
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
                        self.delegate?.hideLoading()
                    default:
                        break
                    }
                }

                
                self.itemsForTable.append(contentsOf: newItems)
                self.delegate?.updateData(itemsForTable: self.itemsForTable )
                
            case .failure(let error):
                self.itemsForTable = [.error(message: error.localizedDescription)]
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
