//
//  SettingsViewModel.swift
//  FashionPeople
//
//  Created by Andrey on 26.06.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import UIKit

final class SettingsViewModel: NSObject, ViewModelProtocol {
    
    //MARK: - Property
    
    var setting: Setting!
    var settingChange: SettingChange!
    var modelCells: [ModelCell]!
    var completion = {(isEnabled: Bool) -> () in}
    
    //MARK: - Initialization
    
    init(setting: Setting) {
        self.setting = setting
        settingChange = SettingChange(setting, isChange: false)
        modelCells = ObjectManager.shared.getModelCells()
    }
    
    //MARK: - Fucntions

    public func updateSettingsApplication() {
        AudioPlayerManager.shared.switchSound(settingChange.sound)
        AudioPlayerManager.shared.audioPlayer.volume = settingChange.volume
        UIScreen.main.brightness = CGFloat(settingChange.brightness!)
    }
    
    public func checkChange() {
        settingChange.isChange = !settingChange.isChange
        if settingChange.isChange {completion(settingChange.isChange)}
    }
    
    public func saveSettings() {
        setting.name = settingChange.name
        setting.background = settingChange.background
        setting.volume = settingChange.volume
        setting.brightness = settingChange.brightness
        setting.sound = settingChange.sound
        DatabaseManager.shared.saveContext()
    }
}
