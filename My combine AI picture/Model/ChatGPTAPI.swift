//
//  ChatGPTAPI.swift
//  My combine AI picture
//
//  Created by 孔令傑 on 2023/2/8.
//

import Foundation
import Combine

final class ChatGPTAPI {
    
    static let shared = ChatGPTAPI()
    private let picURL = URL(string: "https://api.openai.com/v1/images/generations")
    private let urlSession: URLSession
    var imagesURLPublisher = [AnyCancellable]()
    
    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer " + APIKey.shared.imageKey
        ]
        urlSession = URLSession(configuration: configuration)
    }
    
    func test(description: String, completion: @escaping ([String]) -> Void) {
        guard let url = picURL else { return print("wrong url") }
        var request = URLRequest(url: url)
        let body = ImageRequestBody(prompt: description)
        request.httpMethod = "Post"
        guard let httpBody = try? JSONEncoder().encode(body) else {
            return print("wrong with encoding")
        }
        request.httpBody = httpBody
        urlSession.dataTaskPublisher(for: request)
            .compactMap { element in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    return nil
                }
                return element.data
            }
            .decode(type: ImageResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
        // 這邊 sink 兩個 argument 都要提供是因為原始碼規定 error type 一定要是 Never 也就是不可能會出錯的情形下，sink 才會有單一 argument 的使用方式。
            .sink { _ in } receiveValue: { receivedData in
                completion(receivedData.data.map { $0.url })
            }
            .store(in: &imagesURLPublisher)
    }
    
}
