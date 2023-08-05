import UIKit
import MapKit
import Firebase

protocol AddContentDelegate: AnyObject {
    func didSaveItem(_ item: Item)
}

class AddContentViewController: UIViewController, MKMapViewDelegate {
    
    weak var delegate: AddContentDelegate?
    
    var user = UserDefaultsData.shared.getUser()
    let addContentView = AddContentView()
    var testModel = dataSource
    let userLocation = UserDefaultsData.shared.getLocation()
    
    override func loadView() {
        self.view = addContentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        configureCollectionView()
    }
    
    func setNavigation() {
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonTapped))
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonTapped))
        
        self.navigationItem.leftBarButtonItem = cancelButton
        self.navigationItem.rightBarButtonItem = saveButton
    }
    
    private func configureCollectionView() {
        addContentView.collectionView.register(MapCollectionViewCell.self, forCellWithReuseIdentifier: MapCollectionViewCell.identifier)
        addContentView.collectionView.dataSource = self
        addContentView.collectionView.delegate = self
    }
    
    @objc func saveButtonTapped() {
        let titleText = addContentView.titleTextField.text ?? ""
//        let locationText = contentView.locationTextField.text ?? ""
        let memoText = addContentView.memoTextField.text ?? ""
        let dateString = addContentView.dateResultLabel.text ?? ""
        
        let newItem = Item(title: titleText, date: dateString, location: "", memo: memoText, members: [self.user?.name ?? ""], emails: [self.user?.email ?? ""])
        let newItemDictionary = newItem.asDictionary()
        
        let database = Database.database().reference()
        let newItemRef = database.child("items").childByAutoId()
        
        newItemRef.setValue(newItemDictionary)
        
        delegate?.didSaveItem(newItem)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func cancelButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension AddContentViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MapCollectionViewCell.identifier, for: indexPath) as? MapCollectionViewCell else { fatalError() }
        cell.mapView.delegate = self
        
        let center = CLLocationCoordinate2D(latitude: userLocation.latitude, longitude: userLocation.longitude)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 1000, longitudinalMeters: 1000)
        cell.mapView.setRegion(region, animated: true)
        

        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: Double = self.view.frame.width
        
        return CGSize(width: width, height: width)
    }
}
