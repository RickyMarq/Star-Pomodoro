//
//  PhraseTableCell.swift
//  Star Pomodoro
//
//  Created by Henrique Marques on 28/08/23.
//

import UIKit

class PhraseTableCell: UITableViewCell {
    
    static let identifier = "PhraseTableCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initViewCode()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    lazy var textCellLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.textAlignment = .left
        return label
    }()
    
    func configCell(with data: PhraseCellModel) {
        self.textCellLabel.text = data.title
    }
    
}

extension PhraseTableCell: ViewCode {
    
    func configureSubViews() {
        self.contentView.addSubview(self.textCellLabel)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
        
            self.textCellLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.textCellLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 24),
            self.textCellLabel.heightAnchor.constraint(equalToConstant: 20),
            self.textCellLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        
        ])
    }
    
    func configureAdditionalBehaviors() {
        
    }
    
    func configureAccessibility() {
        
    }
    
}
