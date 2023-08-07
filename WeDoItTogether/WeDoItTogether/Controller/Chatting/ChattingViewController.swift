//
//  ChattingViewController.swift
//  WeDoItTogether
//
//  Created by 방유빈 on 2023/07/14.
//
//TODO: -
import UIKit
import Firebase
import FirebaseDatabase

class ChattingViewController: UIViewController {
    private let reuseIdentifier = "ChattingCell"
    var encoder = JSONEncoder()
    let uid = "Heekwon"
    let chattingView = ChattingView()
    var ref: DatabaseReference = Database.database().reference().child("chats")
    var messages: [Message] = []
    var chatRoomUid = ""
    
    convenience init(title: String) {
        self.init()
        self.title = title
    }
    
    override func loadView() {
        self.view = chattingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chattingView.collectionView.dataSource = self
        chattingView.collectionView.delegate = self
        chattingView.sendButton.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        
        loadMessagesFromFirebase()
    }
    
    func roomCheck() {
        ref.queryOrdered(byChild: "users/\(uid)").queryEqual(toValue: true).observeSingleEvent(of: .value) { (datasnapshot) in
            for item in datasnapshot.children.allObjects as! [DataSnapshot] {
                self.chatRoomUid = item.key
            }
        }
    }
    
    
    func loadMessagesFromFirebase() {
        
        ref.child(chatRoomUid).queryOrdered(byChild: "timestamp").observe(.value) { (snapshot) in
            self.messages = []
            
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot {
                    if let messageData = snapshot.value as? [String: Any],
                       let text = messageData["text"] as? String,
                       let sender = messageData["sender"] as? String,
                       let timestamp = messageData["timestamp"] as? Int {
                        self.messages.append(Message(text: text, sender: sender, timestamp: timestamp))
                        self.chattingView.collectionView.reloadData()
                    }
                }
            }
        }
    }
    
    @objc func sendMessage() {
        //MARK: - 원래코드
        let text = chattingView.inputTextFeild.text ?? ""
        let timestamp = Int(Date().timeIntervalSince1970)
        let message = Message(text: text, sender: uid, timestamp: timestamp)
        
        do {
            let data = try encoder.encode(message)
            let json = try JSONSerialization.jsonObject(with: data)
            
            ref.child(chatRoomUid).childByAutoId().setValue(json) { (error, ref) in
                if let error = error {
                    print("Error sending message: \(error.localizedDescription)")
                } else {
                    print("Message sent successfully!")
                }
            }
        }
        catch {
            print("an error occurred", error)
        }
        chattingView.inputTextFeild.text = ""
    }
}

extension ChattingViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.register(MyChattingCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MyChattingCell
        cell.contentLabel.text = messages[indexPath.row].text
        cell.dateLabel.text =  String(messages[indexPath.row].timestamp)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt: IndexPath) -> CGSize {
        return CGSize(width: chattingView.safeAreaLayoutGuide.layoutFrame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //Code
    }
    
}

