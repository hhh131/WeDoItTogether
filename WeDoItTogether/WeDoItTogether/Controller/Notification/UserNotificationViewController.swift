//
//  UserNotificationViewController.swift
//  WeDoItTogether
//
//  Created by 방유빈 on 2023/07/20.
//

import UIKit
import Firebase

class UserNotificationViewController: UIViewController {
    let user = UserDefaultsData.shared.getUser()
    let tableview = UITableView()
    
    var userNotifications: [UserNotification] = []
    
    override func loadView() {
        self.view = tableview
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getUserNotificationInfo()
    }
    
    private func configureTableView(){
        tableview.register(NotificationContentsTableViewCell.self, forCellReuseIdentifier: NotificationContentsTableViewCell.identifier)
        tableview.dataSource = self
        tableview.delegate = self
    }
    
    private func getUserNotificationInfo() {
        guard let user = user else {
            return
        }
        
        Loading.showLoading()
        userNotifications.removeAll()
        let ref = Database.database().reference()
        
        ref.child("userNotifications")
            .child(user.userId).observeSingleEvent(of: .value, with: { snapshot in
                // Get user value
                guard let objects = snapshot.children.allObjects as? [DataSnapshot] else{
                    return
                }
                
                for object in objects {
                    guard let value = object.value as? [String: Any],
                          let title = value["title"] as? String,
                          let content = value["content"] as? String,
                          let date = value["date"] as? String else {
                        return
                    }
                    
                    let newUserNotification = UserNotification(title: title, content: content, date: date)
                    self.userNotifications.append(newUserNotification)
                }
                self.tableview.reloadData()
                Loading.hideLoading()
            })
    }
}

extension UserNotificationViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userNotifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NotificationContentsTableViewCell.identifier, for: indexPath) as? NotificationContentsTableViewCell else { fatalError() }
        
        cell.iconImageView.image = UIImage(systemName: "clock.badge")
        cell.iconImageView.image?.withTintColor(.black)
        
        cell.categoryLabel.text = userNotifications[indexPath.row].title
        cell.titleLabel.text = userNotifications[indexPath.row].content
        cell.dateLabel.text = userNotifications[indexPath.row].timeDifference
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
