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
    func searchArticles(by country: Country)
}

class NewsCollectionViewController: UIViewController {
    
    var interactor: NewsCollectionInteractorInput?
    var router: NewsCollectionRouter?
    
    var newsCollection: NewsCollectionView?
    
    var articles = [Article]() {
        didSet {
            DispatchQueue.main.async {
                self.newsCollection?.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newsCollection = NewsCollectionView(self)
        view = newsCollection
        self.newsCollection = newsCollection
        
        interactor?.searchArticles(by: .us)
    }
    
    func captureTextInput(_ text: String?){
        self.articles.removeAll()
        if let text = text{
            interactor?.searchArticles(by: text)
        }
    }
}

// MARK: - NewsCollection View Controller Input Implementation
extension NewsCollectionViewController: NewsCollectionViewControllerInput{
    func showArticles(_ articles: [Article]) {
        self.articles = articles
    }
    
    func showFailure(with message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Sem resultados", message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }
}
