//
//	Publisher.swift
//
//	Create by BinaryBoy on 18/4/2019
//	Copyright © 2019. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct Publisher: Codable {

	let id: String?
	let name: String?
	let slug: String?
	let type: String?

	enum CodingKeys: String, CodingKey {
		case id
		case name
		case slug
		case type
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		slug = try values.decodeIfPresent(String.self, forKey: .slug)
		type = try values.decodeIfPresent(String.self, forKey: .type)
	}

}
