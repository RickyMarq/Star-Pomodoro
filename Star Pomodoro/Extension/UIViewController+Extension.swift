//
//  UIViewController+Extension.swift
//  Star Pomodoro
//
//  Created by Henrique Marques on 01/09/23.
//

import Foundation
import UIKit
import SafariServices

extension UIViewController {
    
    func openSafariPageWith(url: String) {
        guard let urlToVC = URL(string: url) else {return}
        let vc = SFSafariViewController(url: urlToVC)
        vc.preferredControlTintColor = .systemYellow
        self.present(vc, animated: true)
    }
    
}
