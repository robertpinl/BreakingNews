//
//  NewsData.swift
//  BreakingNews
//
//  Created by Robert P on 30.01.2021.
//

import Foundation

struct NewsModel: Codable {
    var status: String
    var articles: [Article]
}

struct Article: Codable {
    var title: String
    var publishedAt: String
    var url: URL?
    var urlToImage: URL?
    var source: Source
}

struct Source: Codable {
    var name: String
}
