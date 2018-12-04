//
//  SoundTableViewCell.swift
//  FashionPeople
//
//  Created by Andrey on 25.06.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import UIKit

final class SoundTableViewCell: UITableViewCell, SettingsProtocolCell {
    
    @IBOutlet weak var soundSwitch: UISwitch!
    
    //MARK: - Property
    
    var type: SettingCellTypes!
    var completionHandler = {() -> () in}
    var settingChange: SettingChange! {didSet {updateUI()}}
    
    //MARK: - Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
        defaultSettingTableViewCell()
    }
    
    //MARK: - Actions
    
    @IBAction func switchAction(_ sender: UISwitch) {
        settingChange.sound = sender.isOn
        completionHandler()
    }
    
    //MARK: - Functions
    
    private func updateUI() {
        soundSwitch.isOn = settingChange.sound
    }
}
