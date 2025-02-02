//
//  CollectionViewCell.swift
//  WeDoItTogether
//
//  Created by 신희권 on 2023/07/26.
//
import UIKit

class ChattingCell: UICollectionViewCell{
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
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle")
        imageView.contentMode = .scaleAspectFit
        imageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        imageView.setContentHuggingPriority(.defaultLow, for: .vertical)
        return imageView
    }()
    

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
        [imageView, contentLabel, dateLabel].forEach { item in
            item.translatesAutoresizingMaskIntoConstraints = false
            addSubview(item)
        }
    }
    
    func setLayoutConstraints(){
        let safeArea = safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 40),
            imageView.heightAnchor.constraint(equalToConstant: 40),
            imageView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant:  20),
            
            contentLabel.topAnchor.constraint(equalTo: imageView.topAnchor),
            contentLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
           
            
            dateLabel.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10)
        ])
        
    }
}

