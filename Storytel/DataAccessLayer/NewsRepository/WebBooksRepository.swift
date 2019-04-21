//
//  WebBooksRepository.swift
//  Storytel
//
//  Created by BinaryBoy on 4/18/19.
//  Copyright © 2019 BinaryBoy. All rights reserved.
//

import Foundation
import CoreData
import UIKit

enum Constant: String {
    case key = "196c507c1c704672b15831bb89ce9cda"
    case apiurl = "https://api.storytel.net/search?query="
}

final class WebBooksRepository: BooksRepository {

    let networkManager: NetworkManager!
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager =  networkManager
    }

    func getItems(for query:String,page:Int?,completion: @escaping (Result<Feed<Book>,StorytelError>) -> Void ) {

        var pageParam = ""
        if let page = page {
             pageParam = "&page=\(page)"
        }
        guard let url = URL(string: "\(Constant.apiurl.rawValue)\(query)\(pageParam)") else { return }
        print(url.absoluteString)
        networkManager.loadData(from: url) { (result: Result<Feed<Book>,StorytelError>) in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }

    }
}


enum StorytelError: Error {
    case failedConnection
    case idError
    case noResults
    case noInternetConnection
    case unknownError
    case runtimeError(String)
    var localizedDescription: String {
        switch self {
        case .noResults:
            return "No result found"
        case .noInternetConnection:
            return "No Internet Connection"
        case .unknownError:
            return "something wrong Happen, please try other time"
        default:
            return "something wrong Happen, please try other time"
        }
    }
}
