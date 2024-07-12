//
//  RegisterView.swift
//  Star Pomodoro
//
//  Created by Henrique Marques on 27/09/23.
//

import UIKit

protocol RegisterViewProtocol: AnyObject {
    func registerButtonAction()
    func loginButtonAction()
}

class RegisterView: UIView {
    
    weak var delegate: RegisterViewProtocol?
    
    func delegate(delegate: RegisterViewProtocol) {
        self.delegate = delegate
    }
    
    lazy var registerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    lazy var registerTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Welcome to Star Pomodoro"
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
        textField.layer.shadowOffset = CGSize(width: 1, height: 1)
        textField.layer.shadowColor = UIColor.systemYellow.withAlphaComponent(0.5).cgColor
        textField.layer.shadowOpacity = 1
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
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
    
    lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setButtonStyling(layout: .normal)
        button.setTitle("Register", for: .normal)
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize(width: -1, height: 0)
        button.layer.shadowColor = UIColor.systemBackground.cgColor
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 5
        button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var alreadyRegisteredButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Already have a count?, Login in", for: .normal)
//        button.font = .systemFont(ofSize: 12, weight: .light)
        button.addTarget(self, action: #selector(alreadyRegisteredButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func registerButtonTapped() {
        self.delegate?.registerButtonAction()
    }
    
    @objc func alreadyRegisteredButtonTapped() {
        self.delegate?.loginButtonAction()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewCode()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

extension RegisterView: ViewCode {
    
    func configureSubViews() {
        self.addSubview(self.registerStackView)
        self.registerStackView.addArrangedSubview(self.registerTitle)
        self.registerStackView.addArrangedSubview(self.mailTextField)
        self.registerStackView.addArrangedSubview(self.passwordTextField)
        self.registerStackView.addArrangedSubview(self.registerButton)
        self.registerStackView.addArrangedSubview(self.alreadyRegisteredButton)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
        
            self.registerStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 24),
            self.registerStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.registerStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.registerStackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            
            self.mailTextField.heightAnchor.constraint(equalToConstant: 44),
            self.passwordTextField.heightAnchor.constraint(equalToConstant: 44),
            
            self.registerButton.heightAnchor.constraint(equalToConstant: 44),
            self.registerButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 100),
            self.registerButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -100),
            
            self.alreadyRegisteredButton.heightAnchor.constraint(equalToConstant: 16),
           // self.registerButton.widthAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    func configureAdditionalBehaviors() {
        self.backgroundColor = .tertiarySystemBackground
    }
    
    func configureAccessibility() {
        
    }
        
}
