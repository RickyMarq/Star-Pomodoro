//
//  Alerts.swift
//  IDNW
//
//  Created by Henrique Marques on 28/07/22.
//

import UIKit

class Alerts: NSObject {
        
    var controller: UIViewController
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    func getAlert(title: String?, message: String, buttonMessage: String, destructiveAction: (() -> Void)? = nil, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "Dismiss", style: .default)
        let cancel = UIAlertAction(title: buttonMessage, style: .destructive) { _ in
            destructiveAction!()
        }
        alert.addAction(cancel)
        alert.addAction(dismiss)
        self.controller.present(alert, animated: true)
    }
    
    func getPlainAlert(title: String?, message: String, completionAction: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "Dismiss", style: .default) { _ in
            completionAction?()
        }

        alert.addAction(dismiss)
        self.controller.present(alert, animated: true)
    }
}
