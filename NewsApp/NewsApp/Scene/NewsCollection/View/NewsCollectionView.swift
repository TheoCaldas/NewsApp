//
//  NewsCollectionView.swift
//  NewsApp
//
//  Created by Theo Necyk Agner Caldas on 15/05/24.
//

import UIKit

class NewsCollectionView: UIView, BaseView {
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: NewsCollectionView.initialLayout())
    
    var bottomAlphaView = GradientAlphaView(up: true)
    var topAlphaView = GradientAlphaView(up: false)
    
    weak var vc: NewsCollectionViewController?
    weak var header: NewsCollectionHeaderView?
    
    private let cellOffset: CGFloat = 15
    private let alphaLayersHeight: CGFloat = 170
    
    private var displayedCells = [Int]()
    private var smalCells = [Int]()
    
    init(_ vc: NewsCollectionViewController) {
        self.vc = vc
        super.init(frame: .zero)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(NewsCollectionSmallCellView.self, forCellWithReuseIdentifier: NewsCollectionSmallCellView.id)
        collectionView.register(NewsCollectionBigCellView.self, forCellWithReuseIdentifier: NewsCollectionBigCellView.id)
        collectionView.register(NewsCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: NewsCollectionHeaderView.id)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        addSubview(collectionView)
        addSubview(bottomAlphaView)
        addSubview(topAlphaView)
    }
    
    func updateResultsLabel(_ text: String? = ""){
        header?.resultsLabel.text = text
        displayedCells.removeAll()
        smalCells.removeAll()
    }
    
    func updateLayout(articles: [Article], mixedSizing: Bool){
        if (mixedSizing){
            collectionView.collectionViewLayout = mixedLayout(articles: articles)
        } else{
            collectionView.collectionViewLayout = NewsCollectionView.initialLayout()
        }
    }
}

extension NewsCollectionView{
    func setupStyles() {
        // VIEW
        backgroundColor = .background
        vc?.navigationController?.setNavigationBarHidden(true, animated: false)
        
        // COLLECTION VIEW
        collectionView.backgroundColor = .background
        
        // ALPHA
        bottomAlphaView.backgroundColor = .background
        topAlphaView.backgroundColor = .background
    }
}

extension NewsCollectionView{
    func setupConstraints() {
        // COLLECTION VIEW
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 15),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        // ALPHA
        bottomAlphaView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomAlphaView.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomAlphaView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomAlphaView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomAlphaView.heightAnchor.constraint(equalToConstant: alphaLayersHeight * 0.5)
       ])
        
        topAlphaView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAlphaView.topAnchor.constraint(equalTo: topAnchor),
            topAlphaView.leadingAnchor.constraint(equalTo: leadingAnchor),
            topAlphaView.trailingAnchor.constraint(equalTo: trailingAnchor),
            topAlphaView.heightAnchor.constraint(equalToConstant: alphaLayersHeight)
       ])
    }
}

// MARK: - Collection View Data Source Implementation
extension NewsCollectionView: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let index = indexPath.row
        
        if smalCells.contains(index), let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCollectionSmallCellView.id, for: indexPath) as? NewsCollectionSmallCellView{
            
            if let article = vc?.articles[index]{
                cell.title.text = article.title
                cell.author.text = "por \(article.author)"
            }
            return cell
        } else if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCollectionBigCellView.id, for: indexPath) as? NewsCollectionBigCellView{

            if let article = vc?.articles[index]{
                cell.title.text = article.title
                cell.author.text = "por \(article.author)"
                cell.descript.text = article.description
                vc?.interactor?.getImage(url: article.imageURL ?? "", completion: { articleImage in
                    DispatchQueue.main.async {
                        cell.image.image = articleImage.image
                    }
                })
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vc?.articles.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: NewsCollectionHeaderView.id, for: indexPath)
            if let headerView = header as? NewsCollectionHeaderView{
                headerView.searchBar.delegate = self
                self.header = headerView
            }
            return header
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        // Cell animation
        if let cell = cell as? NewsCollectionSmallCellView {
            animateCell(cell: cell, index: indexPath.row)
        } else if let cell = cell as? NewsCollectionBigCellView{
            animateCell(cell: cell, index: indexPath.row)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: frame.width, height: frame.width * 0.6)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.showsVerticalScrollIndicator = false
    }
}

// MARK: - Collection View Delegate Flow Layout Implementation
extension NewsCollectionView: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print(articles[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? NewsCollectionSmallCellView{
            cell.updateColor(true)
        } else if let cell = collectionView.cellForItem(at: indexPath) as? NewsCollectionBigCellView{
//            cell.updateColor(true)
            cell.animateImage(hide: false)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? NewsCollectionSmallCellView{
            cell.updateColor(false)
        }else if let cell = collectionView.cellForItem(at: indexPath) as? NewsCollectionBigCellView{
//            cell.updateColor(false)
            cell.animateImage(hide: true)
        }
    }
}

// MARK: - Search Bar Delegate Implementation
extension NewsCollectionView: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        vc?.captureTextInput(searchBar.text)
        self.header?.collectionLabel.text = "busca \"\(searchBar.text ?? "")\"..."
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            self.header?.resetLabel()
            vc?.defaultSearch()
        }
    }
}

// MARK: - Private Methods
extension NewsCollectionView{
    
    private func mixedLayout(articles: [Article]) -> UICollectionViewCompositionalLayout {
        
        //ITEM
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
        )
        
        let spacing: CGFloat = 15
        item.contentInsets = .init(top: spacing, leading: 0, bottom: 0, trailing: spacing)
        
        //GROUP
        let smallGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalWidth(0.5)
            ),
            repeatingSubitem: item,
            count: 2
        )
        smallGroup.contentInsets = .init(top: 0, leading: spacing, bottom: 0, trailing: 0)

        let bigGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalWidth(0.5)
            ),
            repeatingSubitem: item,
            count: 1
        )
        bigGroup.contentInsets = .init(top: 0, leading: spacing, bottom: 0, trailing: spacing)
        
        var layoutItems: [NSCollectionLayoutGroup] = []
        
        for index in 0..<articles.count {
            if index % 3 == 0 {
                layoutItems.append(bigGroup)
            } else {
                layoutItems.append(smallGroup)
                smalCells.append(index)
            }
        }
        
        let finalGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(1.0)
            ),
            subitems: layoutItems
        )
        
        //SECTION
        let section = NSCollectionLayoutSection(group: finalGroup)
        section.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        //HEADER
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(0.6)
            ),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        header.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: spacing)
        
        section.boundarySupplementaryItems = [header]
        
        //LAYOUT
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    private static func initialLayout() -> UICollectionViewCompositionalLayout {
        //ITEM
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
        )
        let spacing: CGFloat = 15
        item.contentInsets = .init(top: spacing, leading: 0, bottom: 0, trailing: spacing)
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalWidth(0.65)
//                heightDimension: .fractionalWidth(0.5)
            ),
            repeatingSubitem: item,
            count: 1
        )
        group.contentInsets = .init(top: 0, leading: spacing, bottom: 0, trailing: spacing)
        
        //SECTION
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        //HEADER
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(0.6)
            ),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        header.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: spacing)
        section.boundarySupplementaryItems = [header]
        
        //LAYOUT
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    private func animateCell(cell: UICollectionViewCell, index: Int){
        if (!displayedCells.contains(index)){
            displayedCells.append(index)
            cell.alpha = 0.2
            cell.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            UIView.animate(
                withDuration: 0.5,
                delay: 0,
                options: [.curveEaseOut],
                animations: {
                    cell.alpha = 1
                    cell.transform = .identity
            })
        }
    }
}
