//
//  CaptchaViewModel.swift
//  FashionPeople
//
//  Created by Andrey on 04.07.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import UIKit

final class CaptchaViewModel: NSObject {
    
    //MARK: - Property
    
    var completionHandler = {(message: String, isEnabled: Bool) in}
    
    private var message: String!
    private var typeString: String!
    private var answer: Int!
    
    //MARK: - Functions
    
    public func setupNumbers() {
        let numbers = getNumbers(Captcha(rawValue: getRandomCount(3))!)
        answer = numbers.answer
        setupQuestion(numbers.numberFirst, numbers.numberSecond)
    }
    
    public func checkRightAnswer(_ string: String, allText: String) {
        if validateText(string) {
            var text = allText + string
            if delete(string) {text.removeLast()}
            let enabled = Int(text) == answer
            completionHandler(message, enabled)
        }
    }
    
    public func validateText(_ string: String) -> Bool {
        let onlyNumbers = CharacterSet.init(charactersIn: Constants.TextFields.validateOnluNumbers)
        let characterSetFromTextField = CharacterSet.init(charactersIn: string)
        return onlyNumbers.isSuperset(of: characterSetFromTextField)
    }
    
    private func setupQuestion(_ numberFirst: Int, _ numberSecond: Int) {
        message = " " + "\n"
            + String(numberFirst) + " " + typeString + " " + String(numberSecond) + " " + "?"
        completionHandler(message, false)
    }
    
    private func getNumbers(_ type: Captcha) -> (numberFirst: Int, numberSecond: Int, answer: Int) {
        let numberFirst = getRandomCount(Constants.randomCaptcha)
        let numberSecond = getRandomCount(Constants.randomCaptcha)
        let answer = getAnswer(type, numberFirst, numberSecond)
        return (numberFirst, numberSecond, answer)
    }
    
    private func getAnswer(_ type: Captcha, _ numberFirst: Int, _ numberSecond: Int!) -> Int {
        switch type {
        case .add:
            typeString = "+"
            return numberFirst + numberSecond
        case .multiply:
            typeString = "*"
            return numberFirst * numberSecond
        case .divide:
            typeString = "/"
            return numberFirst / numberSecond
        case .take:
            typeString = "-"
            return numberFirst - numberSecond
        }
    }
    
    private  func getRandomCount(_ count: Int) -> Int {
        return Int(arc4random_uniform(UInt32(count)))
    }
    
    private func delete(_ string: String) -> Bool {
        return string == ""
    }
}
