//
//  ApiManager.swift
//  BreakingNews
//
//  Created by Robert Pinl on 30.01.2021.
//

import Foundation

struct ApiManager {
    
    func fetchAPI() async throws-> [Article] {
        
        guard let url = URL(string: "") else {
            throw ApiError.invalidUrl
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw ApiError.invalidResponse
        }
        
        let articles = try JSONDecoder().decode([Article].self, from: data)
        
        return articles
    }
}

enum ApiError: Error {
    case invalidUrl
    case invalidResponse
    case missingData
}


