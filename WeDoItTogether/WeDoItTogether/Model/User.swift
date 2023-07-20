//
//  User.swift
//  WeDoItTogether
//
//  Created by 최하늘 on 2023/07/20.
//

import Foundation

struct User: Codable  {
    let email: String
    let name: String
    let password: String
    var joined: TimeInterval = Date().timeIntervalSince1970
}
