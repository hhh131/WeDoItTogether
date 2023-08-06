//
//  HomeTestModel.swift
//  WeDoItTogether
//
//  Created by 오영석 on 2023/07/21.
//

import Foundation

struct Item: Encodable, Identifiable {
    var id:UUID = UUID()
    var title: String
    var date: String
    var location: String
    var memo: String
    var members: [String]
    var emails: [String]
    var creator: String
    
    var alarmTime:Date? { // 1시간 전 알람 울릴 시간
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        guard let settingDate = formatter.date(from: date) else { return Date() }
        return Calendar.current.date(byAdding: .hour, value: -1, to: settingDate)
    }
}
