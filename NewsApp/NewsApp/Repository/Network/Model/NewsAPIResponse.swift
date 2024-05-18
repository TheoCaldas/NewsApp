//
//  NewsAPIResponse.swift
//  NewsApp
//
//  Created by Theo Necyk Agner Caldas on 14/05/24.
//

import Foundation

// MARK: - NewsAPI Response Model
/// Based on NewsAPI response json object.
struct NewsAPIResponse: Codable {
    let articles: [NewsAPIArticle]
}

struct NewsAPIArticle: Codable {
    var title: String?
    var description: String?
    var author: String?
    var publishDate: String?
    var content: String?
    var imageURL: String?
    var source: NewsAPISource
    var sourceURL: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case description
        case author
        case publishDate = "publishedAt"
        case content
        case imageURL = "urlToImage"
        case source
        case sourceURL = "url"
    }
}

struct NewsAPISource: Codable {
    var id: String?
    var name: String?
}
