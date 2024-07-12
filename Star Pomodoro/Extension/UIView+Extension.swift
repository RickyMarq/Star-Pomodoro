//
//  UIView+Extension.swift
//  Star Pomodoro
//
//  Created by Henrique Marques on 02/12/23.
//

import Foundation
import UIKit

extension UIView {
    
    public func setGradientBackgroundView(view: UIView) {
        let gradient = CAGradientLayer()
        let randomColor1 = UIColor.black
        let randomColor2 = UIColor.secondarySystemBackground
   //     gradient.type = .radial
        gradient.colors = [randomColor1.cgColor, randomColor2.cgColor]
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.frame = view.bounds
  //      gradient.cornerRadius = 10
        gradient.masksToBounds = false
        view.layer.insertSublayer(gradient, at: .min)
    }
    
}
