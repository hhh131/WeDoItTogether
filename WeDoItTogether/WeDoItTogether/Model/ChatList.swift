//
//  ChatList.swift
//  WeDoItTogether
//
//  Created by 신희권 on 2023/08/02.
//

import Foundation

struct ChatList: Codable  {
    let name: String
    let content: String
    var date: Date = Date.now
}

extension ChatList {
    static let mockData:[ChatList] = [
        ChatList(name: "희권", content: "123"),
        ChatList(name: "민근", content:  "1223"),
        ChatList(name: "히늘", content:  "1233"),
        ChatList(name: "유빈", content:  "1243"),
        ChatList(name: "영석", content:  "12376"),
        ChatList(name: "제현", content:  "128"),
        ChatList(name: "윤호", content:  "1238"),
        ChatList(name: "경환", content:  "1239"),
        ChatList(name: "성혜", content:  "1239"),
    ]
}
