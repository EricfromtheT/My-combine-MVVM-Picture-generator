//
//  ChatGPTAPI.swift
//  My combine AI picture
//
//  Created by 孔令傑 on 2023/2/8.
//

import Foundation

final class ChatGPTAPI {
    
    static let shared = ChatGPTAPI()
    private let picURL = URL(string: "https://api.openai.com/v1/images/generations")
    private let urlSession: URLSession
    
    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer " + APIKey.shared.imageKey
        ]
        urlSession = URLSession(configuration: configuration)
    }
    
    func fetchImageData(description: String, completion: @escaping (Result<[String], Error>) -> Void) {
        guard let url = picURL else {
            return print("wrong url")
        }
        var request = URLRequest(url: url)
        request.httpMethod = "Post"
        let body = ImageRequestBody(prompt: description)
        let encoder = JSONEncoder()
        guard let httpBody = try? encoder.encode(body) else {
            return print("wrong with encoding")
        }
        request.httpBody = httpBody
        urlSession.dataTask(with: request) {
            data, response, error in
            if let error = error {
                print(error)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200,
                  let data = data
            else {
                return
            }
            let decoder = JSONDecoder()
            do {
                let data = try decoder.decode(ImageResponse.self, from: data)
                completion(.success(data.data.map{ $0.url }))
            } catch {
                print(error)
            }
        }.resume()
    }
    
}
