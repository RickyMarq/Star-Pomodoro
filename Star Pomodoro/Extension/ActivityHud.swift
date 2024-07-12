//
//  ActivityHud.swift
//  Star Pomodoro
//
//  Created by Henrique Marques on 28/09/23.
//

import Foundation
import UIKit

class ProgressHUD {
    let overlayView = UIView()
    let activityIndicator = UIActivityIndicatorView()

    class var shared: ProgressHUD {
        struct Static {
            static let instance: ProgressHUD = ProgressHUD()
        }
        return Static.instance
    }

    init() {
        setup()
    }

    public func show() {
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            show(in: topController.view)
        }
    }

    public func show(in view: UIView) {
        overlayView.center = view.center
        view.addSubview(overlayView)
        activityIndicator.startAnimating()
    }

    public func hide() {
        activityIndicator.stopAnimating()
        overlayView.removeFromSuperview()
    }
}

private extension ProgressHUD {
    func setup() {
        overlayView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        overlayView.backgroundColor = UIColor(white: 0, alpha: 0.7)
        overlayView.clipsToBounds = true
        overlayView.layer.cornerRadius = 10
        overlayView.layer.zPosition = 1

        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.center = CGPoint(x: overlayView.bounds.width / 2, y: overlayView.bounds.height / 2)
        activityIndicator.style = .whiteLarge
        overlayView.addSubview(activityIndicator)
    }
}
