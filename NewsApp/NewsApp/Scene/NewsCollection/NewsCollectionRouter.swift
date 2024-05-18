//
//  NewsCollectionRouter.swift
//  NewsApp
//
//  Created by Theo Necyk Agner Caldas on 15/05/24.
//

import Foundation

protocol NewsCollectionRouter {
    func pushArticleDetail(article: Article, image: ArticleImage?)
}

final class NewsCollectionNavigationRouter {
    weak var source: NewsCollectionViewController?

    private let sceneFactory: NewsCollectionFactory

    init(sceneFactory: NewsCollectionFactory) {
        self.sceneFactory = sceneFactory
    }
}

extension NewsCollectionNavigationRouter: NewsCollectionRouter {
    
    func pushArticleDetail(article: Article, image: ArticleImage?) {
        let factory = DefaultArticleDetailsFactory()
        let configured = factory.configured(ArticleDetailsViewController())
        configured.article = article
        if let image = image{
            configured.detailsView.image.image = image.image
        }
        source?.navigationController?.present(configured, animated: true)
    }
}
