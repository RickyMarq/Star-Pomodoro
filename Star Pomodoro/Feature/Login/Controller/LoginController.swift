//
//  LoginController.swift
//  Star Pomodoro
//
//  Created by Henrique Marques on 27/09/23.
//
 
import UIKit

class LoginController: UIViewController {
    
    var loginView: LoginView?
    var loginService: LoginService?
    var alerts: Alerts?
    var defaults = UserDefaults.standard
    var sessionToken: String?
    
    override func loadView() {
        self.loginView = LoginView()
        self.view = loginView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginService = LoginService()
        self.alerts = Alerts(controller: self)
        self.loginView?.delegate(delegate: self)
        self.loginView?.mailTextFieldDelegate(delegate: self)
        self.loginView?.passwordTextFieldDelegate(delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.hidesBackButton = true
    }
    
    func openHome() {
        let vc = HomeController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension LoginController: LoginViewProtocol {
    
    func loginAction() {
        ProgressHUD.shared.show()

        guard let mail = self.loginView?.mailTextField.text else {return}
        guard let password = self.loginView?.passwordTextField.text else {return}
        
        loginService?.loginUser(mail: mail, password: password, completion: { result in
            
            switch result {
                
            case .success(let data):
                print("Success")
                ProgressHUD.shared.hide()
                print(data)
                self.sessionToken = data.userID
                self.defaults.setValue(self.sessionToken, forKey: "SessionToken")
                self.openHome()
                print("DEBUG MODE: Session Token \(self.sessionToken ?? "")")
//                self.alerts?.getPlainAlert(title: "Message", message: "\(data.message ?? "") + ID: \(data.userID ?? "")")
                
//                self.alerts?.getPlainAlert(title: "Success", message: "\(data.message ?? "")", completionAction: {
//                    self.openHome()
//                })
            case .failure(let error):
                print("Success")
                print("\(error.localizedDescription)")
                ProgressHUD.shared.hide()
                self.alerts?.getPlainAlert(title: "Error", message: "\(error)")
            }
        })
    }
}

extension LoginController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.loginView?.mailTextField {
            loginView?.mailTextField.resignFirstResponder()
            loginView?.passwordTextField.becomeFirstResponder()
        } else if textField == self.loginView?.passwordTextField {
            loginView?.passwordTextField.resignFirstResponder()
//            self.registerButtonAction()
        }
        return true
    }
    
}
