//
//  DataLoader.swift
//  ScoutTests
//
//  Created by BinaryBoy on 4/20/19.
//  Copyright © 2018 BinaryBoy. All rights reserved.
//

import Foundation

func getData() -> Data? {
    
    guard let path = Bundle.main.path(forResource: "data", ofType: "json") else {
        return nil
    }
    do {
        let content = try String(contentsOfFile: path)
        let data: Data? = content.data(using: .utf8) // non-nil
        return data
    } catch {
        return nil
    }
}
