//
//  NewsAPIRepositoryTests.swift
//  NewsAppTests
//
//  Created by Theo Necyk Agner Caldas on 14/05/24.
//

import XCTest
@testable import NewsApp

final class NewsAPIRepositoryTests: XCTestCase {
    
    let newsRepo = NewsAPIRepository()
    
    // MARK: - Valid Tests
    func testValidArticles() async throws {
        let articles = try await self.newsRepo.getArticles(
            from: Date.yesterday,
            to: Date.now,
            language: .pt,
            keyword: "neymar"
        )
        XCTAssertNotNil(articles)
    }
    
    func testNoLanguage() async throws {
        let articles = try await self.newsRepo.getArticles(
            from: Date.yesterday,
            to: Date.now,
            language: nil,
            keyword: "neymar"
        )
        XCTAssertNotNil(articles)
    }
    
    func testValidHeadlines() async throws {
        let articles = try await self.newsRepo.getHeadlines(country: .us)
        XCTAssertNotNil(articles)
    }
    
    // MARK: - Invalid Tests
    func testInvalidDate() async throws {
        do {
            let _ = try await self.newsRepo.getArticles(
                from: Date.fromISO("2001-05-13T15:33:37Z")!,
                to: Date.fromISO("2000-05-13T15:33:37Z")!,
                language: .pt,
                keyword: "neymar"
            )
        } catch (let error){
            if let error = error as? NetworkError{
                XCTAssertEqual(error.errorDescription, NetworkError.requestFailed(statusCode: 426).errorDescription)
                return
            }
        }
        XCTFail("Should throw error")
    }
    
    func testTooBroad() async throws {
        do {
            let _ = try await self.newsRepo.getArticles(
                from: Date.yesterday,
                to: Date.now,
                language: .pt,
                keyword: nil
            )
        } catch (let error){
            if let error = error as? NetworkError{
                XCTAssertEqual(error.errorDescription, NetworkError.requestFailed(statusCode: 400).errorDescription)
                return
            }
        }
        XCTFail("Should throw error")
    }
}
