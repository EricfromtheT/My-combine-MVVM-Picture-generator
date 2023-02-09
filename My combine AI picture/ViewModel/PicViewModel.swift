//
//  PicViewModel.swift
//  My combine AI picture
//
//  Created by 孔令傑 on 2023/2/8.
//

import Foundation
import Combine

final class PicViewModel {
    
    @Published var prompt: String = ""
    var isValid: AnyPublisher<Bool, Never> {
        $prompt.map { !$0.isEmpty }.eraseToAnyPublisher()
    }
    let urlResult = PassthroughSubject<[String], Never>()
    
    func callAPI() {
        ChatGPTAPI.shared.test(description: prompt) { [weak self] urls in
            self?.urlResult.send(urls)
        }
    }
}
