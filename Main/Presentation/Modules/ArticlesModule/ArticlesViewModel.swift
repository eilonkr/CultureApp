//
//  ArticlesViewModel.swift
//  CultureApp
//
//  Created by Eilon Krauthammer on 22/03/2021.
//

import Foundation

struct ArticlesViewModel: Equatable {
    
    let title: String
    let isLoading: Bool
    
    init(state: ArticlesState) {
        self.title = state.title
        self.isLoading = state.isLoading
    }
    
}
