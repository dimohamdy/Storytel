//
//  NetworkSession.swift
//  Storytel
//
//  Created by BinaryBoy on 4/18/19.
//  Copyright © 2019 BinaryBoy. All rights reserved.
//

import Foundation
import UIKit

protocol NetworkSession {
    func loadData(from url: URL,
                  completionHandler: @escaping (Data?, Error?) -> Void)
}

extension URLSession: NetworkSession {
    func loadData(from url: URL,
                  completionHandler: @escaping (Data?, Error?) -> Void) {
        let task = dataTask(with: url) { (data, _, error) in
            completionHandler(data, error)
        }
        task.resume()
    }
}

class NetworkManager {
    private let session: NetworkSession
    init(session: NetworkSession = URLSession.shared) {
        self.session = session
    }
    func loadData<T: Decodable>(from url: URL,
                                completion: @escaping (StorytelResult<T>) -> Void) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true

        session.loadData(from: url) { data, _ in
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            do {
                
                guard let data = data else {
                    completion(.failed(StorytelError.noResults))
                    return
                }
                // Parse JSON data

                let decoder = JSONDecoder()
                let result = try decoder.decode(T.self, from: data)
                completion(.succeed(result))

            } catch let err {
                print("Err", err)
                completion(.failed(err as? StorytelError))

            }

        }
    }
}
