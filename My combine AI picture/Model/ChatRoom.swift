//
//  ChatRoom.swift
//  My combine AI picture
//
//  Created by 孔令傑 on 2023/2/11.
//

import UIKit

protocol ChatCell: UITableViewCell {
    func configure(data: ContentInfo)
}

enum CellType: Int, CaseIterable {
    case imageType
    case textType
    
    var cellIdentifier: String {
        switch self {
        case .imageType:
            return ImageMessageCell.identifier
        case .textType:
            return TextMessageCell.identifier
        }
    }
}

struct ContentInfo: Hashable {
    let identifier: String = UUID().uuidString
    let type: CellType
    let data: String
}


