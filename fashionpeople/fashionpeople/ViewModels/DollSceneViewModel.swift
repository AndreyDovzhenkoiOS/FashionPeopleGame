//
//  DollSceneViewModel.swift
//  FashionPeople
//
//  Created by Andrey on 27.06.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import UIKit

final class DollSceneViewModel: NSObject {
    
    //MARK: - Property
    
    var doll: Doll!
    var clothes: [Clothes] = []
    var appearances: [Appearance] = []
    var completionHandler = {(_ : TypeDollThing) -> () in}
    
    //MARK: - Initialization
    
    override init() {
        super.init()
        loadObjects()
    }
    
    //MARK: - Functions
    
    public func startSound() {
        AudioPlayerManager.shared.setMusic(Constants.Sounds.names.dollScene,
                                           Constants.Sounds.types.mp3, -1)
    }
    
    private func loadObjects() {
        doll = (DatabaseManager.shared.getObjectsFromDatabase(Doll.identifier) as! [Doll]).filter {$0.selected == true}.first
        clothes = DatabaseManager.shared.getObjectsFromDatabase(Clothes.identifier, "idDoll", doll.name!) as! [Clothes]
        appearances = DatabaseManager.shared.getObjectsFromDatabase(Appearance.identifier, "idDoll", doll.name!) as! [Appearance]
    }
    
    public func setSelectedThing(_ object: AnyObject) {
        if let appearance = object as? Appearance {
            appearance.idSelectedDoll = doll.id!
        } else if let clothes = object as? Clothes {
            clothes.idSelectedDoll = doll.id!
        }
        DatabaseManager.shared.saveContext()
    }
    
    public func cancelDollThing(_ location: CGPoint, _ frame: CGRect) {
        
        if location.y > frame.height / 8.5,
            location.y < frame.height / 4.3{
            completionHandler(.hair)
            return
        }
        
        if location.y > frame.height / 3.5,
            location.y < frame.height / 3.1{
            completionHandler(.eyebrows)
            return
        }
        
        if location.y > frame.height / 2.05,
            location.y < frame.height / 1.8 {
            completionHandler(.blouse)
            return
        }
        
        if location.y > frame.height / 1.75,
            location.y < frame.height / 1.45 {
            completionHandler(.pants)
            return
        }
        
        if location.y > frame.height / 1.35 {
            completionHandler(.footwear)
            return
        }
    }
}
