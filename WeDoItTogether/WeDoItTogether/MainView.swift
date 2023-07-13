//
//  MainView.swift
//  Bibim
//
//  Created by 방유빈 on 2023/07/07.
//

import UIKit

class MainView: UIView {
    lazy var imgView:UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "figure.walk")
//        iv.layer.cornerRadius = iv.frame.height/2
//        iv.layer.borderWidth = 1
//        iv.layer.borderColor = UIColor.clear.cgColor
//        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = .black
        return iv
    }()
    lazy var signInLabel:UILabel = {
        let label = UILabel()
        label.text = "Sign In"
        label.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        return label
    }()
    lazy var emailLabel:UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    lazy var passwordLabel:UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    lazy var idTextField:UITextField = {
        let textField = UITextField()
        textField.placeholder = "Id를 입력해주세요."
        textField.borderStyle = .roundedRect
        return textField
    }()
    lazy var passwordTextField:UITextField = {
        let textField = UITextField()
        textField.placeholder = "password를 입력해주세요."
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        return textField
    }()
    lazy var loginButton:UIButton = {
        let button = UIButton(configuration: .tinted())
        button.setTitle("로그인", for: .normal)
        return button
    }()
    lazy var registerButton:UIButton = {
        let button = UIButton(configuration: .plain())
        button.setTitle("회원가입", for: .normal)
        return button
    }()
    lazy var forgetPasswordButton:UIButton = {
        let button = UIButton(configuration: .plain())
        button.setTitle("비밀번호 찾기", for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        setLayoutConstraints()
        
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func addView(){
        [imgView, idTextField, signInLabel, emailLabel, passwordLabel ,passwordTextField, loginButton, loginButton, registerButton, forgetPasswordButton].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    func setLayoutConstraints(){
        addView()
        //imgView
        NSLayoutConstraint.activate([
            imgView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 50),
            imgView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 50),
            imgView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -50),
            imgView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 50),
            imgView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -50),
            imgView.heightAnchor.constraint(equalTo: imgView.widthAnchor),
        ])
        imgView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        imgView.setContentHuggingPriority(.defaultLow, for: .vertical)
        
        //label + TextField
        NSLayoutConstraint.activate([
            signInLabel.topAnchor.constraint(equalTo: imgView.bottomAnchor, constant: 20),
            signInLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
            emailLabel.topAnchor.constraint(equalTo: signInLabel.bottomAnchor, constant: 15),
            emailLabel.leadingAnchor.constraint(equalTo: signInLabel.leadingAnchor),
            idTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 5),
            idTextField.leadingAnchor.constraint(equalTo: signInLabel.leadingAnchor),
            idTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30),
            passwordLabel.topAnchor.constraint(equalTo: idTextField.bottomAnchor, constant: 15),
            passwordLabel.leadingAnchor.constraint(equalTo: signInLabel.leadingAnchor),
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 5),
            passwordTextField.leadingAnchor.constraint(equalTo: signInLabel.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30),
        ])
        
        
        //버튼
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            loginButton.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            forgetPasswordButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            forgetPasswordButton.leadingAnchor.constraint(equalTo: loginButton.leadingAnchor),
            registerButton.topAnchor.constraint(equalTo: forgetPasswordButton.topAnchor),
            registerButton.trailingAnchor.constraint(equalTo: loginButton.trailingAnchor),
            registerButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -50)
        ])
    }
}
