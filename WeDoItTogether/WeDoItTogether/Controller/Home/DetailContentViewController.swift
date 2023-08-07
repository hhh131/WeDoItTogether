//
//  DetailContentViewController.swift
//  WeDoItTogether
//
//  Created by 오영석 on 2023/07/21.
//

import UIKit
import MapKit
import Firebase

class DetailContentViewController: UIViewController, MKMapViewDelegate {
    
    let detailContentView = DetailContentView()
    var item: Item?
    var user = UserDefaultsData.shared.getUser()
    
    let userLocation = UserDefaultsData.shared.getLocation()
    
    override func loadView() {
        super.loadView()
        self.view = detailContentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUILabel()
        configureTableView()
        setButtons()
        barButton()
    }
    
    func updateUILabel() {
        detailContentView.titleLabel.text = item?.title
        detailContentView.locationLabel.text = item?.location
        detailContentView.dateLabel.text = item?.date
        let membersString = item?.members.joined(separator: ", ") ?? ""
        detailContentView.membersLabel.text = membersString
    }
    
    private func configureTableView() {
        detailContentView.collectionView.register(MapCollectionViewCell.self, forCellWithReuseIdentifier: MapCollectionViewCell.identifier)
        detailContentView.collectionView.dataSource = self
        detailContentView.collectionView.delegate = self
    }
    
    private func setButtons() {
        guard let user = user else { return }
        guard item?.creator == user.email else {
            return
        }
        
        detailContentView.deleteButton.isEnabled = true
        detailContentView.deleteButton.addTarget(self, action: #selector(touchUpDeleteButton), for: .touchUpInside)
    }
    
    @objc func touchUpDeleteButton() {
        self.showAlert(message: "약속을 삭제하시겠습니까?", isCancelButton: true) {
            self.deleteItem()
        }
    }
    
    private func deleteItem() {
        guard let item = item else {
            return
        }
        
        let ref = Database.database().reference()
        let itemRefToDelete = ref.child("items").child(item.id.uuidString)

        itemRefToDelete.removeValue { error, _ in
            if let error = error {
                print("Error deleting item: \(error.localizedDescription)")
            } else {
                print("Item deleted successfully.")
            }
        }
    }
    
    func barButton() {
        let joinButton = UIBarButtonItem(title: "약속 참가", style: .plain, target: self, action: #selector(joinButtonClicked))
        navigationItem.rightBarButtonItem = joinButton
    }
    
    @objc private func joinButtonClicked() {
        print("hello world")
    }
}

//MARK: - 컬렉션뷰 관련
extension DetailContentViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MapCollectionViewCell.identifier, for: indexPath) as? MapCollectionViewCell else { fatalError() }
        cell.mapView.delegate = self
        
        let center = CLLocationCoordinate2D(latitude: userLocation.latitude, longitude: userLocation.longitude)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 1000, longitudinalMeters: 1000)
        cell.mapView.setRegion(region, animated: true)
        
        let pin = MKPointAnnotation()
        pin.coordinate = center
        pin.title = "나 여기임"

        cell.mapView.addAnnotation(pin)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: Double = self.view.frame.width
        
        return CGSize(width: width, height: width)
    }
}
