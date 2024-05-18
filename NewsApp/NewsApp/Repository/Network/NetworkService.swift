//
//  NetworkService.swift
//  NewsApp
//
//  Created by Theo Necyk Agner Caldas on 13/05/24.
//

import Foundation
import UIKit

// MARK: - Network Service Implementation
class NetworkService {
    private let urlSession: URLSession
    
    /// Initializes with an URLSession.
    /// - Parameter urlSession: Specified URLSession, uses URLSession.shared if omitted.
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    /// Handles whatever API request.
    /// - Parameters:
    ///   - returnType: What object type the responded json data will be decoded into.
    ///   - apiRequest: Specified API request.
    /// - Returns: Returns returnType object if succeed. Throws NetworkError otherwise.
    func request<T: Codable>(_ returnType: T.Type, apiRequest: APIRequest) async throws -> T {
        guard let url = apiRequest.urlComponents().url else{
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = apiRequest.method
        request.allHTTPHeaderFields = apiRequest.headers
        
        guard let requestURL = request.url else{
            throw NetworkError.invalidURL
        }

        // Executes request
        let (data, response) = try await urlSession.data(from: requestURL)
        try handleResponse(response: response)
        
        // JSON decodes into type
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(returnType, from: data)
            return decodedData
        } catch {
            throw NetworkError.decoderFailed
        }
    }
    
    /// Handles image request.
    /// - Parameter url: URL to image.
    /// - Returns: UIImage object if succeed. Throws NetworkError otherwise.
    public func requestImage(from url: String) async throws -> UIImage{
        guard let url = URL(string: url) else{
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        guard let requestURL = request.url else{
            throw NetworkError.invalidURL
        }
        
        // Executes request
        let (data, response) = try await urlSession.data(from: requestURL)
        try self.handleResponse(response: response)
        
        // Converts to UIImage
        if let image = UIImage(data: data) {
            return image
        } else {
            throw NetworkError.imageFailed
        }
    }
}

// MARK: - Private Methods
extension NetworkService{
    /// Handles possible NetworkError errors.
    /// - Parameter response: Response object, after a request execution.
    private func handleResponse(response: URLResponse) throws {
        // Is a valid http response
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        // Is not a failed request
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.requestFailed(statusCode: httpResponse.statusCode)
        }
    }
}
