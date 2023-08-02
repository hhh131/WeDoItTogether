//
//  DetailContentViewController.swift
//  WeDoItTogether
//
//  Created by 오영석 on 2023/07/21.
//

import UIKit

class DetailContentViewController: UIViewController {

    let detailContentView = DetailContentView()
    var item: Item?
    
    override func loadView() {
        super.loadView()
        self.view = detailContentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUILable()
    }
    
    func updateUILable() {
        detailContentView.titleLabel.text = item?.title
        detailContentView.locationLabel.text = item?.location
        detailContentView.dateLabel.text = item?.date
        let membersString = item?.members.joined(separator: ", ") ?? ""
        detailContentView.membersLabel.text = membersString
    }
}
