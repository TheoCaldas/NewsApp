//
//  NewsCollectionPresenter.swift
//  NewsApp
//
//  Created by Theo Necyk Agner Caldas on 15/05/24.
//

import Foundation

typealias NewsCollectionPresenterInput = NewsCollectionInteractorOutput
typealias NewsCollectionPresenterOutput = NewsCollectionViewControllerInput

final class NewsCollectionPresenter {
    weak var viewController: NewsCollectionPresenterOutput?
}

extension NewsCollectionPresenter: NewsCollectionPresenterInput {
    
    func showArticles(_ articles: [Article], count: Int) {
        viewController?.showArticles(articles, with: "\(count) resultados")
    }
    
    func showArticles(_ articles: [Article]) {
        viewController?.showArticles(articles, with: "")
    }
    
    func showFailure(with message: String) {
        viewController?.showFailure(with: message)
    }
}
