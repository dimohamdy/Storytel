//
//  NetworkTests.swift
//  StorytelTests
//
//  Created by BinaryBoy on 4/18/19.
//  Copyright © 2019 BinaryBoy. All rights reserved.
//

import XCTest
@testable import Storytel

class NetworkTests: XCTestCase {
    

    func testGetItems() {
        // Setup our objects
        let session = URLSessionMock()
        let manager = APIClient(session: session)
        // Create data and tell the session to always return it
        session.data = getData()
        // Create a URL (using the file path API to avoid optionals)
        let url = URL(fileURLWithPath: "url")
        // Perform the request and verify the result
        manager.loadData(from: url) { (result: Result<Feed<Book>>) in
            
            switch result {
            case .success(let data):
                guard let data = data,let books = data.items else {
                    XCTFail("Can't get Data")
                    return
                }
                XCTAssertGreaterThan(books.count, 0)
            default:
                XCTFail("Can't get Data")                
            }
        }
    }
        
}
