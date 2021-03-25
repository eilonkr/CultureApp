//
//  MasterNavigationController.swift
//  CultureApp
//
//  Created by Eilon Krauthammer on 21/03/2021.
//

import UIKit

class LoaderViewController: UIViewController {

    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.tintColor = Constants.Color.activeTitle
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        let button = UIBarButtonItem(customView: activityIndicator)
        navigationItem.setRightBarButton(button, animated: false)
    }
    
    func setLoading(_ on: Bool) {
        if on {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
}
