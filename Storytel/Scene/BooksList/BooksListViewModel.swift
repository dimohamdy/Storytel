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
}
protocol ViewModelDelegate: class {
    func updateData(itemsForTable: [ItemTableViewCellType], rows: [IndexPath]?,reloadTable: Bool)
    func showLoading()
    func hideLoading()
}
class BooksListViewModel {
    
    // input
    var booksRepository: BooksRepository!
    // output
    weak var delegate: ViewModelDelegate? {
        didSet {
            guard let delegate = delegate else {
                return
            }
            delegate.updateData(itemsForTable: itemsForTable, rows: nil,reloadTable: true)
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
        self.delegate?.updateData(itemsForTable: [], rows: nil, reloadTable: true)
        getData(booksRepository: self.booksRepository, for: query)
    }
    
    func loadMoreData(_ index: IndexPath) {
        if canLoadMore == true {
            getData(booksRepository: self.booksRepository, for: self.query)
        }
        
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
            self.delegate?.updateData(itemsForTable: itemsForTable, rows: nil, reloadTable: true)
            return
        }
        delegate?.showLoading()
        canLoadMore = false
        
        booksRepository.books(for: query, page: page) { [weak self] result in
            
            
            guard let self =  self else{
                return
            }
            
            self.canLoadMore = true
            self.delegate?.hideLoading()
            
            switch result {
            case .success(let searchResult):
                
                guard  let books = searchResult.items, books.count > 0,let nextPage = Int(searchResult.nextPage ?? "0") else {
                    self.handleNoBooks()
                    return
                }
                self.handleNewBooks(books: books)
                self.page = nextPage
                
            case .failure(let error):
                self.itemsForTable = [.error(message: error.localizedDescription)]
                self.delegate?.updateData(itemsForTable: self.itemsForTable, rows: nil, reloadTable: true)
            }
        }
    }
    
    private func handleNewBooks(books: [Book]) {
        
        //reload table prevent me to reload all table when each page I use insertRows Insted
        var reloadTable: Bool = false
        if itemsForTable.count == 0 {
            reloadTable = true
        }
        
        //only first time add header when page nil
        if page == nil {
            itemsForTable.append(.header(headerTitle: query))
        }
        
        let newItems:[ItemTableViewCellType] = createItemsForTable(books: books)
        
        let indexs = indexesForNewBooks(from: itemsForTable.count, to: itemsForTable.count + newItems.count)
        
        itemsForTable.append(contentsOf: newItems)
        
        delegate?.updateData(itemsForTable: itemsForTable, rows: indexs, reloadTable: reloadTable)
    }
    
    private func handleNoBooks() {
        
        if  itemsForTable.isEmpty {
            itemsForTable.append(.empty)
            delegate?.updateData(itemsForTable: itemsForTable, rows: nil, reloadTable: true)
        }
    }
    
    private func indexesForNewBooks(from: Int,to: Int) -> [IndexPath] {
        
        let indexsArray = (from ..< to).map { index -> IndexPath in
            return IndexPath(row: index, section: 0)
        }
        
        return indexsArray
    }
    
    private func createItemsForTable(books: [Book]) -> [ItemTableViewCellType] {
        var itemsForTable: [ItemTableViewCellType] = []
        
        for book in books {
            itemsForTable.append(.cellItem(book: book))
        }
        
        return itemsForTable
    }
}
