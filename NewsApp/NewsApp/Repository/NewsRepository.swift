//
//  NewsRepository.swift
//  NewsApp
//
//  Created by Theo Necyk Agner Caldas on 13/05/24.
//

import Foundation

// MARK: - News Repository Protocol
/// Access news data.
protocol NewsRepository {
    /// Gets an array of Article objects.
    /// - Parameters:
    ///   - startDate: Result articles must be published after this.
    ///   - endDate: Result articles must be published before this.
    ///   - language: Result article must be in this language.
    ///   - q: Result article must include this keyword.
    /// - Returns: An array of Article model objects, if succeed. Throws otherwise. 
    func getArticles(from startDate: Date, to endDate: Date, language: Language?, keyword q: String?) async throws -> [Article]
    
    /// Gets an array of Article objects.
    /// - Parameter country: Result articles must be from this.
    /// - Returns: An array of Article model objects, if succeed. Throws otherwise.
    func getHeadlines(country: Country) async throws -> [Article]
}
