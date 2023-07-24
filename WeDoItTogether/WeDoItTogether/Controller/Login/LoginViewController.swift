//
//  ViewController.swift
//  WeDoItTogether
//
//  Created by 방유빈 on 2023/07/13.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    let loginView = LoginView()
    var errorMessage: String = ""
    
    override func loadView() {
        self.view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setButtons()
    }
    
    func setButtons() {
        loginView.loginButton.addTarget(self, action: #selector(touchUpLoginButton), for: .touchUpInside)
        loginView.registerButton.addTarget(self, action: #selector(touchUpRegisterButton), for: .touchUpInside)
        loginView.forgetPasswordButton.addTarget(self, action: #selector(touchUpForgetPasswordButton), for: .touchUpInside)
    }
}

//MARK: - 버튼 addTarget
extension LoginViewController {
    
    //로그인버튼 클릭
    @objc func touchUpLoginButton(_ sender: UIButton) {
        let email: String = loginView.emailTextField.text!.description
        let password: String = loginView.passwordTextField.text!.description
        guard validate() else {
            resetTextField()
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) {authResult, error in
            if authResult != nil {
                //SceneDelegate changeRootView 호출
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootView(TabBarController(), animated: true)

            } else {
                self.showAlert(message: "등록되지 않은 정보입니다.", yesAction: nil)
                self.showAlert(message: "필드를 모두 채워주세요", yesAction: nil)
                print(error.debugDescription)
            }
            
        }
    }
    
    //회원가입버튼 클릭
    @objc func touchUpRegisterButton(_ sender: UIButton) {
        let registerViewController = RegisterViewController()
        self.navigationController?.pushViewController(registerViewController, animated: true)
    }
    
    @objc func touchUpForgetPasswordButton(_ sender: UIButton) {

        //SceneDelegate changeRootView 호출
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootView(ForgetPasswordViewController(), animated: true)

    }
    
    private func validate() -> Bool{
        guard !loginView.emailTextField.text!.trimmingCharacters(in: .whitespaces).isEmpty,
              !loginView.passwordTextField.text!.trimmingCharacters(in: .whitespaces).isEmpty else {
            self.showAlert(message: "필드를 모두 채워주세요", yesAction: nil)
            return false
        }
        
        //email@aaa.com -> 양식 체크
        guard loginView.emailTextField.text!.contains("@") && loginView.emailTextField.text!.contains(".") else {
            self.showAlert(message: "이메일 형식이 맞지 않습니다.", yesAction: nil)
            return false
        }
        return true
    }
    func resetTextField(){
        loginView.emailTextField.text = ""
        loginView.passwordTextField.text = ""
    }
}
