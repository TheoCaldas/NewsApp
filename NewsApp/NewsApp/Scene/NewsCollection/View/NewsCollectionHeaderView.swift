//
//  NewsCollectionHeaderView.swift
//  NewsApp
//
//  Created by Theo Necyk Agner Caldas on 14/05/24.
//

import UIKit

class NewsCollectionHeaderView: UICollectionReusableView, BaseView{
    
    static let id = "header"
    
    let collectionLabel = UILabel()
    let searchBar = UISearchBar()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        addSubview(collectionLabel)
        addSubview(searchBar)
    }
}

extension NewsCollectionHeaderView{
    func setupStyles() {
        // LABEL
        collectionLabel.font = UIFont(name: "Jost-Regular", size: 40)
        collectionLabel.textColor = .primary
        collectionLabel.numberOfLines = 1
        collectionLabel.text = "Recentes"
        collectionLabel.textAlignment = .center
        
        // SEARCH BAR
        searchBar.setColors(background: .background, bar: .tertiary, textIcons: .primary)
        searchBar.searchTextField.font = UIFont(name: "Jost-Regular", size: 18)
        searchBar.setPlaceholder("o que quer descobrir?", color: .secondary)
    }
    
}

extension NewsCollectionHeaderView{
    func setupConstraints() {
        // LABEL
        collectionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionLabel.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 30),
            collectionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30),
        ])
        
        // SEARCH BAR
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
        ])
    }
}
