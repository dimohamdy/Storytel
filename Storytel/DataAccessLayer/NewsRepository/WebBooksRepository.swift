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

    func getItems(for query:String,page:Int = 0,completion: @escaping (StorytelResult<Result<Book>>) -> Void ) {

        guard let url = URL(string: "\(Constant.apiurl.rawValue)\(query)&page=\(page)") else { return }
        print(url.absoluteString)
        networkManager.loadData(from: url) { (result: StorytelResult<Result<Book>>) in
            switch result {
            case .succeed(let data):
                guard let data = data else {
                    completion(.failed(.noResults))
                    return
                }
                completion(.succeed(data))
            default:
                completion(.failed(StorytelError.unknownError))
            }
        }

    }
}

enum StorytelResult<T> {
    case succeed(T?), failed(StorytelError?)
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
