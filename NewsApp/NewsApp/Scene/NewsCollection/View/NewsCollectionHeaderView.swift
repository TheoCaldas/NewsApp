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
    let resultsLabel = UILabel()
    let searchBar = UISearchBar()
    
    private let spaceOffset: CGFloat = 30
    private let defaultLabelText = "Recentes"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        addSubview(collectionLabel)
        addSubview(resultsLabel)
        addSubview(searchBar)
    }
    
    func resetLabel(){
        collectionLabel.text = defaultLabelText
        resultsLabel.text = ""
    }
}

extension NewsCollectionHeaderView{
    func setupStyles() {
        // COLLECTION LABEL
        collectionLabel.font = UIFont(name: "Jost-Regular", size: 40)
        collectionLabel.textColor = .primary
        collectionLabel.numberOfLines = 1
        collectionLabel.text = defaultLabelText
        collectionLabel.textAlignment = .center
        
        // RESULTS LABEL
        resultsLabel.font = UIFont(name: "Jost-Regular", size: 20)
        resultsLabel.textColor = .secondary
        resultsLabel.numberOfLines = 1
        resultsLabel.text = ""
        resultsLabel.textAlignment = .center
        
        // SEARCH BAR
        searchBar.setColors(background: .background, bar: .tertiary, textIcons: .primary)
        searchBar.searchTextField.font = UIFont(name: "Jost-Regular", size: 18)
        searchBar.setPlaceholder("o que quer descobrir?", color: .secondary)
    }
    
}

extension NewsCollectionHeaderView{
    func setupConstraints() {
        
        // SEARCH BAR
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: topAnchor, constant: spaceOffset * 2),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: spaceOffset),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -spaceOffset),
        ])
        
        // COLLECTION LABEL
        collectionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionLabel.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: spaceOffset / 2),
            collectionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionLabel.bottomAnchor.constraint(equalTo: resultsLabel.topAnchor),
        ])
        
        // COLLECTION LABEL
        resultsLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            resultsLabel.topAnchor.constraint(equalTo: collectionLabel.bottomAnchor),
            resultsLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            resultsLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            resultsLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -spaceOffset / 2),
        ])
    }
}
