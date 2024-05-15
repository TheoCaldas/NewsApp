//
//  NewsCollectionView.swift
//  NewsApp
//
//  Created by Theo Necyk Agner Caldas on 15/05/24.
//

import UIKit

class NewsCollectionView: UIView, BaseView {
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    var bottomAlphaView = GradientAlphaView(up: true)
    var topAlphaView = GradientAlphaView(up: false)
    
    weak var vc: NewsCollectionViewController?
    
    private let cellOffset: CGFloat = 15
    private let alphaLayersHeight: CGFloat = 170
    
    init(_ vc: NewsCollectionViewController) {
        self.vc = vc
        super.init(frame: .zero)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(NewsCollectionSmallCellView.self, forCellWithReuseIdentifier: NewsCollectionSmallCellView.id)
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
            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: cellOffset * 2),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: cellOffset),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -cellOffset),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -cellOffset)
        ])
        
        // ALPHA
        bottomAlphaView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomAlphaView.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomAlphaView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomAlphaView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomAlphaView.heightAnchor.constraint(equalToConstant: alphaLayersHeight)
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
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCollectionSmallCellView.id, for: indexPath) as? NewsCollectionSmallCellView{
            cell.title.text = vc?.articles[indexPath.row].title
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
            }
            return header
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: frame.width, height: frame.width / 2)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.showsVerticalScrollIndicator = false
    }
}

// MARK: - Collection View Delegate Flow Layout Implementation
extension NewsCollectionView: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let w = frame.width / 2 - (1.5 * cellOffset)
        return CGSize(width: w, height: w)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        // Affects vertically
        return cellOffset
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print(articles[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? NewsCollectionSmallCellView{
            cell.updateColor(true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? NewsCollectionSmallCellView{
            cell.updateColor(false)
        }
    }
}

// MARK: - Search Bar Delegate Implementation
extension NewsCollectionView: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        vc?.captureTextInput(searchBar.text)
        getHeaderView()?.collectionLabel.text = "busca \"\(searchBar.text ?? "")\"..."
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            getHeaderView()?.resetLabel()
        }
    }
}

// MARK: - Private Methods
extension NewsCollectionView{
    private func getHeaderView() -> NewsCollectionHeaderView? {
        if let headerView = collectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: IndexPath(item: 0, section: 0)) as? NewsCollectionHeaderView {
            return headerView
        }
        return nil
    }
}
