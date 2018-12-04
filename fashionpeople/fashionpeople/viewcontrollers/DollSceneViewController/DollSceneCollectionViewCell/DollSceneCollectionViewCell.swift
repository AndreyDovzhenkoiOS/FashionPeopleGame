//
//  DollSceneCollectionViewCell.swift
//  FashionPeople
//
//  Created by Andrey on 27.06.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import UIKit

final class DollSceneCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    //MARK: - Property
    
    var completionHandler = {(_ : AnyObject, _ : UIPanGestureRecognizer) -> () in}
    var clothes: Clothes! { didSet {updateUI()}}
    var appearance: Appearance! { didSet {updateUI()}}
    
    //MARK: - Initiliazation
    
    override func awakeFromNib() {
        layer.borderWidth = 1
    }
    
    //MARK: - Functions
    
    private func updateUI() {
        addPanGestureRecognizer(in: imageView, #selector(handlePan(_:)))
        if clothes != nil {
            imageView.image = UIImage(named: clothes.image!)
        } else {
            imageView.image = UIImage(named: appearance.image!)
        }
    }
    
    @objc func handlePan(_ sender: UIPanGestureRecognizer) {
        if clothes != nil {completionHandler(clothes, sender)}
        if appearance != nil {completionHandler(appearance, sender)}
    }
}
