//
//  RegisterViewController.swift
//  WeDoItTogether
//
//  Created by 최하늘 on 2023/07/19.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseDatabase
import SwiftSMTP

class RegisterViewController: UIViewController {
    
    let registerView = RegisterView()
    
    var userEmail: String?
    var userName: String?
    var userPassword: String?
    var authNum: String?
    
    var isEmailAuth: Bool = false
    var isAuthNumCheck: Bool = false
    
    override func loadView() {
        super.loadView()
        self.view = registerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tappedDismissKeyboard()
        setTextFields()
        setButtons()
    }
    
    func setTextFields() {
        registerView.passwordTextField.addTarget(self, action: #selector(editingPasswordTextField), for: .editingChanged)
        registerView.passwordCheckTextField.addTarget(self, action: #selector(edittedPasswordCheckTextField), for: .editingDidEnd)
    }
    
    func setButtons() {
        registerView.emailAuthButton.addTarget(self, action: #selector(touchUpEmailAuthButton), for: .touchUpInside)
        registerView.authNumCheckButton.addTarget(self, action: #selector(touchUpAuthNumCheckButton), for: .touchUpInside)
        registerView.registerButton.addTarget(self, action: #selector(touchUpRegisterButton), for: .touchUpInside)
    }
    
    func checkUserData() -> User? {
        guard let userEmail = userEmail, let userName = userName, let userPassword = userPassword else {
            self.showAlert(message: "다시 시도해주세요", yesAction: nil)
            return nil
        }
        
        return User(email: userEmail, name: userName, password: userPassword)
    }
}

//MARK: - 텍스트필드 액션
extension RegisterViewController {
    @objc func editingPasswordTextField(_ sender: UITextField) {
        guard let text = sender.text, text.count > 7 else {
            registerView.passwordErrorLabel.isHidden = false
            registerView.passwordErrorLabel.text = "비밀번호를 8자이상 입력하세요."
            return
        }
        
        guard text.isValidCheckPassword() else {
            registerView.passwordErrorLabel.isHidden = false
            registerView.passwordErrorLabel.text = "영문과 숫자를 조합하여 8~20자로 입력하세요."
            return
        }
        registerView.passwordErrorLabel.isHidden = true
    }
    
    @objc func edittedPasswordCheckTextField(_ sender: UITextField) {
        guard let text = sender.text, text == registerView.passwordTextField.text else {
            registerView.passwordCheckErrorLabel.isHidden = false
            registerView.passwordCheckErrorLabel.text = "비밀번호가 일치하지 않습니다."
            return
        }
        registerView.passwordCheckErrorLabel.isHidden = true
    }
}

//MARK: - 버튼액션
extension RegisterViewController {
    @objc func touchUpEmailAuthButton(_ sender: UIButton) {
        guard let userEmail = registerView.emailTextField.text, userEmail.contains("@"), userEmail.contains(".") else {
            self.showAlert(message: "이메일 형식으로 채워주세요", yesAction: nil)
            return
        }
        
        sendAuthNum(email: userEmail) {
            self.isEmailAuth = true
            self.registerView.emailAuthButton.isEnabled = false
        }
    }
    
    @objc func touchUpAuthNumCheckButton(_ sender: UIButton) {
        guard authNum != nil, let authNumText = registerView.authNumTextField.text, authNum == authNumText else {
            self.showAlert(message: "인증번호가 일치하지 않습니다", yesAction: nil)
            return
        }
        
        isAuthNumCheck = true
        sender.isEnabled = false
        self.showAlert(message: "인증이 완료되었습니다", yesAction: nil)
    }
    
    @objc func touchUpRegisterButton(_ sender: UIButton) {
        guard validate() else {
            return
        }
        
        guard let userData = checkUserData() else {
            return
        }
        Auth.auth().createUser(withEmail: userData.email, password: userData.password) { [weak self] result, error in
            if let error = error {
                if let ErrorCode = AuthErrorCode.Code(rawValue: (error._code)) {
                    switch ErrorCode {
                    case AuthErrorCode.invalidEmail:
                        self?.showAlert(message: "유효하지 않은 이메일 입니다.", yesAction: nil)
                        return
                        
                    case AuthErrorCode.emailAlreadyInUse:
                        self?.showAlert(message: "이미 가입한 회원 입니다.", yesAction: nil)
                        return
                        
                    case AuthErrorCode.weakPassword:
                        self?.showAlert(message: "비밀번호를 8자이상 입력하세요.", yesAction: nil)
                        return
                        
                    default:
                        self?.showAlert(message: "다시 한번 확인해 주세요.", yesAction: nil)
                        return
                    }
                }
            }
            self?.saveUserData()
            self?.showAlert(message: "가입이 되셨습니다, 회원이 되신 것을 환영합니다~") {
                self?.navigationController?.popViewController(animated: true)
            }
        }
        
    }
    
    private func saveUserData() {
        guard let userData = checkUserData() else {
            return
        }
        let newUser = User(email: userData.email,
                           name: userData.name,
                           password: userData.password,
                           joined: Date().timeIntervalSince1970)
        
        let ref = Database.database().reference()
        print("\(String(describing: Auth.auth().currentUser?.uid))")
        ref.child("users")
            .child("\(newUser.userId)")
            .setValue(newUser.asDictionary())
        
        //프로필 이미지 저장 (기본 이미지 저장)
        let defaultImage = UIImage(named: "blankProfile")!
        var data = Data()
        data = defaultImage.jpegData(compressionQuality: 0.8)!
        StorageManager.shared.uploadProfilePicture(with: data, filePath: "images/\(newUser.profilePictureFileName)") { result in
            switch result{
            case .success(let downloadUrl):
                UserDefaults.standard.set(downloadUrl, forKey: "profile_picture_url")
                print(downloadUrl)
            case .failure(let error):
                print("Storage manager error: \(error)")
            }
        }
    }
    
    
    private func validate() -> Bool {
        
        guard let userEmail = registerView.emailTextField.text, !userEmail.trimmingCharacters(in: .whitespaces).isEmpty else {
            self.showAlert(message: "이메일을 입력해주세요", yesAction: nil)
            return false
        }
        
        guard isEmailAuth else {
            self.showAlert(message: "이메일인증을 해주세요", yesAction: nil)
            return false
        }
        
        guard let authNum = registerView.authNumTextField.text, !authNum.trimmingCharacters(in: .whitespaces).isEmpty else {
            self.showAlert(message: "인증번호를 입력해주세요", yesAction: nil)
            return false
        }
        
        guard isAuthNumCheck else {
            self.showAlert(message: "이메일 인증번호를 확인해주세요", yesAction: nil)
            return false
        }
        
        guard let userName = registerView.nameTextField.text, !userName.trimmingCharacters(in: .whitespaces).isEmpty else {
            self.showAlert(message: "이름을 입력해주세요", yesAction: nil)
            return false
        }
        
        guard let userPassword = registerView.passwordTextField.text, !userPassword.trimmingCharacters(in: .whitespaces).isEmpty else {
            self.showAlert(message: "비밀번호를 입력해주세요", yesAction: nil)
            return false
        }
        
        guard let userPasswordCheck = registerView.passwordCheckTextField.text, !userPasswordCheck.trimmingCharacters(in: .whitespaces).isEmpty else {
            self.showAlert(message: "비밀번호 확인을 입력해주세요", yesAction: nil)
            return false
        }
        
        self.userEmail = userEmail
        self.userName = userName
        self.userPassword = userPassword
        
        return true
    }
}

//MARK: - 이메일 전송 관련
extension RegisterViewController  {
    //메일전송메소드
    func sendAuthNum(email: String, completion: @escaping () -> Void) {
        print("메일전송시작~")
        let masterEmail = "hanleeeee2@gmail.com"
        let masterPassword = "toxbvrewvqdgzpzu"
        
        let subject = "WeDoItTogether 이메일 인증 안내 메일"
        let content = """
                            인증 코드를 발급해드립니다.
                            
                            인증번호는 "\(makeRandomAuthNum())" 입니다.
                            
                            해당 인증코드를 입력해주세요.
                            
                            """
        
        // Update the SMTP hostname to "smtp.gmail.com" for Google's SMTP server.
        let smtp = SMTP(
            hostname: "smtp.gmail.com",
            email: masterEmail,
            password: masterPassword
        )
        
        let mail_from = Mail.User(name: "WeDoItTogether", email: masterEmail)
        let mail_to = Mail.User(name: "사용자", email: email)
        
        let mail = Mail(
            from: mail_from,
            to: [mail_to],
            subject: subject,
            text: content)
        
        DispatchQueue.global().async {
            smtp.send(mail) { error in
                DispatchQueue.main.async {
                    if let error = error {
                        print("\(error), \(error.localizedDescription)")
                        self.showAlert(message: "메일 전송에 실패하셨습니다.", yesAction: nil)
                        
                        return
                    }
                    self.showAlert(message: "메일 전송에 성공하셨습니다. 메일함을 확인해주세요.", yesAction: nil)
                    completion()
                }
            }
        }
    }
    
    //난수 만들기
    private func makeRandomAuthNum() -> String {
        let str = (0 ..< 8).map{ _ in "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789".randomElement()! }
        
        authNum = String(str)
        return String(str)
    }
}
