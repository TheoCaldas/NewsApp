//
//  NetworkRepository.swift
//  NewsApp
//
//  Created by Theo Necyk Agner Caldas on 13/05/24.
//

import Foundation

protocol NetworkRepositoryProtocol {
    func fetchArticles() async throws -> [Article]
}

class NetworkRepository: NetworkRepositoryProtocol {
    let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchArticles() async throws -> [Article] {
        return try await networkService.fetchArticles()
    }
}
