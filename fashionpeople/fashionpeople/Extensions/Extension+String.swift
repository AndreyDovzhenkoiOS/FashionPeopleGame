//
//  Extension+String.swift
//  FashionPeople
//
//  Created by Andrey on 03.07.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import Foundation

extension String{
    static func dateFormatterString(date:Date) -> String{
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-hh:mm:ss"
        return dateformatter.string(from:date)
    }
}
