//
//  ArticleDetailsView.swift
//  NewsApp
//
//  Created by Theo Necyk Agner Caldas on 15/05/24.
//

import UIKit

class ArticleDetailsView: UIView, BaseView {
    
    weak var vc: ArticleDetailsViewController?
    
    let title = UILabel()
    let author = UILabel()
    let date = UILabel()
    let content = UILabel()
    let image = UIImageView()
    let webButton = UIButton(type: .system)
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        addSubview(title)
        addSubview(author)
        addSubview(date)
        addSubview(content)
        addSubview(image)
        addSubview(webButton)
    }
}

extension ArticleDetailsView{
    func setupStyles() {
        backgroundColor = .cellBackground
        
        // TITLE
        title.font = UIFont(name: "Jost-Regular", size: 30)
        title.textColor = .secondary
        title.numberOfLines = .max
        title.textAlignment = .left
        
        // AUTHOR
        author.font = UIFont(name: "Jost-Regular", size: 22)
        author.textColor = .primary
        author.numberOfLines = 1
        author.textAlignment = .left
        
        // DATE
        date.font = UIFont(name: "Jost-Regular", size: 22)
        date.textColor = .secondary
        date.numberOfLines = 1
        date.textAlignment = .left
        
        // CONTENT
        content.font = .systemFont(ofSize: 18, weight: .regular)
        content.textColor = .secondary
        content.numberOfLines = .max
        content.textAlignment = .justified
        
        // IMAGE
        image.image = UIImage(named: "placeholder")
        image.layer.cornerRadius = 25
        image.layer.masksToBounds = true
        
        // BUTTON
        webButton.setTitle("ler mais", for: .normal)
        webButton.tintColor = .primary
        webButton.backgroundColor = .tertiary
        webButton.layer.cornerRadius = 20
        webButton.layer.masksToBounds = true
        webButton.titleLabel?.font = UIFont.systemFont(ofSize: 19)
        webButton.addTarget(vc, action: #selector(vc?.openWeb), for: .touchUpInside)
    }
}

extension ArticleDetailsView{
    func setupConstraints() {
        
        let offset: CGFloat = 30
        
        // IMAGE
        image.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor, constant: offset * 3),
            image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            image.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -0),
            image.heightAnchor.constraint(lessThanOrEqualTo: image.widthAnchor, multiplier: 0.7)
//            title.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -offset),
        ])
        
        // TITLE
        title.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: image.bottomAnchor, constant: offset),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: offset),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -offset),
//            title.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -offset),
        ])
        
        // AUTHOR
        author.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            author.topAnchor.constraint(equalTo: title.bottomAnchor, constant: offset),
            author.leadingAnchor.constraint(equalTo: leadingAnchor, constant: offset),
            author.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -offset),
//            author.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -offset),
        ])
        
        // DATE
        date.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            date.topAnchor.constraint(equalTo: author.bottomAnchor, constant: offset * 0.3),
            date.leadingAnchor.constraint(equalTo: leadingAnchor, constant: offset),
            date.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -offset),
//            date.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -offset),
        ])
        
        // CONTENT
        content.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            content.topAnchor.constraint(equalTo: date.bottomAnchor, constant: offset),
            content.leadingAnchor.constraint(equalTo: leadingAnchor, constant: offset),
            content.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -offset),
//            content.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -offset),
        ])
        
        // BUTTON
        webButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webButton.topAnchor.constraint(equalTo: title.bottomAnchor, constant: offset),
            webButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -offset),
            webButton.widthAnchor.constraint(equalToConstant: 100),
            webButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}
