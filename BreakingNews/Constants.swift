//
//  Constants.swift
//  BreakingNews
//
//  Created by Robert Pinl on 08.02.2021.
//

import Foundation

struct K {
    static let baseUrl = "https://newsapi.org/v2/top-headlines?"
    static let apiKey = "apiKey=\(valueForAPIKey(named: "API_KEY"))"
    
    struct Segue {
        static let detail = "GoToDetail"
        static let countrySelection = "GoToCountrySelection"
    }
}
