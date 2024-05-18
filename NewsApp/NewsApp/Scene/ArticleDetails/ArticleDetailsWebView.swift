//
//  ArticleDetailsWebView.swift
//  NewsApp
//
//  Created by Theo Necyk Agner Caldas on 18/05/24.
//

import Foundation
import WebKit

class ArticleDetailsWebView: UIView, BaseView {
    
    let webView = WKWebView(frame: .zero, configuration: WKWebViewConfiguration())
    var webURL: String?
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        addSubview(webView)
    }
    
    func goToWebpage(){
        guard let url = self.webURL, let url = URL(string: url) else { return }
        webView.load(URLRequest(url: url))
    }
}

extension ArticleDetailsWebView{
    func setupStyles() {
        
    }
    
}

extension ArticleDetailsWebView{
    func setupConstraints() {
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: topAnchor),
            webView.leadingAnchor.constraint(equalTo: leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
