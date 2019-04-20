//
//	Book.swift
//
//	Create by BinaryBoy on 18/4/2019
//	Copyright © 2019. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct Book : Codable {

	let authors : [Author]?
	let cover : Cover?
	let id : String?
	let narrators : [Author]?
	let originalTitle : String?
	let publishers : [Publisher]?
	let title : String?


	enum CodingKeys: String, CodingKey {
		case authors = "authors"
		case cover
		case id = "id"
		case narrators = "narrators"
		case originalTitle = "originalTitle"
		case publishers = "publishers"
		case title = "title"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		authors = try values.decodeIfPresent([Author].self, forKey: .authors)
        cover = try values.decodeIfPresent(Cover.self, forKey: .cover)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		narrators = try values.decodeIfPresent([Author].self, forKey: .narrators)
		originalTitle = try values.decodeIfPresent(String.self, forKey: .originalTitle)
		publishers = try values.decodeIfPresent([Publisher].self, forKey: .publishers)
		title = try values.decodeIfPresent(String.self, forKey: .title)
	}


}
