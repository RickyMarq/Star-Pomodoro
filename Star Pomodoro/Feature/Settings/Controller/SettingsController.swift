//
//  SettingsController.swift
//  Star Pomodoro
//
//  Created by Henrique Marques on 27/08/23.
//

import UIKit

class SettingsController: UIViewController {
    
    var settingsView: SettingsView?
    var settingsViewModel: SettingsViewModel?
    var notificationsAllowed = false
    var personalitySelected: String?
    
    override func loadView() {
        self.settingsView = SettingsView()
        self.view = settingsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configNavigationController()
        self.settingsViewModel = SettingsViewModel()
        self.settingsView?.settingsTableViewProtocols(delegate: self, dataSource: self)
    }
    
    func configNavigationController() {
        self.title = "Settings"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        notificationsAllowed = UserDefaults.standard.bool(forKey: "NotificationGranted")
        personalitySelected = UserDefaults.standard.string(forKey: "PersonalitySelected")
        print("DEBUG MODE: notificationAllowed: \(notificationsAllowed)")
    }
    
    func presentWhatsNew() {
        let vc = WhatsNewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension SettingsController: NotificationTableCellProtocols {
    
    func switcherAction(cell: NotificationTableCell) {

    }
}


extension SettingsController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsViewModel?.rowsInSection(section: section) ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return settingsViewModel?.numberOfSections ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return settingsViewModel?.titleForSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = settingsViewModel?.cellRowBySection(indexPath: indexPath)

        switch index {
         
        case .staticCell(model: let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: StaticTableCell.identifier, for: indexPath) as? StaticTableCell else {return UITableViewCell()}
            cell.configCell(with: model)
            cell.backgroundColor = .tertiarySystemBackground
            return cell
        
        case .informationCell(model: let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: InformationTableCell.identifier, for: indexPath) as? InformationTableCell else {return UITableViewCell()}
            cell.configCell(with: model)
            cell.backgroundColor = .tertiarySystemBackground
            return cell
            
        case .WhatsNew(model: let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: StaticTableCell.identifier, for: indexPath) as? StaticTableCell else {return UITableViewCell()}
            cell.configWhatsCell(with: model)
            cell.backgroundColor = .tertiarySystemBackground
            return cell
        case .documentationCell(model: let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: StaticTableCell.identifier, for: indexPath) as? StaticTableCell else {return UITableViewCell()}
            cell.configDocumentationCell(with: model)
            cell.backgroundColor = .tertiarySystemBackground
            return cell
            
        case .notificationCell(model: let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NotificationTableCell.identifier, for: indexPath) as? NotificationTableCell else {return UITableViewCell()}
            cell.configCell(with: model)
            cell.delegate(delegate: self)
            cell.notificationSwitcher.isOn = notificationsAllowed
            cell.backgroundColor = .tertiarySystemBackground
            return cell
            
        case .phraseCell(model: let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PhraseTableCell.identifier, for: indexPath) as? PhraseTableCell else {return UITableViewCell()}
            cell.configCell(with: model)
            if model.title == personalitySelected {
                cell.accessoryType = .checkmark
            }
            cell.backgroundColor = .tertiarySystemBackground
            return cell
        case .none:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = settingsViewModel?.cellRowBySection(indexPath: indexPath)

        switch index {
            
        case .staticCell(model: let model):
            let doubleHeader = model.title
            model.handler(doubleHeader)
        case .informationCell(model: let model):
            let vc = UIActivityViewController(activityItems: [model.infoText], applicationActivities: nil)
            self.present(vc, animated: true)
        case .WhatsNew(model:):
            self.present(WhatsNewController(), animated: true)
            print("A")
        case .notificationCell(model:):
            print("Change State")
        case .documentationCell(model: let model):
            self.openSafariPageWith(url: model.link)
        case .phraseCell(model: let model):
            UserDefaults.standard.set(model.title, forKey: "PersonalitySelected")
            personalitySelected = model.title
            tableView.reloadData()
        case .none:
            print("Error")
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: TableTitleHeader.identifier) as? TableTitleHeader else {return UIView()}
            header.delegate(delegate: self)
            return header
        }
        return nil
    }
}

extension SettingsController: TableTitleHeaderProtocol {
    
    func cancelButtonAction() {
        self.dismiss(animated: true)
    }
}
