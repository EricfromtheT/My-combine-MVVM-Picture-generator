//
//  imageRequestBody.swift
//  My combine AI picture
//
//  Created by 孔令傑 on 2023/2/8.
//

import Foundation

struct ImageRequestBody: Codable {
    var prompt: String
    var size: String = "512x512"
    var n: Int = 3
}
