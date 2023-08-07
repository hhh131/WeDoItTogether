//
//  UserNotification.swift
//  WeDoItTogether
//
//  Created by 최하늘 on 2023/08/06.
//

import Foundation

struct UserNotification: Codable, Identifiable {
    var id: UUID = UUID()
    let title: String
    let content: String
    let date: String
    
    var timeDifference: String {
        let currentDate = Date()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        let dateChangeFormat = formatter.date(from: date)!
        
        let seconds: Int = Int(currentDate.timeIntervalSince(dateChangeFormat))
        if seconds < 60 {
            return "\(seconds)초 전"
        }

        let minutes = seconds / 60
        if minutes < 60 {
            return "\(minutes)분 전"
        }

        let hour = minutes / 60
        if hour < 24 {
            return "\(hour)시간 전"
        }
        
        let day = hour / 24
        if day < 30 {
            return "\(day)일 전"
        }
        
        formatter.dateFormat = "yyyy.MM.dd"
        let date = formatter.string(from: dateChangeFormat)
        
        return date
    }
}
