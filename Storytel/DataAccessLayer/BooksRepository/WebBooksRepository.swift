//
//  WebBooksRepository.swift
//  Storytel
//
//  Created by BinaryBoy on 4/18/19.
//  Copyright © 2019 BinaryBoy. All rights reserved.
//

import Foundation

final class WebBooksRepository: BooksRepository {

    let client: APIClient!
    init(client: APIClient = APIClient()) {
        self.client =  client
    }

    func books(for query: String, page: Int?, completion: @escaping (Result<Feed<Book>, StorytelError>) -> Void ) {

        var pageParam = ""
        if let page = page {
            pageParam = "&page=\(page)"
        }

        guard let url = URL(string: "\(APILinksFactory.API.search.path)\(query)\(pageParam)") else { return }
        print(url.absoluteString)
        client.loadData(from: url) { (result: Result<Feed<Book>, StorytelError>) in
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
