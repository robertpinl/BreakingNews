//
//  APIService.swift
//  BreakingNews
//
//  Created by Robert Pinl on 30.01.2021.
//

import Foundation

struct NewsAPI {
    
    func fetchAPI(with urlString: String, completion: @escaping ([Articles]) -> Void) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error.debugDescription)
                    return
                }
                if let safeData = data {
                    let decoder = JSONDecoder()
                    do {
                        let news = try decoder.decode(NewsData.self, from: safeData).articles
                        completion(news)
                    } catch {
                        print(error)
                    }
                }
            }
            task.resume()
        }
    }
}


