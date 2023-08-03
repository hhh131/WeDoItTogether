//
//  ForgetPasswordViewController.swift
//  WeDoItTogether
//
//  Created by 신희권 on 2023/07/19.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseDatabase

class ForgetPasswordViewController: UIViewController {

    
    let forgetPasswordView = ForgetPasswordView()
    var email: String?

    override func loadView() {
        self.view = forgetPasswordView

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setButtons()
    }

    func setButtons() {
        forgetPasswordView.findPasswordButton.addTarget(self, action: #selector(touchUpFindPasswordButton), for: .touchUpInside)
    }

    @objc func touchUpFindPasswordButton(){

        sendPassword()
    }

    func sendPassword() {
        guard let email = forgetPasswordView.emailTextField.text else { return }

        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                if let ErrorCode = AuthErrorCode.Code(rawValue: (error._code)) {
                    switch ErrorCode {
                    case AuthErrorCode.invalidEmail:
                        self.showAlert(message: "유효하지 않은 이메일 입니다", yesAction: nil)
                    case AuthErrorCode.missingEmail:
                        self.showAlert(message: "이메일을 입력 해 주세요", yesAction: nil)
                    default:
                        self.showAlert(message: "에러 발생", yesAction: nil)
                    }
                }
            }
            self.showAlert(message: "이메일 발송 완료", yesAction: {
                ForgetPasswordViewController().dismiss(animated: true)
            })
        }
    }


}
