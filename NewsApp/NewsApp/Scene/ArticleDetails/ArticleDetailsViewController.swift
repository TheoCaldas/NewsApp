//
//  ArticleDetailsViewController.swift
//  NewsApp
//
//  Created by Theo Necyk Agner Caldas on 15/05/24.
//

import UIKit

class ArticleDetailsViewController: UIViewController{
    
    var article: Article? {
        didSet{
            detailsView.title.text = article?.title
            detailsView.author.text = article?.author
            detailsView.date.text = article?.publishDate.toISO()
            detailsView.content.text = article?.content
        }
    }
    
    var detailsView = ArticleDetailsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = detailsView
        detailsView.vc = self
    }
}
