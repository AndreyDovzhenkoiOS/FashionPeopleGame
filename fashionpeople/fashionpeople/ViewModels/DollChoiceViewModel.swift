//
//  DollChoiceViewModel.swift
//  FashionPeople
//
//  Created by Andrey on 26.06.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import UIKit

final class DollChoiceViewModel: NSObject {
    
    //MARK: - Property
    
    var dolls: [Doll] = []
    var selectedDoll: Doll!
    var completionHandler = {() -> () in}
    var buyHandler = {() -> () in}
    
    //MARK: - Initialization
    
    override init() {
        super.init()
        dolls = DatabaseManager.shared.getObjectsFromDatabase(Doll.identifier) as! [Doll]
        purchaseNotificationsProducts()
        resetSelectedDolls()
    }
    
    //MARK: - Functions

    public func startSound() {
        AudioPlayerManager.shared.setMusic(Constants.Sounds.names.dollChoice,
                                           Constants.Sounds.types.mp3, -1)
    }
    
    public func choiceDoll(_ doll: Doll) {
        selectedDoll = doll
        setupSelectedDool()
    }
    
    public func buyDoll() {
        IAPManager.shared.purchase(selectedDoll.productID!)
    }
    
    private func setupSelectedDool() {
        resetSelectedDolls()
        selectedDoll.selected = true
        DatabaseManager.shared.saveContext()
        selectedDoll.access ? completionHandler() : buyHandler()
    }
    
    private func resetSelectedDolls() {
        dolls.forEach{
            $0.selected = false
            DatabaseManager.shared.saveContext()
        }
    }
    
    //MARK: - Purchase
    
    private func purchaseNotificationsProducts() {
        IAP.IAPProducts.products.forEach {
            NotificationCenter.default.addObserver(self, selector:#selector(purchaseHandle),
                                                   name: Notification.Name($0),
                                                   object: nil)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func purchaseHandle() {
        selectedDoll.access = true
        setupSelectedDool()
    }
}
