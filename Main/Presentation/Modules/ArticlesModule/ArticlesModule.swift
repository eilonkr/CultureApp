//
//  ArticlesModule.swift
//  CultureApp
//
//  Created by Eilon Krauthammer on 22/03/2021.
//

import Foundation

protocol ArticlesModuleOutput: AnyObject {
    func articlesModuleDidFinish(_ moduleInput: ArticlesModuleInput)
}

protocol ArticlesModuleInput: AnyObject {
    var state: ArticlesState { get }
    func update()
}

final class ArticlesModule {

    public var input: ArticlesModuleInput {
        return presenter
    }
    
    public var output: ArticlesModuleOutput? {
        get {
            presenter.output
        } set {
            presenter.output = newValue
        }
    }
    
    public let viewController: ArticlesViewController
    private let presenter: ArticlesPresenter
    
    init(state: ArticlesState) {
        self.presenter = ArticlesPresenter(state: state)
        let viewModel = ArticlesViewModel(state: state)
        self.viewController = ArticlesViewController(viewModel: viewModel, output: presenter)
        
        presenter.view = viewController
    }
    
}
