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
        setTarget()
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
    
    private func setTarget() {
        picView.isUserInteractionEnabled = true
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(showComfirmation))
        picView.addGestureRecognizer(gesture)
    }
    
    @objc private func showComfirmation() {
        let alert = UIAlertController(title: "下載", message: "是否確定下載", preferredStyle: .alert)
        let reject = UIAlertAction(title: "No", style: .cancel)
        let comfirm = UIAlertAction(title: "Yes", style: .default) {
            action in
            self.downloadImage()
        }
        alert.addAction(reject)
        alert.addAction(comfirm)
        viewContainingController()?.present(alert, animated: true)
    }
    
    private func downloadImage() {
        guard let image = picView.image else { return }
        UIImageWriteToSavedPhotosAlbum(image, self, nil, nil)
    }
}
