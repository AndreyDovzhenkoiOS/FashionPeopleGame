//
//  SettingsViewController.swift
//  FashionPeople
//
//  Created by Andrey on 25.06.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import UIKit

final class SettingsViewController: BasicViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var saveButton: UIButton!
    
    //MARK: - Proprety
    
    static let storyboardName = Constants.StoryboardNames.settings
    var viewModel: SettingsViewModel!
    
    //MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultSetting()
    }
    
    //MARK: - Actions
    
    @IBAction func saveAction(_ sender: UIButton) {
        alertSave()
    }
    
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

//MARK: - Functions

extension SettingsViewController{
    
    func defaultSetting() {
        createViewModel()
        allRegisterCell()
        settingSaveButton()
    }
    
    private func createViewModel() {
        viewModel = SettingsViewModel(setting: setting)
        viewModelCompletionHandler()
    }
    
    private func settingSaveButton() {
        saveButton.layer.cornerRadius = saveButton.frame.height / 2
        saveButton.layer.borderWidth = 0.4
        saveButton.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    private func allRegisterCell() {
        tableView.registerCell(SliderTableViewCell.identifier)
        tableView.registerCell(SoundTableViewCell.identifier)
        tableView.registerCell(SceneTableViewCell.identifier)
    }
    
    private func viewModelCompletionHandler() {
        viewModel.completion = {self.saveButton.isEnabled = $0}
    }
    
    private func alertSave() {
        alert(Constants.Alerts.title, Constants.Alerts.save, cancel: false) {
            self.viewModel.saveSettings()
            self.dismiss(animated: true, completion: nil)
        }
    }
}
//MARK: - TableView

extension SettingsViewController: UITableViewDataSource, UITableViewDelegate{
    
    //MARK: - TableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.modelCells.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return getCell(viewModel.modelCells[indexPath.section], indexPath)
    }
    
    private  func getCell(_ modelCell: ModelCell, _ indexPath: IndexPath) -> UITableViewCell{
        var cell = tableView.dequeueReusableCell(withIdentifier: modelCell.identifier, for: indexPath) as! SettingsProtocolCell
        cell.type = modelCell.type
        cell.settingChange = viewModel.settingChange
        cell.completionHandler = {() in
            self.viewModel.updateSettingsApplication()
            self.viewModel.checkChange()
        }
        return cell as! UITableViewCell
    }
    
    //MARK: - TableViewDeleagte
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 3 {return view.frame.height / 2.28}
        return view.frame.height / 11
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return view.frame.height * 0.04
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
}
