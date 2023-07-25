//
//  AddContentView.swift
//  WeDoItTogether
//
//  Created by 오영석 on 2023/07/21.
//

import UIKit

protocol NewPostViewControllerDelegate: AnyObject {
    func newPostViewController(_ viewController: NewPostViewController, didAddNewItem item: Item)
}

class NewPostViewController: UIViewController {
    
    weak var delegate: NewPostViewControllerDelegate?
    
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
        
        return textField
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
    
    lazy var locationTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "장소 입력"
        textField.borderStyle = .bezel
        textField.font = .systemFont(ofSize: 20)
        textField.backgroundColor = .white
        
        return textField
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        setLayoutConstraints()
        configureUI()
    }
    
    func configureUI() {
        view.backgroundColor = .systemBackground
        setNavigation()
    }
    
    func addViews(){
        [titleLabel, titleTextField, dateLabel, datePicker, locationLabel, locationTextField, memoLabel, memoTextField, dateResultLabel]
            .forEach { item in
                item.translatesAutoresizingMaskIntoConstraints = false
                view.addSubview(item)
            }
    }
    
    func setNavigation() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "작성 완료", style: .plain, target: self, action: #selector(saveButtonTapped))
    }
    
    func setLayoutConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            
            titleTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            titleTextField.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 25),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            dateLabel.heightAnchor.constraint(equalToConstant: 50),
            
            dateResultLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 5),
            dateResultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            dateResultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            dateResultLabel.heightAnchor.constraint(equalToConstant: 50),
            
            datePicker.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 5),
            datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            datePicker.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
        ])
        
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 25),
            locationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            locationLabel.heightAnchor.constraint(equalToConstant: 50),
            
            locationTextField.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 5),
            locationTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            locationTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            locationTextField.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        NSLayoutConstraint.activate([
            memoLabel.topAnchor.constraint(equalTo: locationTextField.bottomAnchor, constant: 25),
            memoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            memoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            memoLabel.heightAnchor.constraint(equalToConstant: 50),
            
            memoTextField.topAnchor.constraint(equalTo: memoLabel.bottomAnchor, constant: 5),
            memoTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            memoTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            memoTextField.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    
    @objc func saveButtonTapped() {
        testModel.append(Item(title: titleText, date: dateString, location: locationText, members: ["오영석", "방유빈", "홍길동"]))
        
        delegate?.newPostViewController(self, didAddNewItem: testModel.last!)
        
        navigationController?.popViewController(animated: true)
    }
    
    @objc func datePickerValueChanged(_ datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        
        dateString = dateFormatter.string(from: datePicker.date)
        
        dateResultLabel.text = dateString
    }
}

