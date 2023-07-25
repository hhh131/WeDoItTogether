////
////  HomeView.swift
////  WeDoItTogether
////
////  Created by 최하늘 on 2023/07/14.
////
//
//import UIKit
//
//class addView: UIView {
//    
//    weak var delegate: HomeViewDelegate?
//    
//    var testModel = dataSource
//    
//    weak var delegate: NewPostViewControllerDelegate?
//    
//    var testModel = dataSource
//    
//    var titleText: String = ""
//    var locationText: String = ""
//    var memoText: String = ""
//    var dateString: String = ""
//    
//    lazy var titleLabel: UILabel = {
//        let label = UILabel()
//        label.text = "약속 이름"
//        label.textAlignment = .left
//        label.font = .boldSystemFont(ofSize: 30)
//        
//        return label
//    }()
//    
//    lazy var titleTextField: UITextField = {
//        let textField = UITextField()
//        textField.placeholder = "약속명을 입력하세요."
//        textField.borderStyle = .bezel
//        textField.font = .systemFont(ofSize: 20)
//        textField.backgroundColor = .white
//        
//        return textField
//    }()
//    
//    lazy var dateLabel: UILabel = {
//        let label = UILabel()
//        label.text = "약속 일정"
//        label.textAlignment = .left
//        label.font = .boldSystemFont(ofSize: 30)
//        
//        return label
//    }()
//    
//    lazy var dateResultLabel: UILabel = {
//        let label = UILabel()
//        label.textAlignment = .left
//        label.font = .boldSystemFont(ofSize: 20)
//        
//        return label
//    }()
//    
//    lazy var datePicker: UIDatePicker = {
//        let datePicker = UIDatePicker()
//        datePicker.datePickerMode = .dateAndTime
//        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
//        
//        return datePicker
//    }()
//    
//    lazy var locationLabel: UILabel = {
//        let label = UILabel()
//        label.text = "위치 설정"
//        label.textAlignment = .left
//        label.font = .boldSystemFont(ofSize: 30)
//        
//        return label
//    }()
//    
//    lazy var locationTextField: UITextField = {
//        let textField = UITextField()
//        textField.placeholder = "장소 입력"
//        textField.borderStyle = .bezel
//        textField.font = .systemFont(ofSize: 20)
//        textField.backgroundColor = .white
//        
//        return textField
//    }()
//    
//    lazy var memoLabel: UILabel = {
//        let label = UILabel()
//        label.text = "메모"
//        label.textAlignment = .left
//        label.font = .boldSystemFont(ofSize: 30)
//        
//        return label
//    }()
//    
//    lazy var memoTextField: UITextField = {
//        let textField = UITextField()
//        textField.placeholder = "메모를 입력하세요."
//        textField.borderStyle = .bezel
//        textField.font = .systemFont(ofSize: 20)
//        textField.backgroundColor = .white
//        textField.contentVerticalAlignment = .top
//        
//        return textField
//    }()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.backgroundColor = .white
//        addViews()
//        setLayoutConstraints()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func addViews(){
//        [titleLabel, titleTextField, dateLabel, datePicker, locationLabel, locationTextField, memoLabel, memoTextField, dateResultLabel].forEach { item in
//            addSubview(item)
//            item.translatesAutoresizingMaskIntoConstraints = false
//        }
//    }
//    
//    func setLayoutConstraints() {
//        NSLayoutConstraint.activate([
//            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 25),
//            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
//            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
//            titleLabel.heightAnchor.constraint(equalToConstant: 50),
//            
//            titleTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
//            titleTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
//            titleTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
//            titleTextField.heightAnchor.constraint(equalToConstant: 50),
//        ])
//        
//        NSLayoutConstraint.activate([
//            dateLabel.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 25),
//            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
//            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
//            dateLabel.heightAnchor.constraint(equalToConstant: 50),
//            
//            dateResultLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 5),
//            dateResultLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
//            dateResultLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
//            dateResultLabel.heightAnchor.constraint(equalToConstant: 50),
//            
//            datePicker.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 5),
//            datePicker.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
//            datePicker.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
//        ])
//        
//        NSLayoutConstraint.activate([
//            locationLabel.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 25),
//            locationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
//            locationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
//            locationLabel.heightAnchor.constraint(equalToConstant: 50),
//            
//            locationTextField.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 5),
//            locationTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
//            locationTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
//            locationTextField.heightAnchor.constraint(equalToConstant: 50),
//        ])
//        
//        NSLayoutConstraint.activate([
//            memoLabel.topAnchor.constraint(equalTo: locationTextField.bottomAnchor, constant: 25),
//            memoLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
//            memoLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
//            memoLabel.heightAnchor.constraint(equalToConstant: 50),
//            
//            memoTextField.topAnchor.constraint(equalTo: memoLabel.bottomAnchor, constant: 5),
//            memoTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
//            memoTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
//            memoTextField.heightAnchor.constraint(equalToConstant: 200),
//        ])
//    }
//}
//
//
