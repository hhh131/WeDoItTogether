//
//  ViewController.swift
//  WeDoItTogether
//
//  Created by 방유빈 on 2023/07/13.
//

import UIKit

class LoginViewController: UIViewController {

    let loginView = LoginView()
    
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
    }
}

//MARK: - 버튼 addTarget
extension LoginViewController {
    
    //로그인버튼 클릭
    @objc func touchUpLoginButton(_ sender: UIButton) {

        //SceneDelegate changeRootView 호출
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootView(TabBarController(), animated: true)

    }
    
    //회원가입버튼 클릭
    @objc func touchUpRegisterButton(_ sender: UIButton) {
        let registerViewController = RegisterViewController()
        self.navigationController?.pushViewController(registerViewController, animated: true)
    }
}
