//
//  Extension+ViewController.swift
//  FashionPeople
//
//  Created by Andrey on 02.07.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import UIKit

extension UIViewController{
    
    //MARK: - Functions
    
    func transitionToViewController(_ storyboardName: String, _ identifier: String, _ transition: Transitions) {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: identifier)
        transitionAnimate(viewController, transition)
    }
    
    func alert(_ title: String, _ message: String, cancel: Bool, completion: (() -> ())?)  {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if cancel {
            alertController.addAction(UIAlertAction(title:Constants.Alerts.cancel , style: .cancel, handler: nil))
        } else {
            alertController.addAction(UIAlertAction(title:Constants.Alerts.no , style: .cancel, handler: nil))
            alertController.addAction(UIAlertAction(title: Constants.Alerts.yes, style: .destructive, handler: { _ in
                completion!()
            }))
        }
        transitionAnimate(alertController, .present)
    }
    
    func transitionAnimate(_ viewController: UIViewController, _ transition: Transitions) {
        switch transition {
        case .present:
            present(viewController, animated: true, completion: nil)
        case .show:
            show(viewController, sender: nil)
        default:
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                 action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
