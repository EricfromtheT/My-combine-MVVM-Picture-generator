//
//  PicViewModel.swift
//  My combine AI picture
//
//  Created by 孔令傑 on 2023/2/8.
//

import Foundation
import Combine

final class PicViewModel {
    @Published var prompt: String = "" {
        didSet {
            if prompt.isEmpty { isValid = false } else { isValid = true }
        }
    }
    @Published var isValid = false
    let urlResult = PassthroughSubject<[String], Never>()
    
    func callAPI() {
        ChatGPTAPI.shared.fetchImageData(description: prompt) { [weak self] completion in
            switch completion {
            case .success(let urls):
                self?.urlResult.send(urls)
            case .failure(let error):
                print(error)
            }
        }
    }
}
