//
//  ChattingViewController.swift
//  WeDoItTogether
//
//  Created by 방유빈 on 2023/07/14.
//

import UIKit
private let reuseIdentifier = "ChatListCell"
class ChatListViewController: UIViewController {
    let chatListView = ChatListView()
    var mockData = ChatList.mockData
   
    convenience init(title: String) {
        self.init()
        self.title = title
    }
    
    override func loadView() {
        self.view = chatListView
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chatListView.collectionView.dataSource = self
        chatListView.collectionView.delegate = self
        
        
    }
}

extension ChatListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ChatList.mockData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ChatListCell
        cell.contentLabel.text = mockData[indexPath.row].content
        cell.nameLabel.text = mockData[indexPath.row].name
        cell.dateLabel.text = "\(mockData[indexPath.row].date)"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt: IndexPath) -> CGSize {
        return CGSize(width: chatListView.safeAreaLayoutGuide.layoutFrame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let nav = UINavigationController(rootViewController: ChatListViewController())
//        nav.modalPresentationStyle = .overFullScreen
//        self.present(nav, animated: true)
        let vc = ChattingViewController()
        vc.hidesBottomBarWhenPushed = true
   
        navigationController?.pushViewController(vc, animated: true)
     
    }
    
}

