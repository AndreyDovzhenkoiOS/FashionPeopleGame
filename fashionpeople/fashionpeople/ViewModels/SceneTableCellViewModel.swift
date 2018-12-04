//
//  SceneTableCellViewModel.swift
//  FashionPeople
//
//  Created by Andrey on 26.06.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import UIKit

final class SceneTableCellViewModel: NSObject {
    
    //MARK: - Property
    
    var settingChange: SettingChange!
    var modelBackgrounds: [ModelBackground] = []
    var completionHandler = {(_ : String) -> () in}
    
    //MARK: - Initialization
    
    init(settingChange: SettingChange!) {
        super.init()
        self.settingChange = settingChange
        modelBackgrounds = ObjectManager.shared.getModelBackgrounds(settingChange)
    }
    
    //MARK: - Functions
    
    public  func choiceBackground(_ index: Int) {
        resetModelBackgroundClicks()
        let modelBackground = modelBackgrounds[index]
        modelBackground.click = !modelBackground.click
        completionHandler(modelBackground.background)
    }
    
    private func resetModelBackgroundClicks() {
        modelBackgrounds.forEach {$0.click = false}
    }
}
