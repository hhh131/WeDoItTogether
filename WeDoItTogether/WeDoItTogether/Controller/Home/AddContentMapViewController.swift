
//  AddContentMapViewController.swift
//  WeDoItTogether
//
//  Created by 오영석 on 2023/08/07.
//

import UIKit
import MapKit
import CoreLocation

class AddContentMapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    let addContentMapView = AddContentMapView()
    let locationManager = CLLocationManager()
    var centerAnnotation: MKPointAnnotation!
    var isMapMoving = false
    var currentCenterPoint: CLLocationCoordinate2D?
    var currentCentAddress: String = ""
    let userLocation = UserDefaultsData.shared.getLocation()
    
    override func loadView() {
        self.view = addContentMapView
        setLocationMapView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addContentMapView.mapView.delegate = self
    }
    
    func setLocationMapView() {
        addContentMapView.mapView.showsUserLocation = true
        
        let center = CLLocationCoordinate2D(latitude: userLocation.latitude, longitude: userLocation.longitude)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 1000, longitudinalMeters: 1000)
        addContentMapView.mapView.setRegion(region, animated: true)
        
        centerAnnotation = MKPointAnnotation()
        centerAnnotation.coordinate = center
        addContentMapView.mapView.addAnnotation(centerAnnotation)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if annotation === centerAnnotation {
                let annotationView = CustomMarkerView(annotation: annotation, reuseIdentifier: "CustomMarkerView")
                return annotationView
            }
            return nil
        }
    
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        centerAnnotation.coordinate = mapView.centerCoordinate
        currentCenterPoint = mapView.centerCoordinate
    }
    
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        
        if !isMapMoving {
            UIView.animate(withDuration: 0.3) {
                self.centerAnnotation.coordinate.latitude += 0.0005
            }
            isMapMoving = true
        }
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        centerAnnotation.coordinate = mapView.centerCoordinate
        
        if isMapMoving {
            UIView.animate(withDuration: 0.3) {
                self.centerAnnotation.coordinate.latitude -= 0.0005
            }
            isMapMoving = false
        }
        
        if let currentCenterPoint = currentCenterPoint {
            convertLocationToAddress(currentCenterPoint)
        }
    }
    
    func convertLocationToAddress(_ coordinate: CLLocationCoordinate2D) {
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let locale = Locale(identifier: "Ko-kr")
        
        geocoder.reverseGeocodeLocation(location, preferredLocale: locale) { placemarks, error in
            if let error = error {
                print("Error reverse geocoding: \(error.localizedDescription)")
                
                return
            }
            
            guard let placemark = placemarks?.first else {
                print("No address found.")
                
                return
            }
            // 자세한 도로표시정보 및 지역별 예외처리 나중에 더 수정할 예정
            var currentCentAddress = [placemark.locality, placemark.name]
                .compactMap { $0 }
                .joined(separator: " ")
            
            if placemark.administrativeArea != "서울특별시" {
                currentCentAddress = "\(placemark.administrativeArea ?? "") " + currentCentAddress
            }
            
            
            print("Center Coordinate: \(coordinate.latitude), \(coordinate.longitude)")
            print("Address: \(currentCentAddress)")
            self.addContentMapView.currentLocationLabel.text = currentCentAddress
        }
    }
}
