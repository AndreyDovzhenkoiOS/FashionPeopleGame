//
//  SliderTableViewCell
//  FashionPeople
//
//  Created by Andrey on 25.06.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import UIKit

final class SliderTableViewCell: UITableViewCell, SettingsProtocolCell{
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    //MARK: - Property
    
    var completionHandler = {() -> () in}
    var type: SettingCellTypes!
    var settingChange: SettingChange! {didSet{updateUI()}}
    
    //MARK: - Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
        defaultSettingTableViewCell()
    }
    
    //MARK: - Actions
    
    @IBAction func sliderAction(_ sender: UISlider) {
        setupPropertyForSettingChange(sender.value)
        completionHandler()
    }
}

//MARK: - Functions

extension SliderTableViewCell{
    
    private func updateUI()  {
        if type == .volume {
            titleLabel.text = Constants.SettingCellNames.volume
            slider.value = settingChange.volume
        } else {
            titleLabel.text = Constants.SettingCellNames.brightness
            slider.value = settingChange.brightness
        }
    }
    
    private func setupPropertyForSettingChange(_ value: Float){
        if type == .volume {
            settingChange.volume = value
        } else {
            settingChange.brightness = value
        }
    }
}
