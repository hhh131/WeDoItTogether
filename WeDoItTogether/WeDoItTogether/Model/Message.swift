//
//  Message.swift
//  WeDoItTogether
//
//  Created by 신희권 on 2023/08/06.
//

import Foundation

struct Message : Codable {
    let text: String
    let sender: String
    let timestamp: Int
    
    init(text: String, sender: String, timestamp: Int) {
        self.text = text
        self.sender = sender
        self.timestamp = timestamp
    }
    
}
