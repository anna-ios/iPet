//
//  NotificationsManager.swift
//  iPet
//
//  Created by Zelinskaya Anna on 15.05.2021.
//

import SwiftUI
import UserNotifications

func addNotificationRequest(notification: NotificationItem) {
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    let addRequest = {
        let content = UNMutableNotificationContent()
        content.title = notification.pet.name
        content.subtitle = notification.title
        content.sound = .default
        content.body = notification.text ?? ""
        
        var components: Set<Calendar.Component> = [.hour,.minute,.second]
        
        let repeatType = getRepeat(notification.repeatType)
        switch repeatType {
        case .daily:
            components = [.hour,.minute]
            break
        case .weekly:
            components = [.weekday,.hour,.minute]
        case .monthly:
            components = [.day,.hour,.minute]
            break
        case .yearly:
            components = [.month,.day,.hour,.minute]
            break
        case .never:
            break
        }
        
        let notificationDate = Calendar.current.dateComponents(components, from: notification.date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching:notificationDate,
                                                    repeats:repeatType == .never)
        let request = UNNotificationRequest(identifier: notification.id, content: content, trigger: trigger)
        notificationCenter.add(request, withCompletionHandler: { error in
            if error != nil, let error = error {
                print(error.localizedDescription)
            }
        })
    }
    notificationCenter.getNotificationSettings { settings in
        if settings.authorizationStatus == .authorized {
            addRequest()
        }
        else {
            notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                if success {
                    addRequest()
                } else {
                    print("Notification registration error")
                }
            }
        }
    }
}

func removeNotificationRequest(id:String) {
    UNUserNotificationCenter.current().getPendingNotificationRequests { (notificationRequests) in
        var ids: [String] = []
        for notification:UNNotificationRequest in notificationRequests {
            if notification.identifier == id {
                ids.append(notification.identifier)
            }
        }
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ids)
    }
}
