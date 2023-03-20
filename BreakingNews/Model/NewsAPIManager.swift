//
//  APIService.swift
//  BreakingNews
//
//  Created by Robert Pinl on 30.01.2021.
//

import Foundation

struct NewsAPIManager {
    
    enum NetworkError: Error {
        case noServerResponse
//        case
    }
    
    func fetchAPI() async throws-> [Article] {
        
    }
    
    func fetchAPI(urlcompletion: @escaping (Result<[Article], Error>) -> Void) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    completion(.failure(error!))
                    return
                }
                if let safeData = data {
                    let decoder = JSONDecoder()
                    do {
                        let articles = try decoder.decode(NewsModel.self, from: safeData).articles
                        completion(.success(articles))
                    } catch {
                        print(error)
                    }
                }
            }
            task.resume()
        }
    }
}

enum ApiError: Error {
    case invalidURL
    case missingData
}


