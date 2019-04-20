//
//	Cover.swift
//
//	Create by BinaryBoy on 18/4/2019
//	Copyright © 2019. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct Cover : Codable {

	let height : Int?
	let url : String?
	let width : Int?


	enum CodingKeys: String, CodingKey {
		case height = "height"
		case url = "url"
		case width = "width"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		height = try values.decodeIfPresent(Int.self, forKey: .height)
		url = try values.decodeIfPresent(String.self, forKey: .url)
		width = try values.decodeIfPresent(Int.self, forKey: .width)
	}


}