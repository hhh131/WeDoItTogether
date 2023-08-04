//
//  HomeTestModel.swift
//  WeDoItTogether
//
//  Created by 오영석 on 2023/07/21.
//

import Foundation

struct Item: Encodable {
    var title: String
    var date: String
    var location: String
    var memo: String
    var members: [String]
    var emails: [String]
}

var dataSource: [Item] = [
]
