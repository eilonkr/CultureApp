//
//  HomeViewController.swift
//  CultureApp
//
//  Created by Eilon Krauthammer on 21/03/2021.
//

import UIKit
import EKSwiftSuite

final class HomeViewController: UIViewController, HomeModuleInput {
    
    @IBOutlet weak var showArticlesButton: SpringButton!
    
    // MARK: - Properties

    let state: HomeState
    
    weak var output: HomeModuleOutput?
    
    // MARK: - Life Cycle & Events
    
    init(state: HomeState) {
        self.state = state
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.state = .init()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureDesign()
    }
    
    @objc private func showArticlesTapped() {
        output?.homeModuleShouldNavigateToArticlesModule(self)
    }
    
    // MARK: - Configuration
    
    private func configure() {
        self.title = state.title
        showArticlesButton.addTarget(self, action: #selector(showArticlesTapped), for: .touchUpInside)
    }

    private func configureDesign() {
        showArticlesButton.roundCorners(to: .rounded)
        showArticlesButton.applyShadow(
            color: UIColor.black,
            radius: 10.0,
            opacity: 0.09,
            offsetY: 1.5,
            offsetX: 0
        )
    }
}


