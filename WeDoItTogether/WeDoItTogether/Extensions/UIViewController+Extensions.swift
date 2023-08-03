//
//  UIViewController+Extensions.swift
//  WeDoItTogether
//
//  Created by 최하늘 on 2023/07/20.
//

import Foundation
import UIKit

extension UIViewController {
    //배경 탭하면 키보드 내리기
    func tappedDismissKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    //키보드를 내리는 메서드
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //알림창 띄우기
    func showAlert(message: String, title: String = "알림", isCancelButton: Bool = false, yesAction: (() -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let yes = UIAlertAction(title: "확인", style: .default) {_ in
            yesAction?()
        }
        if isCancelButton {
            let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            alert.addAction(cancel)
        }
        alert.addAction(yes)
        
        present(alert, animated: true, completion: nil)
    }
    
    //네비게이션 뒤로가기 버튼 타이틀 변경 (이거 사용하실 때 a->b로 이동하면 a에서 선언해야 b에서 수정된답니다)
    func changeNavigationBackButton() {
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = backBarButtonItem
    }
    
    //원형 이미지 만들기 -> viewDidLayoutSubviews에서 호출
    func setCircleImageView(imageView: UIImageView, border: CGFloat = 0, borderColor: CGColor = UIColor.clear.cgColor){
        imageView.layer.cornerRadius = imageView.frame.width / 2.0
        imageView.layer.borderWidth = border
        imageView.layer.borderColor = borderColor
        imageView.clipsToBounds = true
    }
}
