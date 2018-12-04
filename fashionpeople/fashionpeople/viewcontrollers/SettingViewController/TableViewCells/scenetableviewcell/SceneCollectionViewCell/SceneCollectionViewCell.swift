//
//  SceneCollectionViewCell
//  FashionPeople
//
//  Created by Andrey on 25.06.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import UIKit

final class SceneCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var sceneImageView: UIImageView!
    
    //MARK: - Property
    
    var modelBackground: ModelBackground!{
        didSet {updateUI()}
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = frame.height / 8
    }
    
    private func updateUI() {
        sceneImageView.image = UIImage(named: modelBackground.background)
        checkClick()
    }
    
    private func checkClick() {
        sceneImageView.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        sceneImageView.layer.borderWidth = modelBackground.click ? 3 : 0
    }
}
