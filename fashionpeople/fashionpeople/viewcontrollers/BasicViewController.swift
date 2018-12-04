//
//  BasicViewController.swift
//  FashionPeople
//
//  Created by Andrey on 01.07.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import UIKit

class BasicViewController: UIViewController {
    
    //MARK: - Property
    
    var setting: Setting!
    var backgroundImageView: UIImageView!
    
    //MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setting = getSetting()
        defaultSettig()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateSettingsApplication()
    }
    
    //MARK: - Functions
    
    private func getSetting() -> Setting{
        let user = DatabaseManager.shared.getObjectsFromDatabase(User.identifier).first! as! User
        let setting = DatabaseManager.shared.getObjectsFromDatabase(Setting.identifier, "idUser", user.name!).first as! Setting
        return setting
    }

    private func defaultSettig() {
        navigationController?.navigationBar.isHidden = true
        hideKeyboardWhenTappedAround()
        setupBackground()
    }
    
    private func setupBackground() {
        backgroundImageView = UIImageView(frame: view.frame)
        view.addSubview(backgroundImageView)
        view.sendSubview(toBack: backgroundImageView)
    }
    
    private func updateSettingsApplication() {
        AudioPlayerManager.shared.switchSound(setting.sound)
        AudioPlayerManager.shared.audioPlayer.volume = setting.volume
        UIScreen.main.brightness = CGFloat(setting.brightness)
        backgroundImageView.image = UIImage(named: setting.background!)
    }
}
