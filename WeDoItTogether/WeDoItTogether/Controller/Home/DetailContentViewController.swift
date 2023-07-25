//
//  DetailContentViewController.swift
//  WeDoItTogether
//
//  Created by 오영석 on 2023/07/21.
//

import UIKit

class DetailContentViewController: UIViewController {

    var item: Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let detailContentView = DetailContentView()
        
        detailContentView.titleLabel.text = item?.title
        detailContentView.locationLabel.text = item?.location
        detailContentView.dateLabel.text = item?.date
        let membersString = item?.members.joined(separator: ", ") ?? ""
        detailContentView.membersLabel.text = membersString
        
        view.addSubview(detailContentView)
        detailContentView.translatesAutoresizingMaskIntoConstraints = false
        
    }
}
