//
//  ImageResponse.swift
//  My combine AI picture
//
//  Created by 孔令傑 on 2023/2/8.
//

import Foundation

struct ImageResponse: Codable {
    var created: Int
    var data: [ImageURL]
}

struct ImageURL: Codable {
    var url: String
}
