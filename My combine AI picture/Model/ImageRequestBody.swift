//
//  imageRequestBody.swift
//  My combine AI picture
//
//  Created by 孔令傑 on 2023/2/8.
//

import Foundation

struct ImageRequestBody: Encodable {
    let prompt: String
    let size: String = "512x512"
    let n: Int = 2
}
