//
//  NewsCollectionViewController.swift
//  NewsApp
//
//  Created by Theo Necyk Agner Caldas on 14/05/24.
//

import UIKit

protocol NewsCollectionViewControllerInput: AnyObject {
    func showArticles(_ articles: [Article])
    func showFailure(with message: String)
}

protocol NewsCollectionViewControllerOutput: AnyObject {
    func searchArticles(by keyword: String)
}

class NewsCollectionViewController: UIViewController {
    
    var interactor: NewsCollectionInteractorInput?
    var router: NewsCollectionRouter?
    
    var newsCollection: NewsCollectionView?
    
    var articlesMock = ["1", "2", "3", "4", "5", "6", "7", "8", "9"] {
        didSet {
            DispatchQueue.main.async {
                self.newsCollection?.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsCollection = NewsCollectionView(self)
        guard let newsCollection = newsCollection else { return }
        
        newsCollection.collectionView.dataSource = newsCollection
        newsCollection.collectionView.delegate = newsCollection
        newsCollection.collectionView.register(NewsCollectionSmallCellView.self, forCellWithReuseIdentifier: NewsCollectionSmallCellView.id)
        newsCollection.collectionView.register(NewsCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: NewsCollectionHeaderView.id)
        
        view = newsCollection
    }
    
    func captureTextInput(_ text: String?){
        self.articlesMock.removeAll()
        if let text = text{
            interactor?.searchArticles(by: text)
        }
    }
}

// MARK: - NewsCollection View Controller Input Implementation
extension NewsCollectionViewController: NewsCollectionViewControllerInput{
    func showArticles(_ articles: [Article]) {
        self.articlesMock = articles.map { $0.title }
    }
    
    func showFailure(with message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Sem resultados", message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }
}
