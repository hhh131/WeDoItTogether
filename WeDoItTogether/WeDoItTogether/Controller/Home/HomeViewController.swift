//
//  HomeViewController.swift
//  WeDoItTogether
//
//  Created by 최하늘 on 2023/07/14.
//

import UIKit
import Firebase

class HomeViewController: UIViewController, AddContentDelegate {
    
    let homeView = HomeView()
    var testModel = dataSource
    
    var user = UserDefaultsData.shared.getUser()
    
    convenience init(title: String) {
        self.init()
        self.title = title
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    override func loadView() {
        super.loadView()
        self.view = homeView
        homeView.collectionView.delegate = self
        homeView.collectionView.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDatabaseInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    @objc private func addButtonTapped() {
        let addContentViewController = AddContentViewController()
        addContentViewController.delegate = self
        navigationController?.pushViewController(addContentViewController, animated: true)
    }
    
    @objc private func anyCellClicked() {
        let detailViewController = DetailContentViewController()
        detailViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    @objc private func getDatabaseInfo() {
        let ref = Database.database().reference()
        let itemsRef = ref.child("items")
        
        itemsRef.observeSingleEvent(of: .value) { (snapshot) in
            if let items = snapshot.children.allObjects as? [DataSnapshot] {
                for itemSnapshot in items {
                    if let itemInfo = itemSnapshot.value as? [String: Any],
                       let title = itemInfo["title"] as? String,
                       let location = itemInfo["location"] as? String,
                       let memo = itemInfo["memo"] as? String,
                       let date = itemInfo["date"] as? String,
                       let members = itemInfo["members"] as? [String],
                       let emails = itemInfo["emails"] as? [String] {
                        
                            if emails.contains(self.user?.email ?? "") {
                                let item = Item(title: title, date: date, location: location, memo: memo, members: members, emails: emails)
                                self.testModel.append(item)
                            }
                    }
                }
                
                self.homeView.collectionView.reloadData()
            }
        }
    }
    
    func didSaveItem(_ item: Item) {
        testModel.append(item)
        homeView.collectionView.reloadData()
    }
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.bounds.width - 50
        let height: CGFloat = 130
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return testModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! HomeViewContentCell
        
        let item = testModel[indexPath.item]
        
        cell.titleLabel.text = item.title
        cell.locationLabel.text = item.location
        cell.dateLabel.text = item.date
        cell.memoLabel.text = "memo: \(item.memo)"
        
        let membersString = item.members.joined(separator: ", ")
        cell.membersLabel.text = membersString
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailContentViewController = DetailContentViewController()
        detailContentViewController.item = testModel[indexPath.item]
        self.navigationController?.pushViewController(detailContentViewController, animated: true)
    }
}
