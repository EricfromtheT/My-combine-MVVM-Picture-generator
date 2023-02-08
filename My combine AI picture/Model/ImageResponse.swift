//
//  ImageResponse.swift
//  My combine AI picture
//
//  Created by 孔令傑 on 2023/2/8.
//

import Foundation

struct ImageResponse: Codable {
    let created: Int
    let data: [ImageURL]
}

struct ImageURL: Codable {
    let url: String
}
