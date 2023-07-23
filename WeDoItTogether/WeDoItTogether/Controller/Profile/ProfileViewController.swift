//
//  ProfileViewController.swift
//  WeDoItTogether
//
//  Created by 방유빈 on 2023/07/14.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {
    let profileView = ProfileView()
    
    convenience init(title: String) {
        self.init()
        self.title = title
    }
    
    override func loadView() {
        self.view = profileView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setButtons()
        // Do any additional setup after loading the view.
    }
    
    func setButtons(){
        profileView.profileEditButton.addTarget(self, action: #selector(touchUpProfileEditButton), for: .touchUpInside)
        profileView.logoutButton.addTarget(self, action: #selector(touchUpLogoutButton), for: .touchUpInside)
    }

}

//MARK: - 버튼 addTarget
extension ProfileViewController {
    
    //프로필 수정 버튼 클릭
    @objc func touchUpProfileEditButton(_ sender: UIButton) {
        let profileEditViewController = ProfileEditViewController(title: "프로필 수정")
        self.navigationController?.pushViewController(profileEditViewController, animated: true)
    }
    @objc func touchUpLogoutButton(_ sender: UIButton){
        //TODO: 로그아웃 기능 구현 필요
          do {
            try Auth.auth().signOut()
              (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootView(UINavigationController(rootViewController: LoginViewController()), animated: true)
          } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
}
