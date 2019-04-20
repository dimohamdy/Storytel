//
//  TableViewDataSource.swift
//  Storytel
//
//  Created by BinaryBoy on 4/3/19.
//  Copyright © 2019 BinaryBoy. All rights reserved.
//

import UIKit

class TableViewDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {
    var itemsForTable: [ItemTableViewCellType]!
    var viewModel:BooksListViewModel!
    
    init(viewModel:BooksListViewModel,itemsForTable: [ItemTableViewCellType]) {
        self.itemsForTable = itemsForTable
        self.viewModel = viewModel
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsForTable.count - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = itemsForTable[indexPath.row]
        switch item {
        case .header(let header):
            if let headerCell: HeaderTableViewCell = tableView.dequeueReusableCell(for: indexPath) {
                headerCell.config(header: header)
                return headerCell
            }
            return UITableViewCell()
        case .cellItem(let book):
            if let cell: BookTableViewCell = tableView.dequeueReusableCell(for: indexPath) {
                cell.book = book
                return cell
            }
            return UITableViewCell()
        case .error(let message):
            return UITableViewCell.getEmptyCell(message: message)
        case .empty:
            return UITableViewCell.getEmptyCell(message: "No data available")
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = itemsForTable[indexPath.row]
        switch item {
        case .cellItem:
            return 120
        case .error, .empty:
            return tableView.frame.size.height
        default:
            return 0
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView.isLast(for: indexPath) {
            viewModel.loadMoreData(indexPath)
        }
    }
    
}
