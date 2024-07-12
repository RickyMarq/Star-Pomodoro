//
//  SettingsView.swift
//  Star Pomodoro
//
//  Created by Henrique Marques on 27/08/23.
//

import UIKit

class SettingsView: UIView {
    
    lazy var settingsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.alwaysBounceVertical = true
        tableView.showsVerticalScrollIndicator = false
        tableView.register(InformationTableCell.self, forCellReuseIdentifier: InformationTableCell.identifier)
        tableView.register(StaticTableCell.self, forCellReuseIdentifier: StaticTableCell.identifier)
        tableView.register(NotificationTableCell.self, forCellReuseIdentifier: NotificationTableCell.identifier)
        tableView.register(PhraseTableCell.self, forCellReuseIdentifier: PhraseTableCell.identifier)
        tableView.register(TableTitleHeader.self, forHeaderFooterViewReuseIdentifier: TableTitleHeader.identifier)
        return tableView
    }()
    
    public func settingsTableViewProtocols(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        self.settingsTableView.delegate = delegate
        self.settingsTableView.dataSource = dataSource
    }


    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewCode()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

extension SettingsView: ViewCode {
    
    func configureSubViews() {
        self.addSubview(self.settingsTableView)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
        
            self.settingsTableView.topAnchor.constraint(equalTo: self.topAnchor),
            self.settingsTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.settingsTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.settingsTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        
        ])
    }
    
    func configureAdditionalBehaviors() {
        self.backgroundColor = .secondarySystemBackground
    }
    
    func configureAccessibility() {
        
    }
    
}
