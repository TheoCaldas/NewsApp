//
//  NewsAPIRequest.swift
//  NewsApp
//
//  Created by Theo Necyk Agner Caldas on 13/05/24.
//

import Foundation

// MARK: - NewsAPI Request Implementation
enum NewsAPIRequest: APIRequest {
    case getArticles(startDate: Date, endDate: Date, language: Language?, q: String?)

    var scheme: String {return "https"}
    
    var baseURL: String {return "newsapi.org"}
    
    var path: String {
        switch self {
            case .getArticles:
                return "/v2/everything"
        }
    }
    
    var method: String {
        switch self {
            case .getArticles:
                return "GET"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .getArticles(let startDate, let endDate, let language, let q):
            
            // Gets NewsAPI key from enviroment variable
            let env = ProcessInfo.processInfo.environment
            let newsAPIKey = env["NEWS_API_KEY"] ?? ""
            
            var queryItems: [URLQueryItem] = [
                URLQueryItem(name: "sortBy", value: "popularity"),
                URLQueryItem(name: "from", value: startDate.toISO()),
                URLQueryItem(name: "to", value: endDate.toISO()),
                URLQueryItem(name: "apiKey", value: newsAPIKey),
            ]
            
            if let language = language { //optional
                queryItems.append(URLQueryItem(name: "language", value: language.rawValue))
            }
            
            if let q = q { //optional
                queryItems.append(URLQueryItem(name: "q", value: q.lowercased()))
            }
            
            return queryItems
        }
    }
    
    var headers: [String: String] {return [:]}
}
