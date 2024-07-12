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
    var defaults = UserDefaults.standard
    var keepScreenOn = true
    
    
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
        defaults.synchronize()
        notificationsAllowed = defaults.bool(forKey: "NotificationGranted")
        personalitySelected = defaults.string(forKey: "PersonalitySelected")
        keepScreenOn = defaults.bool(forKey: "keepScreenOn")
        let isOn = defaults.bool(forKey: "NotificationGranted")
        print("DEBUG MODE: Perso Selected: \(personalitySelected)")

        print("DEBUG MODE: notificationAllowed: \(notificationsAllowed)")
        
        DispatchQueue.main.async {
            self.notificationsAllowed = isOn
            self.settingsView?.settingsTableView.reloadData()
        }
    }
    
    func presentWhatsNew() {
        let vc = WhatsNewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func requestNotificationAuthorization() {
        let nc = UNUserNotificationCenter.current()
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        
        nc.requestAuthorization(options: options) { granted, _ in
            
            UNUserNotificationCenter.current().getNotificationSettings { result in
                
                switch result.authorizationStatus {
                    
                case .notDetermined:
                    if granted {
                        print("\(#function) Permission granted: \(granted)")
                        self.notificationsAllowed = granted
                        DispatchQueue.main.async {
                            UIApplication.shared.registerForRemoteNotifications()
                        }
                        self.defaults.set(true, forKey: "NotificationGranted")
                        UserDefaults.standard.synchronize()
                    } else {
                        print("\(#function) Permission NOT granted: \(granted)")
                        self.notificationsAllowed = granted
                        self.defaults.set(false, forKey: "NotificationGranted")
                        self.defaults.synchronize()
                    }
                case .authorized:
                    self.notificationsAllowed = true
                    self.defaults.set(true, forKey: "NotificationGranted")
                    self.defaults.synchronize()
                case .denied:
                    self.defaults.set(false, forKey: "NotificationGranted")
                    if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
                        if UIApplication.shared.canOpenURL(settingsUrl) {
                            DispatchQueue.main.async {
                                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                                })
                            }
                        }
                    }
                case .ephemeral:
                    print("Ephemeral")
                case .provisional:
                    print("Provisional")
                @unknown default:
                    fatalError("Fatal Error")
                }
            }
        }
    }
}

extension SettingsController: NotificationTableCellProtocols {
    
    func switcherAction(cell: NotificationTableCell) {
        switch cell.notificationSwitcher.tag {
            
        case 0:
            print("Notification...")
        case 1:
            print("Keep Screen On...")
        default:
            break
        }
        
//        switch cell.notificationSwitcher.isOn {
//        
//        case true:
//            self.requestNotificationA thorization()
//        case false:
//            UIApplication.shared.unregisterForRemoteNotifications()
//            UserDefaults.standard.set(false, forKey: "NotificationGranted")
//            notificationsAllowed = false
//            cell.notificationSwitcher.isOn = false
//            print("DEBUG MODE: SWITCH ACTION: \(notificationsAllowed)")
//        }
        
        
//        switch cell.notificationSwitcher.tag {
//            
//        case 0:
//            switch cell.notificationSwitcher.isOn {
//                
//            case true:
//                <#code#>
//            case false:
//                <#code#>
//            }
//        case 1:
//            
//            
//        default:
//            
//        }
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
  //          cell.isUserInteractionEnabled = false
            cell.configCell(with: model)
            cell.delegate(delegate: self)
            DispatchQueue.main.async {
                self.notificationsAllowed = self.defaults.bool(forKey: "NotificationGranted")
                cell.notificationSwitcher.isOn = self.notificationsAllowed
            }
            cell.backgroundColor = .tertiarySystemBackground
            return cell
            
        case .phraseCell(model: let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PhraseTableCell.identifier, for: indexPath) as? PhraseTableCell else {return UITableViewCell()}
            cell.configCell(with: model)
            if model.title == personalitySelected {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
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
        case .notificationCell(model: let model):
            
            switch model.tag {
                
            case 0:
                print("Notifications...")
            case 1:
                print("Keep Screen On...")
                UIApplication.shared.isIdleTimerDisabled = true
            default:
                break
            }
            
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
