//
//  NewsCollectionInteractor.swift
//  NewsApp
//
//  Created by Theo Necyk Agner Caldas on 14/05/24.
//

import Foundation

typealias NewsCollectionInteractorInput = NewsCollectionViewControllerOutput

protocol NewsCollectionInteractorOutput: AnyObject {
    func showArticles(_ articles: [Article])
    func showFailure(with message: String)
}

final class NewsCollectionInteractor {
    var presenter: NewsCollectionPresenterInput?
    var fetchWorker: NewsCollectionFecthWorker?
}

extension NewsCollectionInteractor: NewsCollectionInteractorInput {
    func searchArticles(by keyword: String) {
        Task{
            do{
                if let articles = try await fetchWorker?.getArticles(by: keyword, language: .en){
                    presenter?.showArticles(articles)
                }
            } catch (let error){
                switch error as? FetchError{
                case .isEmpty:
                    presenter?.showFailure(with: "No articles found for \"\(keyword)\"")
                case .didFail:
                    presenter?.showFailure(with: "Connection error")
                default:
                    presenter?.showFailure(with: "Unknown error")
                }
            }
        }
    }
}
