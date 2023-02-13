//
//  ChatRoomTableView.swift
//  My combine AI picture
//
//  Created by 孔令傑 on 2023/2/10.
//

import UIKit

class ChatRoomTableView: UITableView {
    
    init() {
        super.init(frame: .zero, style: .plain)
        backgroundColor = .systemGray5
        separatorStyle = .none
        register(ImageMessageCell.self, forCellReuseIdentifier: ImageMessageCell.identifier)
        register(TextMessageCell.self, forCellReuseIdentifier: TextMessageCell.identifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("did not initialize programmically correctly")
    }
}
