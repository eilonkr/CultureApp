//
//  AppCoordinator.swift
//  CultureApp
//
//  Created by Eilon Krauthammer on 21/03/2021.
//

import UIKit
import EKSwiftSuite

final class AppCoordinator: BaseCoordinator<UINavigationController> {
    
    private let window: UIWindow
    
    private let homeModule: HomeModule
    
    init(windowScene: UIWindowScene) {
        self.window = UIWindow(windowScene: windowScene)
        
        let state = HomeState()
        self.homeModule = HomeModule(state: state)
        let navigationController = UINavigationController(rootViewController: homeModule.viewController)
        navigationController.navigationBar.prefersLargeTitles = true
        super.init(rootViewController: navigationController)
        window.rootViewController = navigationController
        
        self.homeModule.output = self
    }

    override func start() {
        window.makeKeyAndVisible()
    }
    
    private func startArticlesCoordinator() {
        let articlesCoordinator = ArticlesCoordinator(rootViewController: rootViewController)
        articlesCoordinator.output = self
        articlesCoordinator.start()
    }
}

extension AppCoordinator: HomeModuleOutput {
    func homeModuleShouldNavigateToArticlesModule(_ moduleInput: HomeModuleInput) {
        startArticlesCoordinator()
    }
}

extension AppCoordinator: ArticlesCoordinatorOutput {
    func articlesCoordinatorDidFinish(_ coordinator: ArticlesCoordinator) {
        
    }
}
