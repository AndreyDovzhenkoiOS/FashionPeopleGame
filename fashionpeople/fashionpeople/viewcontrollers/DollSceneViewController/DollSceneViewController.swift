//
//  DollSceneViewController.swift
//  FashionPeople
//
//  Created by Andrey on 27.06.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import UIKit

final class DollSceneViewController: BasicViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var appearanceCollectionView: UICollectionView!
    @IBOutlet weak var clothesCollectionView: UICollectionView!
    @IBOutlet weak var dollImageView: UIImageView!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var dollNameLabel: UILabel!
    
    //MARK: - Property
    
    static let storyboardName = Constants.StoryboardNames.dollScene
    var viewModel = DollSceneViewModel()
    var modelDollThings: [ModelDollThing] = []
    var dollObjectImageView: UIImageView!
    var currentDollThingImageView: UIImageView!
    
    //MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultSetting()
    }
    
    override func viewDidLayoutSubviews() {
        fillModelDollThings()
    }
    
    //MARK: - Actions
    
    @IBAction func backAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func settingsAction(_ sender: UIButton) {
        transitionToViewController(SettingsViewController.storyboardName,
                                   SettingsViewController.identifier, .present)
    }
    
    @IBAction func touchAction(_ sender: UIPanGestureRecognizer) {
        let location = sender.location(in: sender.view)
        viewModel.cancelDollThing(location, view.frame)
    }
    
    //MARK: - Functions
    
    private func defaultSetting() {
        updateUI()
        allRegisterCells()
        settingViewModel()
    }
    
    private func settingViewModel() {
        viewModel.startSound()
        viewModelCompletionHandler()
    }
    
    private func viewModelCompletionHandler() {
        viewModel.completionHandler = {self.canlcelImageForDollThing($0)}
    }
    
    private func updateUI() {
        settingsButton.layer.cornerRadius = settingsButton.frame.height / 2
        dollImageView.image = UIImage(named: viewModel.doll.image!)
        dollNameLabel.text = viewModel.doll.name!
    }
    
    private func allRegisterCells() {
        clothesCollectionView.registerCell(DollSceneCollectionViewCell.identifier)
        appearanceCollectionView.registerCell(DollSceneCollectionViewCell.identifier)
    }
    
    private func fillModelDollThings() {
        let types = [TypeDollThing.blouse, TypeDollThing.pants, TypeDollThing.footwear,
                     TypeDollThing.hair, TypeDollThing.eyebrows]
        types.forEach {
            modelDollThings.append(ModelDollThing($0.rawValue, getImageViewForDollThing()))
        }
    }
    
    private func getImageViewForDollThing() -> UIImageView{
        let imageView = UIImageView(frame: dollImageView.frame)
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        return imageView
    }
    
    private func canlcelImageForDollThing(_ type: TypeDollThing) {
        let modelDollThing = modelDollThings.filter {$0.type == type.rawValue}.first
        modelDollThing?.imageView.image = UIImage()
    }
}

//MARK: - CollectionView

extension DollSceneViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == clothesCollectionView {
            return viewModel.clothes.count
        } else {
            return viewModel.appearances.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DollSceneCollectionViewCell.identifier, for: indexPath) as! DollSceneCollectionViewCell
        if collectionView == clothesCollectionView {
            cell.clothes = viewModel.clothes[indexPath.row]
        } else {
            cell.appearance = viewModel.appearances[indexPath.row]
        }
        cell.completionHandler = {self.handlePan($0, $1)}
        return cell
    }
    
    //MARK: - CollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: collectionView.frame.width / 1.14,
                      height: collectionView.frame.height / 3.185)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return collectionView.frame.height * 0.01
    }
}

extension DollSceneViewController {
    
    //MARK: - PanGesture
    
    private func handlePan(_ object: AnyObject, _ sender: UIPanGestureRecognizer) {
        if sender.state == .began {began(object, sender)}
        if sender.state == .changed {changed(sender)}
        if sender.state == .ended {ended(object, sender)}
    }
    
    private func began(_ object: AnyObject, _ sender: UIPanGestureRecognizer) {
        viewModel.setSelectedThing(object)
        createCurrentDollThing(sender)
    }
    
    private func changed(_ sender: UIPanGestureRecognizer) {
        currentDollThingImageView.frame.origin = sender.location(in: view)
    }
    
    private func ended(_ object: AnyObject, _ sender: UIPanGestureRecognizer) {
        if let appearance = object as? Appearance {
            setImageForDoll(Int(appearance.type))
        } else if let clothes = object as? Clothes {
            setImageForDoll(Int(clothes.type))
        }
        currentDollThingImageView.removeFromSuperview()
    }
    
    private func setImageForDoll(_ type: Int) {
        let modelDollThing = modelDollThings.filter {$0.type == type}.first
        modelDollThing?.imageView.image = currentDollThingImageView.image
    }
    
    private func createCurrentDollThing(_ sender: UIPanGestureRecognizer) {
        let origin = CGPoint(x: sender.location(in: view).x,
                             y: sender.location(in: view).y)
        
        let size = CGSize(width:dollImageView.frame.width / 1.43 ,
                          height: dollImageView.frame.height / 1)
        
        currentDollThingImageView = UIImageView(frame: CGRect(origin: origin, size: size))
        
        currentDollThingImageView.contentMode = .scaleAspectFit
        if let imageView = sender.view as? UIImageView {
            currentDollThingImageView.image = imageView.image
        }
        view.addSubview(currentDollThingImageView)
    }
}
