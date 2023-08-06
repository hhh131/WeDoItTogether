//
//  AddContentView.swift
//  WeDoItTogether
//
//  Created by 오영석 on 2023/07/21.
//

import UIKit
import MapKit


class AddContentView: UIView {
    
    var testModel = dataSource
    
    var titleText: String = ""
    var locationText: String = ""
    var memoText: String = ""
    var dateString: String = ""
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        
        return scrollView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "약속 이름"
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 30)
        
        return label
    }()
    
    lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "약속명을 입력하세요."
        textField.borderStyle = .bezel
        textField.font = .systemFont(ofSize: 20)
        textField.backgroundColor = .white
        textField.layer.borderWidth = 1.0
        
        return textField
    }()
    
    lazy var redTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .red
        label.font = .boldSystemFont(ofSize: 15)
        
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "약속 일정"
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 30)
        
        return label
    }()
    
    lazy var dateResultLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 20)
        
        return label
    }()
    
    lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        
        return datePicker
    }()
    
    lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.text = "위치 설정"
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 30)
        
        return label
    }()
    
    lazy var mapView: MKMapView = {
        let view = MKMapView()
        view.backgroundColor = .blue
        view.layer.cornerRadius = 20
        view.layer.shadowRadius = 3
        
        return view
    }()
    
    lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "주소검색"
        textField.borderStyle = .bezel
        textField.font = .systemFont(ofSize: 20)
        textField.backgroundColor = .white
        textField.layer.borderWidth = 1.0
        
        return textField
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    lazy var compassButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "scope"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(compassButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    lazy var loactionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 30)
        
        return label
    }()
    
    //    lazy var markerButton: UIButton = {
    //        let button = UIButton(type: .system)
    //        button.setImage(UIImage(systemName: "handpoint.down.fill"), for: .normal)
    //        button.tintColor = .blue
    //
    //        return button
    //    }()
    
    lazy var memoLabel: UILabel = {
        let label = UILabel()
        label.text = "메모"
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 30)
        
        return label
    }()
    
    lazy var memoTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "메모를 입력하세요."
        textField.borderStyle = .bezel
        textField.font = .systemFont(ofSize: 20)
        textField.backgroundColor = .white
        textField.contentVerticalAlignment = .top
        
        return textField
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
        
        self.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        searchTextField.addSubview(searchButton)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        
        [compassButton, loactionLabel, searchTextField]
            .forEach { item in
                item.translatesAutoresizingMaskIntoConstraints = false
                mapView.addSubview(item)
            }
        
        [titleLabel, titleTextField, redTitleLabel, dateLabel, datePicker, locationLabel, mapView, memoLabel, memoTextField, dateResultLabel]
            .forEach { item in
                item.translatesAutoresizingMaskIntoConstraints = false
                scrollView.addSubview(item)
            }
        
    }
    
    func setLayoutConstraints() {
        
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: padding + 5),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            
            titleTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding - 5),
            titleTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            titleTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            titleTextField.heightAnchor.constraint(equalToConstant: 50),
            
            redTitleLabel.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: padding - 5),
            redTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            redTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
        ])
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: padding + 5),
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 50),
            
            dateResultLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 5),
            dateResultLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            dateResultLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            dateResultLabel.heightAnchor.constraint(equalToConstant: 50),
            
            datePicker.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: padding - 5),
            datePicker.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            datePicker.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
        ])
        
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: padding + 5 ),
            locationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            locationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            locationLabel.heightAnchor.constraint(equalToConstant: 50),
            
            mapView.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: padding - 5),
            mapView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            mapView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            mapView.heightAnchor.constraint(equalToConstant: 400),
        ])
        
        NSLayoutConstraint.activate([
            compassButton.trailingAnchor.constraint(equalTo: mapView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            compassButton.bottomAnchor.constraint(equalTo: mapView.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 20),
            searchTextField.leadingAnchor.constraint(equalTo: mapView.leadingAnchor, constant: 20),
            searchTextField.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -10),
            searchTextField.heightAnchor.constraint(equalToConstant: 30),
            
            searchButton.topAnchor.constraint(equalTo: searchTextField.topAnchor),
            searchButton.trailingAnchor.constraint(equalTo: searchTextField.trailingAnchor),
            searchButton.widthAnchor.constraint(equalToConstant: 30),
            searchButton.heightAnchor.constraint(equalToConstant: 30),
        ])
        
        NSLayoutConstraint.activate([
            memoLabel.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: padding + 5),
            memoLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            memoLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            memoLabel.heightAnchor.constraint(equalToConstant: 50),
            
            memoTextField.topAnchor.constraint(equalTo: memoLabel.bottomAnchor, constant: padding - 5),
            memoTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            memoTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            memoTextField.heightAnchor.constraint(equalToConstant: 200),
        ])
        
        scrollView.contentSize = CGSize(width: self.bounds.width, height: 1000)
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        dateResultLabel.text = formatter.string(from: sender.date)
    }
    
    @objc func compassButtonTapped() {
        mapView.setUserTrackingMode(.follow, animated: true)
    }
    
    @objc func searchButtonTapped() {
        //        mapView.setUserTrackingMode(.follow, animated: true)
    }
    
    func setMapCenter(_ coordinate: CLLocationCoordinate2D) {
        mapView.setCenter(coordinate, animated: true)
    }
    
}
