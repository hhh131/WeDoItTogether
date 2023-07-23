//
//  ProfileEditViewController.swift
//  WeDoItTogether
//
//  Created by 방유빈 on 2023/07/22.
//

import UIKit

class ProfileEditViewController: UIViewController {
    let profileEditView = ProfileEditView()
    let imgPicker = UIImagePickerController()
    
    convenience init(title: String) {
        self.init()
        self.title = title
    }
    
    override func loadView() {
        self.view = profileEditView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgPicker.delegate = self
        setButtons()
        setImageView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setCircleImageView(imageView: profileEditView.profilePhotoImageView, border: 1, borderColor: UIColor.gray.cgColor)
        setCircleImageView(imageView: profileEditView.cameraIconImageView)
    }
    
    func setButtons(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(touchUpSavebutton))
    }
    
    func setImageView(){
        let profileImage = UITapGestureRecognizer(target: self, action: #selector(touchUpProfileImageView))
        profileEditView.profilePhotoImageView.isUserInteractionEnabled = true
        profileEditView.profilePhotoImageView.addGestureRecognizer(profileImage)

    }
        
}

//MARK: - Button AddTarget
extension ProfileEditViewController{
    @objc func touchUpSavebutton(_ sender: UIBarButtonItem){
        //TODO: 데이터 저장 로직 필요
        self.navigationController?.popViewController(animated: true)
    }
    
}

//MARK: - ImageView AddGesture
extension ProfileEditViewController{
    enum CameraError : Error{
        case notAvailable
    }

    @objc func touchUpProfileImageView(){
        let alert =  UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        let library =  UIAlertAction(title: "앨범에서 가져오기", style: .default) { (action) in self.openLibrary() }
        let camera =  UIAlertAction(title: "카메라", style: .default) { (action) in
            guard (try? self.openCamera()) != nil else{
                self.showAlert(message: "카메라 접근 실패 : 카메라에 접근할 수 없습니다.") {
                    self.present(alert, animated: false, completion: nil)
                }
                print("Camera Not Available")
                return
            }
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(library)
        alert.addAction(camera)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    func openLibrary(){
        imgPicker.sourceType = .photoLibrary
        present(imgPicker, animated: false, completion: nil)
    }
    
    func openCamera() throws{
        guard UIImagePickerController .isSourceTypeAvailable(.camera) else {
            throw CameraError.notAvailable
        }
        imgPicker.sourceType = .camera
        present(imgPicker, animated: false, completion: nil)
    }
}

//MARK: - ImagePicker Delegate
extension ProfileEditViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            profileEditView.profilePhotoImageView.image = image
            print(info)
            
        }
        dismiss(animated: true, completion: nil)
    }
}

