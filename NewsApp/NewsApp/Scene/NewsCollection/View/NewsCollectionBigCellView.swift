//
//  NewsCollectionBigCellView.swift
//  NewsApp
//
//  Created by Theo Necyk Agner Caldas on 15/05/24.
//

import UIKit

class NewsCollectionBigCellView: UICollectionViewCell, BaseView{
    
    static let id = "bigCell"
    
    let title = UILabel()
    let author = UILabel()
    let descript = UILabel()
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
        addSubview(descript)
        addSubview(image)

    }
    
    func updateColor(_ isHighlited: Bool){
        backgroundColor = (isHighlited) ? .tertiary : .cellBackground
    }
    
     func animateImage(hide: Bool){
        let initialAlpha: CGFloat = (hide) ? maxImageAlpha : minImageAlpha
        let finalAlpha: CGFloat = (hide) ? minImageAlpha : maxImageAlpha
        
        image.alpha = initialAlpha
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            options: [.curveEaseOut],
            animations: {
                self.image.alpha = finalAlpha
        })
    }
}

extension NewsCollectionBigCellView{
    func setupStyles() {
        backgroundColor = .cellBackground
        
        layer.cornerRadius = 25
        layer.masksToBounds = true
        
        // TITLE
        title.font = UIFont(name: "Jost-Regular", size: 22)
        title.textColor = .primary
        title.numberOfLines = 5
        title.textAlignment = .left
        
        //AUTHOR
        author.font = UIFont(name: "Jost-Italic", size: 18)
        author.textColor = .secondary
        author.numberOfLines = 1
        author.textAlignment = .left
        
        //DESCRIPTION
        descript.font = UIFont(name: "Jost-Regular", size: 20)
        descript.textColor = .secondary
        descript.numberOfLines = 3
        descript.textAlignment = .left
        
        //IMAGE
        image.image = UIImage(named: "placeholder")
        image.layer.cornerRadius = 25
        image.layer.masksToBounds = true
        image.alpha = minImageAlpha
    }
}

extension NewsCollectionBigCellView{

    func setupConstraints() {
        let const: CGFloat = 10
        
        // TITLE
        title.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor, constant: const),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: const),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -const),
//            title.bottomAnchor.constraint(equalTo: bottomAnchor, constant: const),
        ])

        //DESCRIPTION
        descript.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descript.topAnchor.constraint(equalTo: title.bottomAnchor, constant: const),
            descript.leadingAnchor.constraint(equalTo: leadingAnchor, constant: const),
            descript.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -const),
            descript.bottomAnchor.constraint(equalTo: author.topAnchor, constant: -const),
        ])

        //AUTHOR
        author.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
//            author.topAnchor.constraint(equalTo: topAnchor, constant: const),
            author.leadingAnchor.constraint(equalTo: leadingAnchor, constant: const),
            author.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -const),
            author.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -const),
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
