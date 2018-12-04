//
//  Extension+NSObject.swift
//  FashionPeople
//
//  Created by Andrey on 25.06.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import UIKit

extension NSObject{
    static var identifier: String{
        return String(describing: self)
    }
    
    func addPanGestureRecognizer(in view: UIView, _ selector: Selector) {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: selector)
        view.addGestureRecognizer(panGestureRecognizer)
    }
}
