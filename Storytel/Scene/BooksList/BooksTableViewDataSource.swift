//
//  BooksTableViewDataSource.swift
//  Storytel
//
//  Created by BinaryBoy on 4/3/19.
//  Copyright © 2019 BinaryBoy. All rights reserved.
//

import UIKit
import SkeletonView

class BooksTableViewDataSource: NSObject, UITableViewDelegate, SkeletonTableViewDataSource {
    var itemsForTable: [ItemTableViewCellType]!
    var viewModel: BooksListViewModel!

    struct Constant {
        static let heightOfBookCell: CGFloat = 120
        static let heightOfHeaderCell: CGFloat = 100
        static let heightOfSkeltonCell: CGFloat = 120

    }

    init(viewModel: BooksListViewModel, itemsForTable: [ItemTableViewCellType]) {
        self.itemsForTable = itemsForTable
        self.viewModel = viewModel
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard !itemsForTable.isEmpty else {
            return 10
        }
        return itemsForTable.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !itemsForTable.isEmpty else {
            return SkeltonTableViewCell()
        }
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
            return UITableViewCell.emptyCell(message: message)
        case .empty:
            return UITableViewCell.emptyCell(message: "No books found")
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard !itemsForTable.isEmpty else {
            return Constant.heightOfSkeltonCell
        }
        let item = itemsForTable[indexPath.row]
        switch item {
        case .cellItem:
            return Constant.heightOfBookCell
        case .header:
            return Constant.heightOfHeaderCell
        case .error, .empty:
            return tableView.frame.size.height

        }

    }

    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return SkeltonTableViewCell.identifier
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let bookTableViewCell =  cell as? BookTableViewCell
        if tableView.isLast(for: indexPath), bookTableViewCell != nil {
            viewModel.loadMoreData(indexPath)
        }
    }

}
