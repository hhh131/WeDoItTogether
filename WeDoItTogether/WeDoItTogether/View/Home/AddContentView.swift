//
//  AddContentView.swift
//  WeDoItTogether
//
//  Created by 오영석 on 2023/07/21.
//

import UIKit


class AddContentView: UIView {
    
    var testModel = dataSource
    
    var titleText: String = ""
    var locationText: String = ""
    var memoText: String = ""
    var dateString: String = ""
    
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
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        collectionView.isScrollEnabled = false
        
        return collectionView
    }()
    
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
        [titleLabel, titleTextField, redTitleLabel, dateLabel, datePicker, locationLabel, collectionView, memoLabel, memoTextField, dateResultLabel]
            .forEach { item in
                item.translatesAutoresizingMaskIntoConstraints = false
                self.addSubview(item)
            }
        
    }
    
    func setLayoutConstraints() {
        
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: padding + 5),
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
            
            collectionView.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: padding - 5),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            collectionView.heightAnchor.constraint(equalToConstant: 400),
        ])
        
        NSLayoutConstraint.activate([
            memoLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: padding + 5),
            memoLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            memoLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            memoLabel.heightAnchor.constraint(equalToConstant: 50),
            
            memoTextField.topAnchor.constraint(equalTo: memoLabel.bottomAnchor, constant: padding - 5),
            memoTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            memoTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            memoTextField.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        dateResultLabel.text = formatter.string(from: sender.date)
    }
    
}
