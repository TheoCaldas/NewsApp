//
//  NewsCollectionViewController.swift
//  NewsApp
//
//  Created by Theo Necyk Agner Caldas on 14/05/24.
//

import UIKit

protocol NewsCollectionViewControllerInput: AnyObject {
    func showArticles(_ articles: [Article], with message: String, mixedSizing: Bool)
    func showFailure(with message: String)
}

protocol NewsCollectionViewControllerOutput: AnyObject {
    func searchArticles(by keyword: String)
    func searchArticles(by country: Country)
    func getImage(url: String, completion: @escaping (ArticleImage) -> Void)
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
        
        defaultSearch()
    }
    
    func captureTextInput(_ text: String?){
        self.articles.removeAll()
        newsCollection?.updateResultsLabel()
        if let text = text{
            interactor?.searchArticles(by: text)
        }
    }
    
    func defaultSearch(){
        self.articles.removeAll()
        newsCollection?.updateResultsLabel()
        interactor?.searchArticles(by: .us)
    }
    
    func goToDetails(index: Int, image: UIImage?){
        if let image = image{
            router?.pushArticleDetail(article: articles[index], image: ArticleImage(image: image))
        } else{
            router?.pushArticleDetail(article: articles[index], image: nil)
        }
    }
}

extension NewsCollectionViewController: NewsCollectionViewControllerInput{
    
    func showArticles(_ articles: [Article], with message: String, mixedSizing: Bool) {
        self.articles = articles
        DispatchQueue.main.async {
            self.newsCollection?.updateResultsLabel(message)
            self.newsCollection?.updateLayout(articles: articles, mixedSizing: mixedSizing)
        }
    }
    
    func showFailure(with message: String) {
        DispatchQueue.main.async {
            self.newsCollection?.updateResultsLabel(message)
        }
    }
}
