//
//  AudioPlayer.swift
//  FashionPeople
//
//  Created by Andrey on 25.06.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import UIKit
import AVFoundation

final class AudioPlayerManager: NSObject {
    
    //MARK: - Property
    
    var audioPlayer = AVAudioPlayer()
    private let setting: Setting!
    
    //MARK: - Initialization
    
    static let shared = AudioPlayerManager()
    
    private override init() {
        let user = DatabaseManager.shared.getObjectsFromDatabase(User.identifier).first as! User
        setting = DatabaseManager.shared.getObjectsFromDatabase(Setting.identifier, "idUser", user.name!).first as! Setting
    }
    
    //MARK: - Functions
    
    public func setMusic(_ nameSound: String, _ type: String, _ loop: Int) {
        do{
            let file = Bundle.main.path(forResource: nameSound, ofType: type)
            let url = URL(fileURLWithPath: file!)
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.volume = (setting?.volume)!
            audioPlayer.numberOfLoops = loop
            audioPlayer.play()
            switchSound(setting.sound)
        }catch {print(error.localizedDescription)}
    }
    
    public func switchSound(_ isOn: Bool) {
        if isOn{
            audioPlayer.play()
        } else {
            audioPlayer.stop()
        }
    }
}
