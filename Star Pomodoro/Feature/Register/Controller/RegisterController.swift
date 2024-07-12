//
//  RegisterViewController.swift
//  Star Pomodoro
//
//  Created by Henrique Marques on 27/09/23.
//

import UIKit

class RegisterController: UIViewController {
    
    var registerView: RegisterView?
    var service: RegisterService = RegisterService()
    var alerts: Alerts?
    
    override func loadView() {
        self.registerView = RegisterView()
        self.view = registerView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerView?.delegate(delegate: self)
        self.registerView?.mailTextFieldDelegate(delegate: self)
        self.registerView?.passwordTextFieldDelegate(delegate: self)
        self.alerts = Alerts(controller: self)
    }
    
    func openLogin() {
        print("OpenLogin.....")
        let loginVc = LoginController()
        self.navigationController?.pushViewController(loginVc, animated: true)
    }
    
}

extension RegisterController: RegisterViewProtocol {
  
    func registerButtonAction() {
        
//        if ((registerView?.mailTextField.text?.isEmpty) != nil) {
//            alerts?.getPlainAlert(title: "Wait", message: "Insert your email to continue")
//        } else if ((registerView?.passwordTextField.text?.isEmpty) != nil) {
//            alerts?.getPlainAlert(title: "Wait", message: "Insert your password to continue")
//        }
        
        ProgressHUD.shared.show()
//        self.registerView?.registeringActivity.startAnimating()
        
        guard let mail = self.registerView?.mailTextField.text else {return}
        guard let password = self.registerView?.passwordTextField.text else {return}
        
        print("\(mail) + \(password)")
        service.registerUser(mail: mail, password: password) { result in
            switch result {
 //               self.registerView.registeringActivity.hide()
            case .success(let data):
                print(data)
                print("Success")
                ProgressHUD.shared.hide()
                self.alerts?.getPlainAlert(title: "Success", message: "\(data.message ?? "")" , completionAction: {
                    self.openLogin()
                })
            case .failure(let error):
                print(error.localizedDescription)
                ProgressHUD.shared.hide()
                self.alerts?.getPlainAlert(title: "Error", message: "\(error)")
            }
        }
    }
    
    func loginButtonAction() {
        let loginVc = LoginController()
        self.navigationController?.pushViewController(loginVc, animated: true)
    }
}

extension RegisterController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.registerView?.mailTextField {
            registerView?.mailTextField.resignFirstResponder()
            registerView?.passwordTextField.becomeFirstResponder()
        } else if textField == self.registerView?.passwordTextField {
            registerView?.passwordTextField.resignFirstResponder()
//            self.registerButtonAction()
        }
        return true
    }
}
