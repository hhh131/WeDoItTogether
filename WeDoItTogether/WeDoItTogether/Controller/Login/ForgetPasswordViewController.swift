//
//  ForgetPasswordViewController.swift
//  WeDoItTogether
//
//  Created by 신희권 on 2023/07/19.
//

import UIKit
import FirebaseAuth

class ForgetPasswordViewController: UIViewController {
    
    let forgetPasswordView = ForgetPasswordView()
    var userEmail: String?
    
    override func loadView() {
        super.loadView()
        self.view = forgetPasswordView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButtons()
    }
    
    private func setButtons() {
        forgetPasswordView.findPasswordButton.addTarget(self, action: #selector(touchUpFindPasswordButton), for: .touchUpInside)
    }
}

//MARK: - 버튼 addTarget
extension ForgetPasswordViewController {
    @objc func touchUpFindPasswordButton(_ sender: UIButton) {
        guard validate() else {
            return
        }
        
        guard let userEmail = userEmail, userEmail.contains("@"), userEmail.contains(".") else {
            self.showAlert(message: "이메일 형식으로 채워주세요", yesAction: nil)
            return
        }
        
        Auth.auth().sendPasswordReset(withEmail: userEmail) { error in
            if let error = error {
                print(error)
                self.showAlert(message: "유효하지 않은 이메일 입니다", yesAction: nil)
            }

            self.showAlert(message: "메일을 전송하였습니다. 메일함을 확인해주세요.") {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    private func validate() -> Bool {
        guard let userEmail = forgetPasswordView.emailTextField.text, !userEmail.trimmingCharacters(in: .whitespaces).isEmpty else {
            self.showAlert(message: "이메일을 입력해주세요", yesAction: nil)
            return false
        }
        
        self.userEmail = userEmail
        return true
    }
}
