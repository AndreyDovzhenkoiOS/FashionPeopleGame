//
//  ObjectManager.swift
//  FashionPeople
//
//  Created by Andrey on 03.07.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import UIKit

final class ObjectManager: NSObject {
    
    static let shared = ObjectManager()
    private override init() {}
    
    //MARK: - Loaders
    
    func loadUser() {
        var users = DatabaseManager.shared.getObjectsFromDatabase(User.identifier) as! [User]
        if users.isEmpty {users = getDefaultUser()}
        loadObjectsForUser(Setting.identifier, users.first!) {
            self.loadObjectsForUser(Doll.identifier, users.first!, completion: {
                let dolls = DatabaseManager.shared.getObjectsFromDatabase(Doll.identifier) as! [Doll]
                self.loadObjectsForDoll(Clothes.identifier, dolls)
                self.loadObjectsForDoll(Appearance.identifier, dolls)
            })
        }
    }
    
    func getModelBackgrounds(_ settingChange: SettingChange) -> [ModelBackground]{
        var modelBackgrounds: [ModelBackground] = []
        for index in 1..<17 {
            let modelBackground = ModelBackground(background: "scene" + String(index),
                                                  click: false)
            if settingChange.background == modelBackground.background{
                modelBackground.click = !modelBackground.click
            }
            modelBackgrounds.append(modelBackground)
        }
        return modelBackgrounds
    }
    
    func getModelCells() -> [ModelCell]{
        var modelCells: [ModelCell] = []
        
        let identifiers = [SliderTableViewCell.identifier,
                           SliderTableViewCell.identifier,
                           SoundTableViewCell.identifier,
                           SceneTableViewCell.identifier]
        let types: [SettingCellTypes] = [.volume,.brightness, .sound,.background]
        for (index, value) in identifiers.enumerated() {
            modelCells.append(ModelCell(value, types[index]))
        }
        return modelCells
    }
    
    private func loadObjectsForUser(_ identifier: String, _ user: User, completion: @escaping () -> ()) {
        let objects = DatabaseManager.shared.getObjectsFromDatabase(identifier, "idUser", user.name!)
        if objects.isEmpty {
            choiceCreateObjects(identifier, user)
            completion()
        }
    }
    
    private func loadObjectsForDoll(_ identifier: String, _ dolls: [Doll]) {
        dolls.forEach{
            let objects = DatabaseManager.shared.getObjectsFromDatabase(identifier, "idDoll", $0.name!)
            if objects.isEmpty {
                createDefaultClothesOrAppearance(identifier, $0)
            }
        }
    }
    
    private func choiceCreateObjects(_ identifier: String, _ user: User) {
        if Setting.identifier == identifier {
            createDefaultSetting(user)
        } else if Doll.identifier == identifier {
            createDefaultDolls(user)
        }
    }
    
    //MARK: - Creates
    
    private func getDefaultUser() -> [User]{
        let dictionaryProperty = ["name": "User",
                                  "id": String.dateFormatterString(date: Date())] as [String : Any]
        DatabaseManager.shared.addToDatabase(User.identifier, dictionaryProperty)
        return DatabaseManager.shared.getObjectsFromDatabase(User.identifier) as! [User]
    }
    
    private func createDefaultSetting(_ user: User){
        let dictionaryProperty = ["name": "setting",
                                  "volume": 1,
                                  "brightness": 1,
                                  "sound": true,
                                  "background": "scene1",
                                  "idUser": user.name!,
                                  "id": String.dateFormatterString(date: Date())] as [String : Any]
        DatabaseManager.shared.addToDatabase(Setting.identifier, dictionaryProperty)
    }
    
    private func createDefaultDolls(_ user: User) {
        var dictionaryProperty: [String: Any] = [:]
        
        for index in 1..<8 {
            let names = ["Ава", "Алина", "Вика", "Альбина", "Наташа", "Мария", "Анна"]
            dictionaryProperty["idName"] = "doll" + String(index)
            dictionaryProperty["image"] = "doll" + String(index)
            dictionaryProperty["name"] = names[index - 1]
            dictionaryProperty["idUser"] = user.name!
            dictionaryProperty["id"] = String.dateFormatterString(date: Date())
            dictionaryProperty["selected"] = false
            dictionaryProperty["productID"] = IAP.IAPProducts.products[index - 1]
            
            if index < 2{
                dictionaryProperty["access"] = true
            } else {
                dictionaryProperty["access"] = false
            }
            
            DatabaseManager.shared.addToDatabase(Doll.identifier, dictionaryProperty)
        }
    }
    
    
    private func createDefaultClothesOrAppearance(_ identifier: String ,_ doll: Doll) {
        var dictionaryProperty: [String: Any] = [:]
        var type: String!
        var count: Int!
        
        if identifier == Clothes.identifier {
            type = Constants.TypeDoll.clothes
            count = 4
        } else if identifier == Appearance.identifier {
            type = Constants.TypeDoll.appearance
            count = 3
        }
        
        for index in  1..<count{
            dictionaryProperty["image"] = doll.idName! + type + String(index)
            dictionaryProperty["id"] = String.dateFormatterString(date: Date())
            dictionaryProperty["idDoll"] = doll.name!
            if type == Constants.TypeDoll.clothes {
                dictionaryProperty["type"] = index - 1
            } else {
                dictionaryProperty["type"] = (count - 1) + index
            }
            
            DatabaseManager.shared.addToDatabase(identifier, dictionaryProperty)
        }
    }
}
