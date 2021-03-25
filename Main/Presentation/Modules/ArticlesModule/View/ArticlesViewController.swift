//
//  ArticlesViewController.swift
//  CultureApp
//
//  Created by Eilon Krauthammer on 22/03/2021.
//

import UIKit
import EKSwiftSuite

protocol ArticlesViewInput: AnyObject {
    var dataSource: CollectionViewDataSource<ArticleCell> { get }
    func update(with viewModel: ArticlesViewModel)
}

protocol ArticlesViewOutput: AnyObject {
    func viewLoaded()
    func shouldFinish()
}

final class ArticlesViewController: LoaderViewController {
    
    @IBOutlet weak var articlesCollectionView: UICollectionView!
    
    private var output: ArticlesViewOutput?
    private var viewModel: ArticlesViewModel
    
    lazy var dataSource = CollectionViewDataSource<ArticleCell>(reuseIdentifier: cellIdentifier)
    
    private let cellIdentifier = "ArticleCell"

    init(viewModel: ArticlesViewModel, output: ArticlesViewOutput) {
        self.viewModel = viewModel
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.title
        configureCollectionView()
        output?.viewLoaded()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        output?.shouldFinish()
    }
    
    // MARK: - Configuration
    
    private func configureCollectionView() {
        let estimatedCellSize = CGSize(width: UIScreen.main.bounds.width * 0.9, height: 500.0)
        (articlesCollectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.estimatedItemSize = estimatedCellSize
        
        articlesCollectionView.register(UINib(nibName: "ArticleCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        articlesCollectionView.dataSource = dataSource
        articlesCollectionView.delegate = self
        dataSource.onChange = { [unowned self] in
            articlesCollectionView.reloadData()
        }
    }
}

extension ArticlesViewController: ArticlesViewInput, ForceViewUpdate {
    func update(with viewModel: ArticlesViewModel) {
        update(new: viewModel, old: self.viewModel, keyPath: \.isLoading, force: false) { isLoading in
            setLoading(isLoading)
        }
        
        self.viewModel = viewModel
    }
}

extension ArticlesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        UIView.animate(withDuration: 0.25) {
            cell?.transform = .evenScale(0.95)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        UIView.animate(withDuration: 0.25) {
            cell?.transform = .identity
        }
    }
}
