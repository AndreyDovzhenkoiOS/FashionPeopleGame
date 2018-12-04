//
//  CaptchaAlertViewController.swift
//  FashionPeople
//
//  Created by Andrey on 04.07.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import UIKit

final class CaptchaAlertViewController: UIAlertController {
    
    //MARK: - Property
    
    var completionHandler = {() -> () in}
    
    static private var titleMessage: String!
    static private var titleAction: String!

    private let viewModel = CaptchaViewModel()
    private var textField: UITextField!
    private var buyAction: UIAlertAction!
    
    //MARK: - Initialization
    
    static func installation(_ titleMessage: String?, _ titleAction: String?) -> CaptchaAlertViewController {
        CaptchaAlertViewController.titleMessage = titleMessage
        CaptchaAlertViewController.titleAction = titleAction
        return CaptchaAlertViewController(title: Constants.Alerts.title,
                                         message: String(), preferredStyle: .alert)
    }
    
    override func viewDidLoad() {
        setupActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        defaultSetting()
    }
    
    
    //MARK: - Functions
    
    private func setupActions() {
        addTextField {self.textField = $0}
        addAction(UIAlertAction(title: Constants.Alerts.cancel, style: .cancel, handler: nil))
        buyAction = UIAlertAction(title: CaptchaAlertViewController.titleAction,
                                  style: .destructive,
                                  handler: { _ in self.completionHandler()})
        addAction(buyAction)
    }
    
    private func defaultSetting() {
        settingTextField()
        viewModelCompletionHandler()
        viewModel.setupNumbers()
    }
    
    private func viewModelCompletionHandler() {
        viewModel.completionHandler = {
            self.message = CaptchaAlertViewController.titleMessage + $0
            self.buyAction.isEnabled = $1
        }
    }
    
    private func settingTextField() {
        textField.delegate = self
        textField.text = String()
        textField.placeholder = Constants.TextFields.placeholderCaptcha
        textField.keyboardType = .numbersAndPunctuation
    }
}

//MARK: - TextField

extension CaptchaAlertViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        viewModel.checkRightAnswer(string, allText: textField.text!)
        return viewModel.validateText(string)
    }
}
