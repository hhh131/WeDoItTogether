//
//  AddContentMapView.swift
//  WeDoItTogether
//
//  Created by 오영석 on 2023/08/07.
//

import UIKit
import MapKit

class AddContentMapView: UIView {
    
    lazy var mapView: MKMapView = {
        let view = MKMapView()
        view.backgroundColor = .blue
        view.layer.cornerRadius = 20
        view.layer.shadowRadius = 3
        
        return view
    }()
    
    lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "주소를 입력하세요."
        textField.font = .systemFont(ofSize: 20)
        textField.backgroundColor = .white
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 10
        return textField
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    lazy var currentLocationLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 15)
        label.backgroundColor = .white
        label.layer.borderWidth = 1.0
        label.layer.cornerRadius = 10
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var compassButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "scope"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(compassButtonTapped), for: .touchUpInside)
        button.backgroundColor = .clear
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 10
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        addViews()
        setLayoutConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews(){
        searchTextField.addSubview(searchButton)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        
        [compassButton, searchTextField, currentLocationLabel]
            .forEach { item in
                item.translatesAutoresizingMaskIntoConstraints = false
                mapView.addSubview(item)
            }
        
        [mapView]
            .forEach { item in
                item.translatesAutoresizingMaskIntoConstraints = false
                self.addSubview(item)
            }
    }
    
    func setLayoutConstraints() {
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            
            mapView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: padding - 5),
            mapView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            mapView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            mapView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            
            compassButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -padding),
            compassButton.bottomAnchor.constraint(equalTo: mapView.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            
            currentLocationLabel.centerXAnchor.constraint(equalTo: mapView.centerXAnchor),
            currentLocationLabel.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -padding),
            currentLocationLabel.widthAnchor.constraint(equalTo: mapView.widthAnchor, multiplier: 0.6),
            currentLocationLabel.heightAnchor.constraint(equalToConstant: 30),
        ])
        
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: mapView.topAnchor, constant: padding ),
            searchTextField.leadingAnchor.constraint(equalTo: mapView.leadingAnchor, constant: padding),
            searchTextField.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -padding),
            searchTextField.heightAnchor.constraint(equalToConstant: 50),
            
            
            searchButton.topAnchor.constraint(equalTo: searchTextField.topAnchor),
            searchButton.trailingAnchor.constraint(equalTo: searchTextField.trailingAnchor),
            searchButton.widthAnchor.constraint(equalToConstant: 50),
            searchButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    @objc func compassButtonTapped() {
        mapView.setUserTrackingMode(.follow, animated: true)
    }
    
    @objc func searchButtonTapped() {
        //        mapView.setUserTrackingMode(.follow, animated: true)
    }
    
}
