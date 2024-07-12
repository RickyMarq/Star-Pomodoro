//
//  TableTitleHeader.swift
//  Star Pomodoro
//
//  Created by Henrique Marques on 27/08/23.
//

import UIKit

protocol TableTitleHeaderProtocol: AnyObject {
    func cancelButtonAction()
}

class TableTitleHeader: UITableViewHeaderFooterView {
    
    static let identifier = "TableTitleHeader"
    weak var delegate: TableTitleHeaderProtocol?
    
    func delegate(delegate: TableTitleHeaderProtocol) {
        self.delegate = delegate
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        initViewCode()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    lazy var vcTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .label
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = "Settings"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.layer.masksToBounds = true
        label.clipsToBounds = true
        return label
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton(type: .close)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .secondarySystemBackground
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func cancelButtonTapped() {
        self.delegate?.cancelButtonAction()
    }

}

extension TableTitleHeader: ViewCode {
    
    func configureSubViews() {
        self.contentView.addSubview(self.vcTitle)
        self.contentView.addSubview(self.cancelButton)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            
            self.vcTitle.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 30),
            self.vcTitle.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 30),
            self.vcTitle.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -30),
            self.vcTitle.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -30),
            
            self.cancelButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 30),
            self.cancelButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            self.cancelButton.heightAnchor.constraint(equalToConstant: 30),
            self.cancelButton.widthAnchor.constraint(equalToConstant: 30),
            
            
        ])
    }
    
    func configureAdditionalBehaviors() {
        
    }
    
    func configureAccessibility() {
        
    }
    
    
}
