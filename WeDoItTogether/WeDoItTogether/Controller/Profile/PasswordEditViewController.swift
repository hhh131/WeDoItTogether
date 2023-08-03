//
//  PasswordEditViewController.swift
//  WeDoItTogether
//
//  Created by 방유빈 on 2023/07/27.
//

import UIKit
import Firebase
import FirebaseDatabase

class PasswordEditViewController: UIViewController {
    let passwordEditView = PasswordEditView()
    var user = UserDefaultsData.shared.getUser()
    
    convenience init(title: String) {
        self.init()
        self.title = title
    }
    
    override func loadView() {
        self.view = passwordEditView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextFields()
        setButtons()
        
        // Do any additional setup after loading the view.
    }
    
    func setTextFields() {
        passwordEditView.currentPasswordTextField.addTarget(self, action: #selector(editingCurrentPasswordTextField), for: .editingChanged)
        passwordEditView.newPasswordTextField.addTarget(self, action: #selector(edittedNewPasswordTextField), for: .editingChanged)
        passwordEditView.newPasswordCheckTextField.addTarget(self, action: #selector(edittedNewPasswordCheckTextField), for: .editingChanged)
    }
    
    func setButtons() {
        passwordEditView.saveButton.addTarget(self, action: #selector(touchUpSaveButton), for: .touchUpInside)
    }
}

//MARK: - 텍스트필드 액션
extension PasswordEditViewController {
    @objc func editingCurrentPasswordTextField(_ sender: UITextField) {
        guard let text = sender.text, text == user?.password else {
            passwordEditView.currentPasswordErrorLabel.isHidden = false
            passwordEditView.currentPasswordErrorLabel.text = "현재 비밀번호와 일치하지 않습니다"
            return
        }
        passwordEditView.currentPasswordErrorLabel.isHidden = true
    }
    
    @objc func edittedNewPasswordTextField(_ sender: UITextField) {
        guard let text = sender.text, text.isValidCheckPassword() else {
            passwordEditView.newPasswordErrorLabel.isHidden = false
            passwordEditView.newPasswordErrorLabel.text = "영문과 숫자를 조합하여 8~20자로 입력하세요."
            return
        }
        passwordEditView.newPasswordErrorLabel.isHidden = true
    }
    
    @objc func edittedNewPasswordCheckTextField(_ sender: UITextField) {
        guard let text = sender.text, text == passwordEditView.newPasswordTextField.text else {
            passwordEditView.newPasswordCheckErrorLabel.isHidden = false
            passwordEditView.newPasswordCheckErrorLabel.text = "비밀번호가 일치하지 않습니다."
            return
        }
        passwordEditView.newPasswordCheckErrorLabel.isHidden = true
    }
}

//MARK: - 버튼액션
extension PasswordEditViewController {
    @objc func touchUpSaveButton(_ sender: UIButton) {
        guard validate() else {
            return
        }
        
        let ref = Database.database().reference()
        guard let name: String = user?.name else {
            return
        }
        guard let email: String = user?.email else {
            return
        }
        guard let newPassword: String = passwordEditView.newPasswordTextField.text else {
            return
        }
        UserDefaultsData.shared.setUser(email: email, name: name, password: newPassword)
        
        guard let userId = user?.userId else { return }
        ref.child("users").child(userId).updateChildValues(["password": newPassword])
        
        self.showAlert(message: "패스워드 설정이 완료되었습니다.") {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    private func validate() -> Bool {
        guard let userPassword = passwordEditView.currentPasswordTextField.text, userPassword == user?.password else {
            self.showAlert(message: "현재 비밀번호를 다시 확인해주세요", yesAction: nil)
            return false
        }

        guard let userNewPassword = passwordEditView.newPasswordTextField.text, !userNewPassword.trimmingCharacters(in: .whitespaces).isEmpty else {
            self.showAlert(message: "비밀번호를 입력해주세요", yesAction: nil)
            return false
        }
        
        guard let userNewPasswordCheck = passwordEditView.newPasswordCheckTextField.text, !userNewPasswordCheck.trimmingCharacters(in: .whitespaces).isEmpty else {
            self.showAlert(message: "비밀번호 확인을 입력해주세요", yesAction: nil)
            return false
        }
        guard userNewPassword == userNewPasswordCheck else {
            self.showAlert(message: "새 비밀번호를 다시 입력해주세요", yesAction: nil)
            return false
        }
        
        return true
    }
}
