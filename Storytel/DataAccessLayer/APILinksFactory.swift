//
//  APILinksFactory.swift
//  Storytel
//
//  Created by BinaryBoy on 4/22/19.
//  Copyright © 2019 BinaryBoy. All rights reserved.
//

import Foundation

struct APILinksFactory {
    
    private static let baseURL = "https://api.storytel.net/"
    
    enum API: String {
        case search = "search?query="
        
        var path: String {
            switch self {
            case .search:
                return APILinksFactory.baseURL + self.rawValue
            }
        }
    }
}

