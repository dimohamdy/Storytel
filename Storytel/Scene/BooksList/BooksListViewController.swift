//
//  BooksListViewController.swift
//  Storytel
//
//  Created by BinaryBoy on 4/18/19.
//  Copyright (c) 2019 BinaryBoy. All rights reserved.
//

import UIKit

class BooksListViewController: UIViewController {
    
    var viewModel: BooksListViewModel!
    
    var tableViewDataSource: BooksTableViewDataSource!
    var booksTableView: UITableView!
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(withViewModel viewModel: BooksListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        setupViews()
        setupLayout()
    }
    
    
}

extension  BooksListViewController: ViewModelDelegate {
    func showLoading() {
        DispatchQueue.main.async {
            self.booksTableView.tableFooterView = LoadingTableViewCell()
            self.booksTableView.tableFooterView?.isHidden = false
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            self.booksTableView.tableFooterView = nil
        }
    }
    
    func updateData(itemsForTable: [ItemTableViewCellType]) {
        
        if tableViewDataSource == nil {
            tableViewDataSource = BooksTableViewDataSource(viewModel: self.viewModel, itemsForTable: itemsForTable)
        } else {
            tableViewDataSource.itemsForTable = itemsForTable
        }
        
        DispatchQueue.main.async {
            self.booksTableView.dataSource = self.tableViewDataSource
            self.booksTableView.delegate = self.tableViewDataSource
            self.booksTableView.reloadData()
        }
    }
    
}
// MARK: Setup
private extension BooksListViewController {
    
    func setupViews() {
        title = "Books"
        
        booksTableView = UITableView()
        
        booksTableView.backgroundColor = .white
        booksTableView.separatorColor = .clear
        booksTableView.frame = self.view.frame
        booksTableView.register(BookTableViewCell.self, forCellReuseIdentifier: BookTableViewCell.identifier)
        booksTableView.register(HeaderTableViewCell.self, forCellReuseIdentifier: HeaderTableViewCell.identifier)
        booksTableView.register(LoadingTableViewCell.self, forCellReuseIdentifier: LoadingTableViewCell.identifier)
        
        view.addSubview(booksTableView)
    }
    
    func setupLayout() {
        
        booksTableView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(self.view).inset(0)
        }
        
    }
    
}
