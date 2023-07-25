//
//  HomeTestModel.swift
//  WeDoItTogether
//
//  Created by 오영석 on 2023/07/21.
//

import Foundation

struct Item {
    var title: String
    var date: String
    var location: String
    var members: [String]
}

var dataSource: [Item] = [
    Item(title: "Item 1", date: "2023/07/15 오후 10시 30분", location: "서울 구로구", members: ["오영석", "방유빈"]),
    Item(title: "Item 1", date: "2023/07/15 오후 10시 30분", location: "서울 구로구", members: ["오영석", "방유빈"]),
    Item(title: "Item 1", date: "2023/07/15 오후 10시 30분", location: "서울 구로구", members: ["오영석", "방유빈"]),
]
