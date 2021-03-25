//
//  HomeModule.swift
//  CultureApp
//
//  Created by Eilon Krauthammer on 21/03/2021.
//

import Foundation

protocol HomeModuleOutput: AnyObject {
    func homeModuleShouldNavigateToArticlesModule(_ moduleInput: HomeModuleInput)
}

protocol HomeModuleInput: AnyObject {
    var state: HomeState { get }
}

final class HomeModule {

    public var input: HomeModuleInput {
        return viewController
    }
    
    public var output: HomeModuleOutput? {
        get {
            viewController.output
        } set {
            viewController.output = newValue
        }
    }
    
    public let viewController: HomeViewController
    
    init(state: HomeState) {
        viewController = HomeViewController(state: state)
    }
    
}
