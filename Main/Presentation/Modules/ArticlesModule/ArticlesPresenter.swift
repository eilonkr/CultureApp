//
//  ArticlesPresenter.swift
//  CultureApp
//
//  Created by Eilon Krauthammer on 22/03/2021.
//

import Foundation

final class ArticlesPresenter {
    
    let state: ArticlesState
    
    weak var output: ArticlesModuleOutput?
    
    weak var view: ArticlesViewInput?
    
    init(state: ArticlesState) {
        self.state = state
    }
    
    private func fetchArticles() {
        state.isLoading = true
        update()
        CultureAPIManager.getArticles(then: { [weak self] result in
            guard let self = self else { return }
            self.state.isLoading = false
            self.update()
            switch result {
                case .success(let articles):
                    self.view?.dataSource.items = articles
                case .failure(let error):
                    print("Failed fetching articles with error: \n \(error)")
            }
        })
    }
}

extension ArticlesPresenter: ArticlesModuleInput {
    func update() {
        let viewModel = ArticlesViewModel(state: self.state)
        view?.update(with: viewModel)
    }
}

extension ArticlesPresenter: ArticlesViewOutput {
    func viewLoaded() {
        fetchArticles()
    }
    
    func shouldFinish() {
        output?.articlesModuleDidFinish(self)
    }
}
