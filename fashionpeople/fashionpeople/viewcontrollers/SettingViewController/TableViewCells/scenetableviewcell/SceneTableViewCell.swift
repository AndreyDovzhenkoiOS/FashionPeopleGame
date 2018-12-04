//
//  SceneTableViewCell
//  FashionPeople
//
//  Created by Andrey on 25.06.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import UIKit

final class SceneTableViewCell: UITableViewCell, SettingsProtocolCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Property
    
    var viewModel: SceneTableCellViewModel!
    var type: SettingCellTypes!
    var completionHandler = {() -> () in}
    var settingChange: SettingChange!{
        didSet{
            viewModel = SceneTableCellViewModel(settingChange: settingChange)
            viewModelCompletionHandler()
        }
    }
    
    //MARK: - Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
        defaultSetting()
    }
}

//MARK: - Functions

extension SceneTableViewCell{
    
    private func defaultSetting() {
        defaultSettingTableViewCell()
        collectionView.registerCell(SceneCollectionViewCell.identifier)
    }

    private func viewModelCompletionHandler() {
        viewModel.completionHandler = {
            self.settingChange.background = $0
            self.collectionView.reloadData()
            self.completionHandler()
        }
    }
}

//MARK: - CollectionView

extension SceneTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    //MARK: - CollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.modelBackgrounds.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SceneCollectionViewCell.identifier, for: indexPath) as! SceneCollectionViewCell
        cell.modelBackground = viewModel.modelBackgrounds[indexPath.row]
        return cell
    }
    
    //MARK: - CollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.choiceBackground(indexPath.row)
    }
    
    //MARK: - CollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = frame.width / 5.3
        let width = frame.width / 3
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
}
