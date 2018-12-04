//
//  MainViewModel.swift
//  FashionPeople
//
//  Created by Andrey on 26.06.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import UIKit

final class MainViewModel: NSObject, ViewModelProtocol {
    
    //MARK: - Property
    var completionHandler = {(_ :String) -> () in}
    var setting: Setting!
    
    //MARK: - Initialization
    
    init(setting: Setting) {
        self.setting = setting
    }
    
    //MARK: - Functions
    
    public func startSound() {
        AudioPlayerManager.shared.setMusic(Constants.Sounds.names.main,
                                           Constants.Sounds.types.mp3, -1)
    }
    
    public func soundSwitchAction() {
        setting.sound = !setting.sound
        DatabaseManager.shared.saveContext()
        updateSound()
    }
    
    public func updateSound() {
        AudioPlayerManager.shared.switchSound(setting.sound)
        completionHandler(getNameImage())
    }
    
    public func updateSettingsApplication() {
        AudioPlayerManager.shared.switchSound(setting.sound)
        AudioPlayerManager.shared.audioPlayer.volume = setting.volume
        UIScreen.main.brightness = CGFloat(setting.brightness)
    }
    
    private func getNameImage() -> String{
        if setting.sound {
            return Constants.ImageStrings.soundOn
        } else {
            return Constants.ImageStrings.soundOff
        }
    }
}
