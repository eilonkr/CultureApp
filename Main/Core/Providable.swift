//
//  ItemCell.swift
//  CultureApp
//
//  Created by Eilon Krauthammer on 22/03/2021.
//

import UIKit

protocol Providable {
    associatedtype Item
    func provide(_ item: Item)
}
