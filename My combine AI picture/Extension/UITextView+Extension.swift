//
//  UITextView+Extension.swift
//  My combine AI picture
//
//  Created by 孔令傑 on 2023/2/10.
//

import UIKit
import Combine

extension UITextView {
    var textViewPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default.publisher(for: UITextView.textDidChangeNotification)
            .compactMap { $0.object as? UITextView }
            .compactMap(\.text)
            .eraseToAnyPublisher()
    }
}
