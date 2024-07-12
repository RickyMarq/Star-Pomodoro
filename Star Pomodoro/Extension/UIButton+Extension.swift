//
//  UIButton+Extension.swift
//  Star Pomodoro
//
//  Created by Henrique Marques on 26/08/23.
//

import Foundation
import UIKit

extension UIButton {
    
    enum buttonStyling {
        case normal
        case tagButton
    }
    
    func setButtonStyling(layout: buttonStyling) {
        switch layout {
        case .normal:
            translatesAutoresizingMaskIntoConstraints = false
            tintColor = .black
            backgroundColor = .systemYellow
            layer.borderColor = UIColor.systemYellow.cgColor
            layer.borderWidth = 1
            layer.cornerRadius = 15
            layer.shadowColor = UIColor.systemBackground.cgColor
            layer.shadowOffset = CGSize(width: 1, height: 1)
            layer.shadowRadius = 1.5
            layer.shadowOpacity = 1
            layer.masksToBounds = false
            setTitleColor(.black, for: .normal)
        case .tagButton:
            translatesAutoresizingMaskIntoConstraints = false
            tintColor = .label
            backgroundColor = .clear
            layer.borderColor = UIColor.clear.cgColor
            layer.borderWidth = 1
            layer.cornerRadius = 15
 //           layer.shadowColor = UIColor.systemBackground.cgColor
 //           layer.shadowOffset = CGSize(width: 1, height: 1)
 //           layer.shadowRadius = 1.5
 //           layer.shadowOpacity = 1
            layer.masksToBounds = false
            setTitleColor(.secondaryLabel, for: .normal)
        }
        
        
    }
}
