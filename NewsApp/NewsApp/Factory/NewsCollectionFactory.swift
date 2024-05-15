//
//  NewsCollectionFactory.swift
//  NewsApp
//
//  Created by Theo Necyk Agner Caldas on 15/05/24.
//

import Foundation

protocol NewsCollectionFactory {
    func configured(_ vc: NewsCollectionViewController) -> NewsCollectionViewController
}

final class DefaultNewsCollectionFactory: NewsCollectionFactory {
    @discardableResult
    func configured(_ vc: NewsCollectionViewController) -> NewsCollectionViewController {
        let newsRepo = NewsAPIRepository()
        let fetchWorker = NewsCollectionFecth(repo: newsRepo)
        let interactor = NewsCollectionInteractor()
        let presenter = NewsCollectionPresenter()
        let router = NewsCollectionNavigationRouter(sceneFactory: self)
        router.source = vc
        presenter.viewController = vc
        interactor.presenter = presenter
        interactor.fetchWorker = fetchWorker
        vc.interactor = interactor
        vc.router = router
        return vc
    }
}
