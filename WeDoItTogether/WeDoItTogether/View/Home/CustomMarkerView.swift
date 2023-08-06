//
//  CustomMarkerView.swift
//  WeDoItTogether
//
//  Created by 오영석 on 2023/08/07.
//

import MapKit

class CustomMarkerView: MKAnnotationView {
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    private func setupView() {
        let systemImageName = "hand.point.down.fill"
        let systemImageView = UIImageView(image: UIImage(systemName: systemImageName))
        systemImageView.tintColor = .blue
        systemImageView.contentMode = .scaleAspectFit
        systemImageView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        
        self.addSubview(systemImageView)
        
        self.frame = systemImageView.frame
        self.centerOffset = CGPoint(x: 0, y: -systemImageView.bounds.size.height / 2)
    }
}
