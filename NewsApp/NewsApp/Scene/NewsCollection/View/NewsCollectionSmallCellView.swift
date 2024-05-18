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
    let author = UILabel()
    let image = UIImageView()
    
    private let minImageAlpha: CGFloat = 0
    private let maxImageAlpha: CGFloat = 0.9
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        addSubview(title)
        addSubview(author)
        addSubview(image)
    }
    
    func animateImage(hide: Bool, duration: TimeInterval? = nil){
        let initialAlpha: CGFloat = (hide) ? maxImageAlpha : minImageAlpha
        let finalAlpha: CGFloat = (hide) ? minImageAlpha : maxImageAlpha
        
        image.alpha = initialAlpha
        UIView.animate(
            withDuration: duration ?? 0.2,
            delay: 0,
            options: [.curveEaseOut],
            animations: {
                self.image.alpha = finalAlpha
        })
    }
    
    func updateColor(_ isHighlited: Bool){
        backgroundColor = (isHighlited) ? .tertiary : .cellBackground
    }
}

extension NewsCollectionSmallCellView{
    func setupStyles() {
        backgroundColor = .cellBackground
        
        layer.cornerRadius = 25
        layer.masksToBounds = true
        
        // TITLE
        title.font = UIFont(name: "Jost-Regular", size: 17)
        title.textColor = .primary
        title.numberOfLines = 5
        title.textAlignment = .left
        
        //AUTHOR
        author.font = UIFont(name: "Jost-Italic", size: 16)
        author.textColor = .secondary
        author.numberOfLines = 1
        author.textAlignment = .left
        
        //IMAGE
        image.image = UIImage(named: "placeholder")
        image.layer.cornerRadius = 25
        image.layer.masksToBounds = true
        image.alpha = minImageAlpha
    }
}

extension NewsCollectionSmallCellView{

    func setupConstraints() {
        // TITLE
        title.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
//            title.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 10),
        ])
        
        //AUTHOR
        author.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
//            author.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            author.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            author.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            author.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        ])
        
        //IMAGE
        image.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor),
            image.leadingAnchor.constraint(equalTo: leadingAnchor),
            image.trailingAnchor.constraint(equalTo: trailingAnchor),
            image.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])       
    }
}
