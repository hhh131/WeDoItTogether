//
//  MapCollectionViewCell.swift
//  WeDoItTogether
//
//  Created by 최하늘 on 2023/08/03.
//

import UIKit
import MapKit

class MapCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MapCollectionViewCell"
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "최하늘"
        
        return label
    }()
    
    lazy var mapView: MKMapView = {
        let view = MKMapView()
        view.backgroundColor = .blue
        view.layer.cornerRadius = 20
        view.layer.shadowRadius = 3
        
        return view
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
        
        [nameLabel, mapView].forEach { item in
            contentView.addSubview(item)
            item.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setLayoutConstraints() {
        
        let padding: CGFloat = 15
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
        ])
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: padding),
            mapView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
        ])
    }
}
