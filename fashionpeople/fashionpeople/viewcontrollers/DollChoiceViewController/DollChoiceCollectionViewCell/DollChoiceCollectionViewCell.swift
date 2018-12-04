//
//  DollChoiceCollectionViewCell.swift
//  FashionPeople
//
//  Created by Andrey on 26.06.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import UIKit

final class DollChoiceCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var accessView: UIView!
    
    var doll: Doll! {didSet {updateUI()}}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderWidth = 1
    }
    
    func updateUI() {
        imageView.image = UIImage(named: doll.image!)
        accessView.isHidden = doll.access ? true : false
    }
}
