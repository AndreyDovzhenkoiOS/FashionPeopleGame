//
//  SettingChange.swift
//  FashionPeople
//
//  Created by Andrey on 26.06.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import Foundation

final class SettingChange: NSObject {
    
    //MARK: - Property
    
    var name: String!
    var background: String!
    var volume: Float!
    var brightness: Float!
    var sound: Bool!
    var isChange: Bool!
    
    //MARK: - Initialization
    
    init(_ setting: Setting, isChange: Bool) {
        self.name = setting.name
        self.background = setting.background
        self.volume = setting.volume
        self.brightness = setting.brightness
        self.sound = setting.sound
        self.isChange = isChange
    }
}
