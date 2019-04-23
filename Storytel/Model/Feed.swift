//
//	Feed.swift
//
//	Create by BinaryBoy on 18/4/2019
//	Copyright © 2019. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct Feed<T: Decodable>: Decodable {

	let items: [T]?
	let nextPage: String?
	let query: String?
	let totalCount: Int?

	enum CodingKeys: String, CodingKey {
		case filter
		case items
		case nextPage
		case query
		case totalCount
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		items = try values.decodeIfPresent([T].self, forKey: .items)
		nextPage = try values.decodeIfPresent(String.self, forKey: .nextPage)
		query = try values.decodeIfPresent(String.self, forKey: .query)
		totalCount = try values.decodeIfPresent(Int.self, forKey: .totalCount)
	}

}
