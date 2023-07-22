//
//  ProfileEditViewController.swift
//  WeDoItTogether
//
//  Created by 방유빈 on 2023/07/22.
//

import UIKit

class ProfileEditViewController: UIViewController {
    let profileEditView = ProfileEditView()
    
    convenience init(title: String) {
        self.init()
        self.title = title
    }
    
    override func loadView() {
        self.view = profileEditView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(touchUpSavebutton))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setCircleImageView(imageView: profileEditView.profilePhotoImageView, border: 1, borderColor: UIColor.gray.cgColor)
        setCircleImageView(imageView: profileEditView.cameraIconImageView)
    }
    
}

extension ProfileEditViewController{
    @objc func touchUpSavebutton(_ sender: UIBarButtonItem){
        //TODO: 데이터 저장 로직 필요
        self.navigationController?.popViewController(animated: true)
    }
}
