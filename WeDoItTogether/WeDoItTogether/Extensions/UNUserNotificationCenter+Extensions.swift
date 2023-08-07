//
//  UNUserNotificationCenter+Extensions.swift
//  WeDoItTogether
//
//  Created by 방유빈 on 2023/08/06.
//

import Foundation
import UserNotifications

extension UNUserNotificationCenter {
    func addNotificationRequest(item:Item){
        //알림 내용 구성
        let content = UNMutableNotificationContent()
        content.title = "\(item.title) 약속 알림"
        content.body = "\(item.title)약속까지 한시간 남았습니다. 얼른 \(item.location)으로 이동하세요~"
        content.sound = .default
        content.badge = 1
    
        //trigger 만들기
        guard let alarmDate = item.alarmTime else { return }
        let component = Calendar.current.dateComponents([.year, .day, .hour, .minute], from: alarmDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: component, repeats: false)
        //request만들기
        let request = UNNotificationRequest(identifier: item.id.uuidString, content: content, trigger: trigger)
        
        self.add(request, withCompletionHandler: nil)
    }
}
