//
//  NewsCollectionViewController.swift
//  NewsApp
//
//  Created by Theo Necyk Agner Caldas on 14/05/24.
//

import UIKit

protocol NewsCollectionViewControllerInput: AnyObject {
    func showArticles(_ articles: [Article])
    func showFailure(with message: String)
}

protocol NewsCollectionViewControllerOutput: AnyObject {
    func searchArticles(by keyword: String)
}

class NewsCollectionViewController: UIViewController, BaseView {
    
    var interactor: NewsCollectionInteractorInput?
    var router: NewsCollectionRouter?
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    var articlesMock = ["1", "2", "3", "4", "5", "6", "7", "8", "9"] {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    private let spaceOffset: CGFloat = 15
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(NewsCollectionSmallCell.self, forCellWithReuseIdentifier: NewsCollectionSmallCell.id)
        collectionView.register(NewsCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: NewsCollectionHeaderView.id)
        
        setupView()
    }
    
    func addSubviews() {
        view.addSubview(collectionView)
    }
}

extension NewsCollectionViewController{
    func setupStyles() {
        // VIEW
        view.backgroundColor = .background
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        // COLLECTION VIEW
        collectionView.backgroundColor = .background
    }
}

extension NewsCollectionViewController{
    func setupConstraints() {
        // COLLECTION VIEW
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: spaceOffset),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: spaceOffset),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -spaceOffset),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -spaceOffset)
        ])
    }
}

// MARK: - Collection View Data Source Implementation
extension NewsCollectionViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCollectionSmallCell.id, for: indexPath) as? NewsCollectionSmallCell{
            cell.title.text = articlesMock[indexPath.row]
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articlesMock.count
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
        return CGSize(width: view.frame.width, height: view.frame.width / 2)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.showsVerticalScrollIndicator = false
    }
}

// MARK: - Collection View Delegate Flow Layout Implementation
extension NewsCollectionViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let w = view.frame.width / 2 - (1.5 * spaceOffset)
        return CGSize(width: w, height: w)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        // Affects vertically
        return spaceOffset
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print(articlesMock[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? NewsCollectionSmallCell{
            cell.updateColor(true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? NewsCollectionSmallCell{
            cell.updateColor(false)
        }
    }
}

// MARK: - Search Bar Delegate Implementation
extension NewsCollectionViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.articlesMock.removeAll()
        if let text = searchBar.text{
            interactor?.searchArticles(by: text)
        }
    }
}

// MARK: - NewsCollection View Controller Input Implementation
extension NewsCollectionViewController: NewsCollectionViewControllerInput{
    func showArticles(_ articles: [Article]) {
        self.articlesMock = articles.map { $0.title }
    }
    
    func showFailure(with message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Sem resultados", message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }
}
