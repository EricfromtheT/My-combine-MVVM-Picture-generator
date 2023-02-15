//
//  Kingfisher+Wrapper.swift
//  My combine AI picture
//
//  Created by 孔令傑 on 2023/2/8.
//

import Foundation
import Kingfisher

extension UIImageView {
    func loadImage(_ urlString: String?, placeHolder: UIImage? = UIImage(named: "image")) {
        guard urlString != nil else { return }
        let url = URL(string: urlString!)
        self.kf.indicatorType = .activity
        self.kf.setImage(with: url, placeholder: placeHolder)
    }
}
