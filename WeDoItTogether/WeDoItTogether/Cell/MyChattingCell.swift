//
//  CollectionViewCell.swift
//  WeDoItTogether
//
//  Created by 신희권 on 2023/07/26.
//
import UIKit

class MyChattingCell: UICollectionViewCell{
    //부모 메서드 초기화 시켜줘야 한다.
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Customize cell appearance
        self.backgroundColor = UIColor.white
        addViews()
        setLayoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.backgroundColor = .gray
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = UIColor.gray
        label.font = UIFont.boldSystemFont(ofSize: 9)
        return label
    }()
    
    func addViews() {
        [contentLabel, dateLabel].forEach { item in
            item.translatesAutoresizingMaskIntoConstraints = false
            addSubview(item)
        }
    }
    
    func setLayoutConstraints(){
        let safeArea = safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            
            contentLabel.topAnchor.constraint(equalTo: safeArea.topAnchor,constant: 10),
            contentLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,constant: -10),
            contentLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor,constant: 10),
            
            dateLabel.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10)
        ])
        
    }
}

