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
            layer.shadowColor = UIColor.systemYellow.cgColor
            layer.shadowOffset = CGSize(width: 1, height: 1)
            layer.shadowRadius = 1.5
            layer.shadowOpacity = 1
            layer.masksToBounds = false
            setTitleColor(.black, for: .normal)
        }
    }
}
