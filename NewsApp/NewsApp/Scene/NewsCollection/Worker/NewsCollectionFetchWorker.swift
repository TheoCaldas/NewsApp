//
//  NewsCollectionFetchWorker.swift
//  NewsApp
//
//  Created by Theo Necyk Agner Caldas on 14/05/24.
//

import Foundation

// MARK: - NewsCollection Fecth Worker Protocol
protocol NewsCollectionFecthWorker {
    func getArticles(by keyword: String, from startDate: Date, to endDate: Date, language: Language) async throws -> [Article]
    
    func getArticles(by keyword: String, language: Language) async throws -> [Article]
    
    func getArticles(by keyword: String, from startDate: Date, to endDate: Date) async throws -> [Article]
    
    func getHeadlines(by country: Country) async throws -> [Article]
    
    func getImage(url: String) async -> ArticleImage?
}

enum FetchError: Error {
    case isEmpty
    case didFail
}

final class NewsCollectionFecth {
    private let repo: NewsRepository

    init(repo: NewsRepository) {
        self.repo = repo
    }
}

// MARK: - NewsCollection Fecth Worker Implementation
extension NewsCollectionFecth: NewsCollectionFecthWorker {
    func getArticles(by keyword: String, from startDate: Date, to endDate: Date, language: Language) async throws -> [Article] {
        return try await self.fetch(by: keyword, from: startDate, to: endDate, language: language)
    }
    
    func getArticles(by keyword: String, language: Language) async throws -> [Article] {
        return try await self.fetch(by: keyword, from: Date.dayBeforeYesterday, to: Date.now, language: language)
    }
    
    func getArticles(by keyword: String, from startDate: Date, to endDate: Date) async throws -> [Article] {
        return try await self.fetch(by: keyword, from: startDate, to: endDate, language: nil)
    }
    
    func getHeadlines(by country: Country) async throws -> [Article] {
        var articles = [Article]()
        do {
            articles = try await self.repo.getHeadlines(country: country)
        } catch {
            throw FetchError.didFail
        }
        if articles.isEmpty{
            throw FetchError.isEmpty
        }
        return articles
    }
    
    func getImage(url: String) async -> ArticleImage? {
        do{
            let image = try await NetworkService().requestImage(from: url)
            return ArticleImage(image: image)
        } catch {
            return nil
        }
    }
}

// MARK: - Private Methods
extension NewsCollectionFecth{
    
    private func fetch(by keyword: String, from startDate: Date, to endDate: Date, language: Language?) async throws -> [Article]{
        
        var articles = [Article]()
        do {
            articles = try await self.repo.getArticles(
                from: startDate,
                to: endDate,
                language: language,
                keyword: keyword
            )
        } catch {
            throw FetchError.didFail
        }
        if articles.isEmpty{
            throw FetchError.isEmpty
        }
        return articles
    }
}
