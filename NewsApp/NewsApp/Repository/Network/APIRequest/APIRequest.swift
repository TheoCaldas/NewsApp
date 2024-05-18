//
//  APIRequest.swift
//  NewsApp
//
//  Created by Theo Necyk Agner Caldas on 13/05/24.
//

import Foundation

// MARK: - API Request Protocol
/// Protocol to setup an API url request components.
protocol APIRequest {
    var scheme: String { get }
    var baseURL: String { get }
    var path: String { get }
    var method: String { get }
    var parameters: [URLQueryItem] { get }
    var headers: [String: String] { get }
    
    /// Creates a new request with specified components.
    /// - Returns: URLComponents object.
    func urlComponents() -> URLComponents
}

// MARK: - Default Implementation
extension APIRequest {
    /// Default implementation. Creates a new request with specified components.
    /// - Returns: URLComponents object.
    func urlComponents() -> URLComponents {
        var components = URLComponents()
        components.scheme = self.scheme
        components.host = self.baseURL
        components.path = self.path
        components.queryItems = self.parameters
        return components
    }
}
