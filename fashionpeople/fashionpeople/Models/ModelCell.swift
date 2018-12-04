//
//  ModelCell.swift
//  FashionPeople
//
//  Created by Andrey on 24.07.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import UIKit

final class ModelCell: NSObject {
    
    //MARK: - Property
    
    var identifier: String!
    var type: SettingCellTypes
    
    //MARK: - Initialisation
    
    init(_ identifier: String, _ type: SettingCellTypes) {
        self.identifier = identifier
        self.type = type
    }
}
