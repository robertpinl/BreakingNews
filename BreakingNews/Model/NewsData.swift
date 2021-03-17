//
//  NewsData.swift
//  BreakingNews
//
//  Created by Robert P on 30.01.2021.
//

import Foundation

struct NewsData: Codable {
    var status: String
    var articles: [Articles]
}

struct Articles: Codable {
    var title: String
    var publishedAt: String
    var url: URL?
    var urlToImage: URL?
    var source: Source
}

struct Source: Codable {
    var name: String
}
