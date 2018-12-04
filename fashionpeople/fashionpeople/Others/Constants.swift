//
//  Constants.swift
//  FashionPeople
//
//  Created by Andrey on 25.06.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import Foundation

enum Constants {
    static let randomCaptcha = 10
    
    enum ImageStrings {
        static let soundOn = "soundOnImage"
        static let soundOff = "soundOffImage"
    }
    
    enum Alerts {
        static let title = "Сообщение"
        static let save = "Вы действительно хотите сохранить измненения ?"
        static let access = " \n Это кукла недоступна! \n Введите правильный ответ:"
        static let yes = "Да"
        static let no = "Нет"
        static let buy = "Купить"
        static let cancel = "Отмена"
    }
    
    enum SettingCellNames {
        static let volume = "Громкость"
        static let brightness = "Яркость"
        static let sound = "Звук"
        static let background = "Выбор фона:"
    }
    
    enum StoryboardNames {
        static let settings = "Settings"
        static let dollChoice = "DollChoice"
        static let dollScene = "DollScene"
    }
    
    enum Sounds {
        enum names {
            static let dollChoice = "dollChoiceSound"
            static let dollScene = "dollSceneSound"
            static let main = "mainSound"
        }
        enum types {
            static let mp3 = "mp3"
        }
    }
    
    enum TextFields {
        static let validateOnluNumbers = "0123456789-"
        static let placeholderCaptcha = "Введите правильный ответ!"
    }
    
    enum TypeDoll {
        static let clothes = "Clothes"
        static let appearance = "Appearance"
    }
}

enum IAP {
    static let productNotificationsIdentifier = Notification.Name("IAPManagerProductIdentifier")
    
    enum IAPProducts {
        static let product0 = "product_id_com_1"
        static let product1 = "product_id_com_2"
        static let product2 = "product_id_com_3"
        static let product3 = "product_id_com_4"
        static let product4 = "product_id_com_5"
        static let product5 = "product_id_com_6"
        static let product6 = "product_id_com_7"
        static let product7 = "product_id_com_8"
        
        static let products = [product0, product1, product2,
                               product3, product4, product5,
                               product6, product7]
    }
}

enum TypeDollThing: Int{
    case blouse, pants, footwear, hair, eyebrows
}

enum Captcha: Int {
    case add, take, multiply, divide
}

enum Transitions {
    case present, push, show
}

enum SettingCellTypes {
    case volume, brightness, sound, background
}
