//
//  SettingsProtocol.swift
//  FashionPeople
//
//  Created by Andrey on 28.06.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import Foundation

protocol SettingsProtocolCell {
    var settingChange: SettingChange! {get set}
    var type: SettingCellTypes! {get set}
    var completionHandler: () -> () {get set}
}

protocol ViewModelProtocol {
    var setting: Setting! {get set}
}
