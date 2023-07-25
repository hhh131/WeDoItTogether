//
//  HomeViewController.swift
//  WeDoItTogether
//
//  Created by 최하늘 on 2023/07/14.
//

import UIKit

class HomeViewController: UIViewController, NewPostViewControllerDelegate {
    
    let homeView = HomeView()
    
    convenience init(title: String) {
        self.init()
        self.title = title
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        
        navigationItem.rightBarButtonItem = addButton
    }
    
    override func loadView() {
        self.view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeView.collectionView.reloadData()
    }
    
    @objc private func addButtonTapped() {
        let newPostVC = NewPostViewController()
        newPostVC.delegate = self // Set the delegate
        newPostVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(newPostVC, animated: true)
    }
    
    @objc private func anyCellClicked() {
        let detailViewController = DetailContentViewController()
        detailViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    @objc private func dismissNewPostVC() {
        dismiss(animated: true, completion: nil)
    }
    
    func newPostViewController(_ viewController: NewPostViewController, didAddNewItem item: Item) {
        homeView.testModel.append(item)
        homeView.collectionView.reloadData() // Reload the collection view with the updated testModel
    }
}

extension HomeView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func findViewController() -> UIViewController? {
        var responder: UIResponder? = self
        
        while let nextResponder = responder?.next {
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
            responder = nextResponder
        }
        
        return nil
    }
    
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selecteditem = testModel[indexPath.item]
        
        if let homeViewController = self.findViewController() as? HomeViewController {
            let detailViewController = DetailContentViewController()
            detailViewController.item = selecteditem
            homeViewController.navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 25
    }
}

