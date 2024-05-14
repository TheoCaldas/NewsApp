//
//  NewsAPIRepository.swift
//  NewsApp
//
//  Created by Theo Necyk Agner Caldas on 13/05/24.
//

import Foundation

// MARK: - NewsAPI Repository Implementation
class NewsAPIRepository: NewsRepository {
    func getArticles(from startDate: Date, to endDate: Date, language: Language?, keyword q: String?) async throws -> [Article] {
        // Creates News API Request with arguments
        let newsAPI = NewsAPIRequest.getArticles(startDate: startDate, endDate: endDate, language: language, q: q)
        
        // Makes Request and converts to News API Response object
        let responseObject = try await NetworkService().request(NewsAPIResponse.self, apiRequest: newsAPI)
        
        // Converts to Article model array
        return self.toArticleArray(responseObject)
    }
    
    func getHeadlines(country: Country) async throws -> [Article] {
        // Creates News API Request with arguments
        let newsAPI = NewsAPIRequest.getHeadlines(country: country)
        
        // Makes Request and converts to News API Response object
        let responseObject = try await NetworkService().request(NewsAPIResponse.self, apiRequest: newsAPI)
        
        // Converts to Article model array
        return self.toArticleArray(responseObject)
    }
}

// MARK: - Private Methods
extension NewsAPIRepository {
    /// Converts from NewsAPIResponse object to Article model array. The imageURL and sourceURL properties are optional.
    /// - Parameter object: A NewsAPIResponse object.
    /// - Returns: An array of Article model objects.
    private func toArticleArray(_ object: NewsAPIResponse) -> [Article] {
        return object.articles.compactMap{
            // Must have these properties, otherwise nil
            guard let title = $0.title,
                  let description = $0.description,
                  let author = $0.author,
                  let publishDate = Date.fromISO($0.publishDate ?? ""),
                  let content = $0.content,
                  let sourceName = $0.source.name
            else {
                return nil
            }
            return Article(
                title: title,
                description: description,
                author: author,
                publishDate: publishDate,
                content: content,
                imageURL: $0.imageURL,
                sourceName: sourceName,
                sourceURL: $0.sourceURL
            )
        }
    }
}
