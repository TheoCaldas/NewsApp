//
//  NewsCollectionInteractor.swift
//  NewsApp
//
//  Created by Theo Necyk Agner Caldas on 14/05/24.
//

import Foundation

typealias NewsCollectionInteractorInput = NewsCollectionViewControllerOutput

protocol NewsCollectionInteractorOutput: AnyObject {
    func showArticles(_ articles: [Article])
    func showArticles(_ articles: [Article], count: Int)
    func showFailure(with message: String)
}

final class NewsCollectionInteractor {
    var presenter: NewsCollectionPresenterInput?
    var fetchWorker: NewsCollectionFecthWorker?
}

extension NewsCollectionInteractor: NewsCollectionInteractorInput {
    func getImage(url: String, completion: @escaping (ArticleImage) -> Void) {
        Task{
            if let image = await fetchWorker?.getImage(url: url){
                completion(image)
            }
        }
    }
    
    func searchArticles(by keyword: String) {
        Task{
            do{
                if let articles = try await fetchWorker?.getArticles(by: keyword, language: .en){
                    presenter?.showArticles(articles, count: articles.count)
                }
            } catch (let error){
                handleError(error, for: keyword)
            }
        }
    }
    
    func searchArticles(by country: Country) {
        Task{
            do{
                if let articles = try await fetchWorker?.getHeadlines(by: country){
                    presenter?.showArticles(articles)
                }
            } catch (let error){
                handleError(error, for: country.rawValue)
            }
        }
    }
    
    private func handleError(_ error: Error, for searchInput: String){
        switch error as? FetchError{
            case .isEmpty:
                presenter?.showFailure(with: "Nenhum resultado para \"\(searchInput)\"")
            case .didFail:
                presenter?.showFailure(with: "Erro de conexão")
            default:
                presenter?.showFailure(with: "Erro")
        }
    }
}
