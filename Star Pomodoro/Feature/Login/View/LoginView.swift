//
//  LoginView.swift
//  Star Pomodoro
//
//  Created by Henrique Marques on 27/09/23.
//

import UIKit

protocol LoginViewProtocol: AnyObject {
    func loginAction()
}

class LoginView: UIView {
    
    weak var delegate: LoginViewProtocol?
    
    func delegate(delegate: LoginViewProtocol) {
        self.delegate = delegate
    }
    
    lazy var loginStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.backgroundColor = .clear
        stackView.alignment = .center
        return stackView
    }()
    
    lazy var registerTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Login"
        label.textColor = .label
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 32, weight: .heavy)
//        label.layer.shadowOpacity = 0.5
//        label.layer.shadowOffset = CGSize(width: 1, height: 1)
//        label.layer.shadowColor = UIColor.systemYellow.withAlphaComponent(0.5).cgColor
//        label.layer.shadowOpacity = 1
//        label.layer.shadowRadius = 0
        return label
    }()
    
    lazy var mailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Email"
        textField.backgroundColor = .secondarySystemBackground
        textField.layer.masksToBounds = false
        textField.layer.cornerRadius = 12
        textField.keyboardType = .emailAddress
        textField.enablesReturnKeyAutomatically = true
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 28))
        textField.leftView = leftPaddingView
        textField.leftViewMode = .always
        textField.layer.shadowOpacity = 0.5
        textField.autocapitalizationType = .none
        textField.layer.shadowOffset = CGSize(width: 1, height: 1)
        textField.layer.shadowColor = UIColor.systemYellow.withAlphaComponent(0.5).cgColor
        textField.layer.shadowOpacity = 1
        textField.autocorrectionType = .no
        textField.layer.shadowRadius = 0
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Password"
        textField.backgroundColor = .secondarySystemBackground
   //     textField.borderStyle = .bezel
        textField.layer.masksToBounds = false
        textField.layer.cornerRadius = 12
        textField.enablesReturnKeyAutomatically = true
        textField.isSecureTextEntry = true
        textField.autocorrectionType = .no
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 28))
        textField.leftView = leftPaddingView
        textField.leftViewMode = .always
        textField.layer.shadowOpacity = 0.5
        textField.layer.shadowOffset = CGSize(width: 1, height: 1)
        textField.layer.shadowColor = UIColor.systemYellow.withAlphaComponent(0.5).cgColor
        textField.layer.shadowOpacity = 1
        textField.layer.shadowRadius = 0
        return textField
    }()
    
    func mailTextFieldDelegate(delegate: UITextFieldDelegate) {
        self.mailTextField.delegate = delegate
    }
    
    func passwordTextFieldDelegate(delegate: UITextFieldDelegate) {
        self.passwordTextField.delegate = delegate
    }
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setButtonStyling(layout: .normal)
        button.setTitle("Login", for: .normal)
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize(width: -1, height: 0)
        button.layer.shadowColor = UIColor.systemBackground.cgColor
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 5
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func loginButtonTapped() {
        self.delegate?.loginAction()
    }
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewCode()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension LoginView: ViewCode {
    
    func configureSubViews() {
        self.addSubview(self.loginStackView)
        self.loginStackView.addArrangedSubview(self.registerTitle)
        self.loginStackView.addArrangedSubview(self.mailTextField)
        self.loginStackView.addArrangedSubview(self.passwordTextField)
        self.loginStackView.addArrangedSubview(self.loginButton)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
        
            self.loginStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32),
            self.loginStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.loginStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.loginStackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -32),
            
            self.mailTextField.heightAnchor.constraint(equalToConstant: 44),
            self.mailTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            self.mailTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            
            self.passwordTextField.heightAnchor.constraint(equalToConstant: 44),
            self.passwordTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            self.passwordTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            
            self.loginButton.heightAnchor.constraint(equalToConstant: 44),
            self.loginButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 100),
            self.loginButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -100),
                    
        ])
    }
    
    func configureAdditionalBehaviors() {
        self.backgroundColor = .tertiarySystemBackground
    }
    
    func configureAccessibility() {
        
    }
}
