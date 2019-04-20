//
//  DataSource.swift
//  Storytel
//
//  Created by BinaryBoy on 4/18/19.
//  Copyright © 2019 BinaryBoy. All rights reserved.
//

import Foundation
protocol BooksRepository {
    func getItems(for query:String,page:Int?,completion:@escaping (StorytelResult<Result<Book>>) -> Void)
}
