//
//  HomeViewController.swift
//  WeDoItTogether
//
//  Created by 최하늘 on 2023/07/14.
//

import UIKit

class HomeViewController: UIViewController, AddContentDelegate {
    func didSaveItem(_ item: Item) {
        testModel.append(item)
        homeView.collectionView.reloadData()
    }
    
    
    let homeView = HomeView()
    var testModel = dataSource
    
    convenience init(title: String) {
        self.init()
        self.title = title
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        
        navigationItem.rightBarButtonItem = addButton
    }
    
    override func loadView() {
        self.view = homeView
        homeView.collectionView.delegate = self
        homeView.collectionView.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeView.collectionView.reloadData()
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
    
    @objc private func dismissNewPostVC() {
        dismiss(animated: true, completion: nil)
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
        
        let membersString = item.members.joined(separator: ", ")
        cell.membersLabel.text = membersString
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 25
    }
}
