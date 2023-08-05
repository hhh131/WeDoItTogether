import UIKit
import MapKit
import Firebase
import CoreLocation

protocol AddContentDelegate: AnyObject {
    func didSaveItem(_ item: Item)
}

class AddContentViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    weak var delegate: AddContentDelegate?
    
    var user = UserDefaultsData.shared.getUser()
    let addContentView = AddContentView()
    var testModel = dataSource
    let userLocation = UserDefaultsData.shared.getLocation()
    let locationManager = CLLocationManager()
    var centerAnnotation: MKPointAnnotation!
    var isMapMoving = false
    
    override func loadView() {
        self.view = addContentView
        setLocationMapView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        addContentView.mapView.delegate = self
    }
    
    func setLocationMapView() {
        
        addContentView.mapView.showsUserLocation = true
        addContentView.mapView.setUserTrackingMode(.follow, animated: true)
        
        let center = CLLocationCoordinate2D(latitude: userLocation.latitude, longitude: userLocation.longitude)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 1000, longitudinalMeters: 1000)
        addContentView.mapView.setRegion(region, animated: true)
        
        centerAnnotation = MKPointAnnotation()
        centerAnnotation.coordinate = center
        addContentView.mapView.addAnnotation(centerAnnotation)
        
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation === centerAnnotation {
            let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "CenterMarker")
            
            return annotationView
        }
        
        return nil
    }
    
    // 맵 이동 중
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        centerAnnotation.coordinate = mapView.centerCoordinate
    }

    // 맵 이동 시작
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        
        if !isMapMoving {
            UIView.animate(withDuration: 0.3) {
                self.centerAnnotation.coordinate.latitude += 0.0005
            }
            isMapMoving = true
        }
    }
    
    // 맵 이동 끝
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        if isMapMoving {
            UIView.animate(withDuration: 0.3) {
                self.centerAnnotation.coordinate.latitude -= 0.0005
            }
            isMapMoving = false
        }
    }
    
    func setNavigation() {
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonTapped))
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonTapped))
        
        self.navigationItem.leftBarButtonItem = cancelButton
        self.navigationItem.rightBarButtonItem = saveButton
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
