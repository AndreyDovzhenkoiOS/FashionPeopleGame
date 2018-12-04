//
//  Extension+RegisterCell.swift
//  FashionPeople
//
//  Created by Andrey on 10.07.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import UIKit

extension UITableView {
    func registerCell(_ identifier: String) {
        let nib = UINib(nibName: identifier, bundle: nil)
        self.register(nib, forCellReuseIdentifier: identifier)
    }
}

extension UICollectionView {
    func registerCell(_ identifier: String) {
        let nib = UINib(nibName: identifier, bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: identifier)
    }
}
