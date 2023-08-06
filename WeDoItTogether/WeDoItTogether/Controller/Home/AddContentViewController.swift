//
//  AddContentViewController.swift
//  WeDoItTogether
//
//  Created by 오영석 on 2023/08/07.
//

import UIKit
import Firebase
import UserNotifications


protocol AddContentDelegate: AnyObject {
    func didSaveItem(_ item: Item)
}

class AddContentViewController: UIViewController {
    
    weak var delegate: AddContentDelegate?
    
    var user = UserDefaultsData.shared.getUser()
    let addContentView = AddContentView()
    
    let userNotificationCenter = UNUserNotificationCenter.current()
    
    override func loadView() {
        self.view = addContentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        addContentView.searchLocationButton.addTarget(self, action: #selector(searchLocationButton), for: .touchUpInside)
    }
    
    
    func setNavigation() {
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonTapped))
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonTapped))
        
        self.navigationItem.leftBarButtonItem = cancelButton
        self.navigationItem.rightBarButtonItem = saveButton
    }
    
}

extension AddContentViewController {
    
    @objc func searchLocationButton(_ sender: UIButton) {
        let addContentMapViewController = AddContentMapViewController()
        self.navigationController?.pushViewController(addContentMapViewController, animated: true)
    }
    
    @objc func saveButtonTapped(_ sender: UIButton) {
        let titleText = addContentView.titleTextField.text ?? ""
        //        let locationText = contentView.locationTextField.text ?? ""
        let memoText = addContentView.memoTextField.text ?? ""
        let dateString = addContentView.dateResultLabel.text ?? ""
        
        guard let user = user else {
            return
        }
        
        let newItem = Item(title: titleText, date: dateString, location: "", memo: memoText, members: [user.name], emails: [user.email], creator: user.email)
        let newItemDictionary = newItem.asDictionary()
        
        let database = Database.database().reference()
        let newItemRef = database.child("items").child("\(newItem.id)")
        
        newItemRef.setValue(newItemDictionary)
        
        delegate?.didSaveItem(newItem)
        
        //알림 추가
        self.userNotificationCenter.addNotificationRequest(item: newItem)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func cancelButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
