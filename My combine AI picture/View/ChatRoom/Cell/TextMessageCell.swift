//
//  textMessageCell.swift
//  My combine AI picture
//
//  Created by 孔令傑 on 2023/2/11.
//

import UIKit

final class TextMessageCell: UITableViewCell, ChatCell {
    
    private let promptLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubViews()
        setUpConstaints()
        setUpAppearance()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("不可以跑到這裡")
    }
    
    func configure(data: ContentInfo) {
        promptLabel.text = data.data
    }
    
    private func addSubViews() {
        contentView.addSubview(promptLabel)
        promptLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setUpConstaints() {
        NSLayoutConstraint.activate([
            promptLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            promptLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            promptLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            promptLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
    
    private func setUpAppearance() {
        promptLabel.font = UIFont.systemFont(ofSize: 20)
        backgroundColor = .systemGray5
    }
}
