//
//  DollChoiceViewController
//  FashionPeople
//
//  Created by Andrey on 25.06.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import UIKit

final class DollChoiceViewController: BasicViewController {
    
    @IBOutlet weak var textFiled: UITextField!
    @IBOutlet weak var choiceButton: UIButton!
    @IBOutlet weak var fogImageView: UIImageView!
    @IBOutlet weak var dollImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Property
    
    static let storyboardName = Constants.StoryboardNames.dollChoice
    var viewModel = DollChoiceViewModel()
    
    //MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultSetting()
    }
    
    //MARK: - Actions
    
    @IBAction func choiceAction(_ sender: UIButton) {
        transitionToViewController(DollSceneViewController.storyboardName,
                                   DollSceneViewController.identifier, .push)
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Functions
    
    private func defaultSetting() {
        textFiled.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        setupViewModel()
        choiceButton.layer.cornerRadius = choiceButton.frame.height / 2
        collectionView.registerCell(DollChoiceCollectionViewCell.identifier)
    }
    
    private func setupViewModel() {
        viewModel.startSound()
        viewModelcompletionHandler()
    }
    
    private func viewModelcompletionHandler() {
        viewModel.completionHandler = {self.updateUI()}
        viewModel.buyHandler = {self.setupCaptcha()}
    }
    
    private func updateUI() {
        animateDollImage()
        dollImageView.image = UIImage(named: self.viewModel.selectedDoll.image!)
        textFiled.text = self.viewModel.selectedDoll.name
        collectionView.reloadData()
    }
    
    private func setupCaptcha() {
        let captchaController = CaptchaAlertViewController.installation(Constants.Alerts.access,
                                                                        Constants.Alerts.buy)
        transitionAnimate(captchaController, .present)
        captchaController.completionHandler = {self.viewModel.buyDoll()}
    }
    
    private func animateDollImage() {
        dollImageView.alpha = 0
        UIView.animate(withDuration: 0.8) {
            self.dollImageView.alpha = 1
            self.fogImageView.alpha = 1
            self.choiceButton.alpha = 1
            self.textFiled.alpha = 1
        }
    }
}

extension DollChoiceViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    //MARK: - CollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.dolls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DollChoiceCollectionViewCell.identifier, for: indexPath) as! DollChoiceCollectionViewCell
        cell.doll = viewModel.dolls[indexPath.row]
        return cell
    }
    
    //MARK: - CollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.choiceDoll(viewModel.dolls[indexPath.row])
    }
    
    //MARK: - CollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: collectionView.frame.width / 8.3,
                      height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        let width = collectionView.frame.width * 0.007
        let height = collectionView.frame.size.height * 0.041
        return UIEdgeInsets(top: height, left: width, bottom: height, right: width)
    }
}

extension DollChoiceViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textFiled.text?.count)! > 0{
            viewModel.selectedDoll.name = textFiled.text
            DatabaseManager.shared.saveContext()
            return view.endEditing(true)
        } else {
            return false
        }
    }
}
