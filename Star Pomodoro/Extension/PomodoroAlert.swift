//
//  PomodoroAlert.swift
//  Star Pomodoro
//
//  Created by Henrique Marques on 27/12/23.
//

import Foundation
import UIKit

class PomodoroAlert {
    
    struct Constants {
        static let backgroudAlphaTo: CGFloat = 0.6
    }
    
    private let backgroundView: UIView = {
        let backgroundView = UIView()
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.backgroundColor = .secondarySystemBackground
        backgroundView.alpha = 0.6
        return backgroundView
    }()
    
    private let alertView: UIView = {
        let alert = UIView()
        alert.backgroundColor = .white
        alert.layer.masksToBounds = false
        alert.layer.cornerRadius = 12
        return alert
    }()
    
    func showAlert(with title: String, message: String, ViewController: UIViewController) {
        guard let targetView = ViewController.view else {return}
        backgroundView.frame = targetView.bounds
        targetView.addSubview(backgroundView)
        targetView.addSubview(alertView)
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: alertView.frame.size.width, height: 80))
        titleLabel.text = title
        titleLabel.textAlignment = .center
        alertView.addSubview(titleLabel)
        
        alertView.frame = CGRect(x: 40, y: -300, width: targetView.frame.size.width-80, height: 300)
        
        let button = UIButton(frame: CGRect(x: 0, y: alertView.frame.size.height-50, width: alertView.frame.size.width, height: 50))
        alertView.addSubview(button)
        button.setTitle("Dismiss", for: .normal)
        button.addTarget(self, action: #selector(dismissAlert), for: .touchUpInside)
        
        UIView.animate(withDuration: 0.5) {
            self.backgroundView.alpha = Constants.backgroudAlphaTo
        }
    }
    
    @objc func dismissAlert() {
        
    }
}
