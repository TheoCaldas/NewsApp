//
//  NewsCollectionRouter.swift
//  NewsApp
//
//  Created by Theo Necyk Agner Caldas on 15/05/24.
//

import Foundation

protocol NewsCollectionRouter {
    
}

final class NewsCollectionNavigationRouter {
    weak var source: NewsCollectionViewController?

    private let sceneFactory: NewsCollectionFactory

    init(sceneFactory: NewsCollectionFactory) {
        self.sceneFactory = sceneFactory
    }
}

extension NewsCollectionNavigationRouter: NewsCollectionRouter {
    
}
