//
//  ViewController.swift
//  FashionPeople
//
//  Created by Andrey on 25.06.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import UIKit

final class MainViewController: BasicViewController {
    
    @IBOutlet weak var eggImageView: UIImageView!
    @IBOutlet weak var soundSwitchButton: UIButton!
    @IBOutlet weak var settingButton: UIButton!
    
    //MARK: - Property
    
    var viewModel:MainViewModel!
    
    //MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultSetting()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        defaultSetting()
    }
    
    //MARK: - Action
    
    @IBAction func sounSwitchAction(_ sender: UIButton) {
        viewModel.soundSwitchAction()
    }
    
    @IBAction func shareAction(_ sender: UIButton) {
        setupActivityViewController()
    }
    
    @IBAction func settinAction(_ sender: UIButton) {
        transitionToViewController(SettingsViewController.storyboardName,
                                   SettingsViewController.identifier, .present)
    }
    
    @IBAction func swipeAction(_ sender: UISwipeGestureRecognizer) {
        shake()
        self.perform(#selector(transitionDollChoiceViewController), with: nil, afterDelay: 0.6)
    }
    
}

//MARK: - Functions

extension MainViewController{
    
    
    func defaultSetting() {
        createViewModel()
        backgroundImageView.image = #imageLiteral(resourceName: "backgroundImage")
    }
    
    private func createViewModel() {
        viewModel = MainViewModel(setting: setting)
        viewModel.startSound()
        viewModelCompletionHandler()
        viewModel.updateSound()
    }
    
    private func viewModelCompletionHandler() {
        viewModel.completionHandler = {
            self.soundSwitchButton.setImage(UIImage(named: $0), for: .normal)
        }
    }
    
    private func setupActivityViewController() {
        let dollImage = #imageLiteral(resourceName: "doll1")
        let url = URL(string: "https://www.facebook.com")!
        let activityViewController = UIActivityViewController(activityItems: [url, dollImage],
                                                              applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = view
        transitionAnimate(activityViewController, .present)
    }
    
    private func shake(){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 5
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: eggImageView.center.x - 10, y: eggImageView.center.y))
        animation.fromValue = NSValue(cgPoint: CGPoint(x: eggImageView.center.x + 10, y: eggImageView.center.y))
        eggImageView.layer.add(animation, forKey: "position")
    }
    
    @objc func transitionDollChoiceViewController() {
        transitionToViewController(DollChoiceViewController.storyboardName, DollChoiceViewController.identifier, .push)
    }
}
