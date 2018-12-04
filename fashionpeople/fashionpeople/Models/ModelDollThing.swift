//
//  ModelDollThing.swift
//  FashionPeople
//
//  Created by Andrey on 16.07.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import UIKit

final class ModelDollThing: NSObject {
    
    //MARK: - Property
    
    var type: Int
    var imageView: UIImageView!
    
    //MARK: - Initialization
    
    init(_ type: Int, _ imageView: UIImageView) {
        self.type = type
        self.imageView = imageView
    }
}
