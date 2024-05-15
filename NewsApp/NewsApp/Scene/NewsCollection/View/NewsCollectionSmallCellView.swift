//
//  NewsCollectionSmallCellView.swift
//  NewsApp
//
//  Created by Theo Necyk Agner Caldas on 14/05/24.
//

import UIKit

class NewsCollectionSmallCellView: UICollectionViewCell, BaseView{
    
    static let id = "smallCell"
    
    let title = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        addSubview(title)
    }
    
    func updateColor(_ isHighlited: Bool){
        backgroundColor = (isHighlited) ? .tertiary : .cellBackground
    }
}

extension NewsCollectionSmallCellView{
    func setupStyles() {
        backgroundColor = .cellBackground
        
        layer.cornerRadius = 30
        layer.masksToBounds = true
        
        // TITLE
        title.font = UIFont(name: "Jost-Regular", size: 20)
        title.textColor = .primary
        title.numberOfLines = 5
        title.textAlignment = .center
        
    }
}

extension NewsCollectionSmallCellView{
    func setupConstraints() {
        title.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor),
            title.leadingAnchor.constraint(equalTo: leadingAnchor),
            title.trailingAnchor.constraint(equalTo: trailingAnchor),
            title.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
