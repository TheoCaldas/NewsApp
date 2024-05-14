//
//  NetworkError.swift
//  NewsApp
//
//  Created by Theo Necyk Agner Caldas on 13/05/24.
//

import Foundation

// MARK: - Network Error Model
/// Generic Network Layer errors.
enum NetworkError: LocalizedError {
    case invalidURL
    case requestFailed(statusCode: Int)
    case invalidResponse
    case decoderFailed
    case imageFailed
    
    var errorDescription: String {
        switch self {
        case .invalidURL:
            return "URL is invalid"
        case .requestFailed(let statusCode):
            return "Request failed with code \(statusCode)"
        case .invalidResponse:
            return "Response is invalid"
        case .decoderFailed:
            return "Failed to convert from json to data object"
        case .imageFailed:
            return "Failed to convert from data to image object"
        }
    }
}
