//
//  ArticleDetailsFactory.swift
//  NewsApp
//
//  Created by Theo Necyk Agner Caldas on 15/05/24.
//

import Foundation

protocol ArticleDetailsFactory {
    func configured(_ vc: ArticleDetailsViewController) -> ArticleDetailsViewController
}

final class DefaultArticleDetailsFactory: ArticleDetailsFactory {
    @discardableResult
    func configured(_ vc: ArticleDetailsViewController) -> ArticleDetailsViewController {
        return vc
    }
}
