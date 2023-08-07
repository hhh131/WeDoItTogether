//
//  ChatModel.swift
//  WeDoItTogether
//
//  Created by 신희권 on 2023/08/06.
//

import Foundation

struct ChatModel {
    
    var users: Dictionary<String,Bool> = [:] //채팅방 사람들
    var comments: Dictionary<String,Comment> = [:] //채팅방 대화내역
    class Comment {
        public var uid: String?
        public var message: String?
    }
}
