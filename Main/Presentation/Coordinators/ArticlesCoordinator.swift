//
//  ArticlesCoordinator.swift
//  CultureApp
//
//  Created by Eilon Krauthammer on 22/03/2021.
//

import UIKit
import EKSwiftSuite

protocol ArticlesCoordinatorOutput: AnyObject {
    func articlesCoordinatorDidFinish(_ coordinator: ArticlesCoordinator)
}

final class ArticlesCoordinator: BaseCoordinator<UINavigationController> {

    let module: ArticlesModule
    
    weak var output: ArticlesCoordinatorOutput?
    
    override init(rootViewController: UINavigationController) {
        let state = ArticlesState()
        self.module = ArticlesModule(state: state)
        super.init(rootViewController: rootViewController)
        
        self.module.output = self
    }
    
    override func start() {
        rootViewController.pushViewController(module.viewController, animated: true)
    }
}

extension ArticlesCoordinator: ArticlesModuleOutput {
    func articlesModuleDidFinish(_ moduleInput: ArticlesModuleInput) {
        delegate?.childCoordinatorDidFinish(self)
        output?.articlesCoordinatorDidFinish(self)
    }
}
