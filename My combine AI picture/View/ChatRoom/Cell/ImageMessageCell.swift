//
//  ImageMessageCell.swift
//  My combine AI picture
//
//  Created by 孔令傑 on 2023/2/11.
//

import UIKit
import Kingfisher

final class ImageMessageCell: UITableViewCell, ChatCell {
    
    private let picView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubViews()
        setUpConstraints()
        setUpAppearance()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("不可以跑到這裡")
    }
    
    func configure(data: ContentInfo) {
        picView.loadImage(data.data)
    }
    
    private func addSubViews() {
        contentView.addSubview(picView)
        picView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            picView.widthAnchor.constraint(equalToConstant: 150),
            picView.heightAnchor.constraint(equalToConstant: 150),
            picView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            picView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            picView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    private func setUpAppearance() {
        picView.layer.cornerRadius = 10
        backgroundColor = .systemGray5
    }
}
