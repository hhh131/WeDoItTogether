//
//  ProfileEditViewController.swift
//  WeDoItTogether
//
//  Created by 방유빈 on 2023/07/22.
//

import UIKit
import Firebase
import FirebaseDatabase

class ProfileEditViewController: UIViewController {
    let profileEditView = ProfileEditView()
    let imgPicker = UIImagePickerController()
    var user = UserDefaultsData.shared.getUser()
    var newImage:UIImage?
    
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
        imgPicker.allowsEditing = true
        profileEditView.nameTextField.delegate = self
        setButtons()
        setImageView()
        setTextField()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setTextField()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setCircleImageView(imageView: profileEditView.profilePhotoImageView, border: 1, borderColor: UIColor.gray.cgColor)
        setCircleImageView(imageView: profileEditView.cameraIconImageView)
    }
    
    func setButtons(){
        //저장 버튼
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(touchUpSavebutton))
        //back 버튼
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(touchUpBackButton))
        //비밀번호 변경 버튼
        profileEditView.editPasswordButton.addTarget(self, action: #selector(touchUpEditPasswordButton), for: .touchUpInside)
    }
    
    func setImageView(){
        let profileImage = UITapGestureRecognizer(target: self, action: #selector(touchUpProfileImageView))
        profileEditView.profilePhotoImageView.isUserInteractionEnabled = true
        profileEditView.profilePhotoImageView.addGestureRecognizer(profileImage)
        
        guard let fileName = user?.profilePictureFileName else { return }
        let path = "images/images/" + fileName
        
        DispatchQueue.main.async{
            StorageManager.shared.downloadURL(for: path) { [weak self] result in
                switch result {
                case .success(let url):
                    StorageManager.shared.downloadImage(imageView: (self?.profileEditView.profilePhotoImageView)!, url: url)
                case .failure(let error):
                    print("Failed to get download url:\(error)")
                }
            }
        }
    }
    
    func setTextField(){
        profileEditView.nameTextField.text = user?.name
    }
}

//MARK: - Button AddTarget
extension ProfileEditViewController{
    //back 버튼
    @objc func touchUpBackButton(_ sender: UIBarButtonItem){
        self.showAlert(message: "프로필 편집을 취소하시겠습니까? 변경사항은 저장되지 않습니다.", isCancelButton: true) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    //저장 버튼
    @objc func touchUpSavebutton(_ sender: UIBarButtonItem){
        guard !profileEditView.nameTextField.text!.trimmingCharacters(in: .whitespaces).isEmpty else {
            self.showAlert(message: "필드를 모두 채워주세요", yesAction: nil)
            return
        }
        //이미지 변경 저장
        if let image = newImage {
            guard let filePath = user?.profilePictureFileName else {
                return
            }
            var data = Data()
            data = image.jpegData(compressionQuality: 0.8)!
            StorageManager.shared.uploadProfilePicture(with: data, filePath: "images/\(filePath)") { result in
                switch result{
                case .success(let downloadUrl):
                    UserDefaults.standard.set(downloadUrl, forKey: "profile_picture_url")
                    print(downloadUrl)
                case .failure(let error):
                    print("Storage manager error: \(error)")
                }
            }
        }
        
        let ref = Database.database().reference()
        let newName: String = profileEditView.nameTextField.text!
        let email: String = user?.email ?? ""
        let password: String = user?.password ?? ""
        let user = User(email: email, name: newName, password: password)
        UserDefaultsData.shared.setUser(email: email, name: newName, password: password)
        
        ref.child("users").child(user.userId).updateChildValues(["name": newName])
        self.showAlert(message: "변경사항이 저장되었습니다.") {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    //비밀 번호 변경 버튼
    @objc func touchUpEditPasswordButton(_ sender: UIButton){
        let passwordEditViewController = PasswordEditViewController(title: "비밀번호 변경")
        self.navigationController?.pushViewController(passwordEditViewController, animated: true)
    }
    
}

//MARK: - ImageView AddGesture
extension ProfileEditViewController{
    enum CameraError : Error{
        case notAvailable
    }

    @objc func touchUpProfileImageView(){
        let alert =  UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
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
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            profileEditView.profilePhotoImageView.image = image
            newImage = image
            
            print(info)
            
        }
        dismiss(animated: true, completion: nil)
    }
}

//MARK: - TextField Delegate
extension ProfileEditViewController : UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // 백스페이스 처리
        if let char = string.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if isBackSpace == -92 {
                return true
            }
        }
        //글자수 제한
        guard textField.text!.count < 10 else { return false }
        return true
    }
}
