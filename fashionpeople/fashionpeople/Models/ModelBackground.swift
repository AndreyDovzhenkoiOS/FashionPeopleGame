//
//  ModelBackground.swift
//  FashionPeople
//
//  Created by Andrey on 26.06.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import UIKit

final class ModelBackground: NSObject {
    
    //MARK: - Property
    
    var background: String!
    var click: Bool!
    
    //MARK: - Initialization
    
    init(background: String!, click: Bool!) {
        self.background = background
        self.click = click
    }
}
