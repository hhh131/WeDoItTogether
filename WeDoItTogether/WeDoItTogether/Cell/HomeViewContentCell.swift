//
//  HomeViewContentCell.swift
//  WeDoItTogether
//
//  Created by 오영석 on 2023/07/23.
//

import UIKit

class HomeViewContentCell: UICollectionViewCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        
        return label
    }()
    
    let locationLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        
        return label
    }()
    
    let memoLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        
        return label
    }()
    
    let membersLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        setLayoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        [titleLabel, locationLabel, dateLabel, memoLabel, membersLabel].forEach { item in
            contentView.addSubview(item)
            item.translatesAutoresizingMaskIntoConstraints = false
        }
        
        contentView.layer.cornerRadius = contentView.bounds.height / 8
        contentView.backgroundColor = .lightGray
        contentView.layer.shadowOffset = CGSize(width: 10, height: 10)
        contentView.layer.shadowOpacity = 0.1
        contentView.layer.shadowRadius = 4
    }
    
    private func setLayoutConstraints() {
        let padding: CGFloat = 15
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            
            locationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            locationLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
            
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            dateLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor),
            
            memoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            memoLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor),
            
            membersLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            membersLabel.topAnchor.constraint(equalTo: memoLabel.bottomAnchor, constant: padding)
        ])
    }
}
