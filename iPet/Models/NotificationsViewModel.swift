//
//  NotificationsViewModel.swift
//  iPet
//
//  Created by Zelinskaya Anna on 15.05.2021.
//

import Foundation
import CoreData

enum RepeatType {
    case never, daily, weekly, monthly, yearly
}

func getRepeat(_ repeatType: String) -> RepeatType {
    if repeatType == "Daily" {
        return .daily
    }
    if repeatType == "Weekly" {
        return .weekly
    }
    if repeatType == "Monthly" {
        return .monthly
    }
    if repeatType == "Yearly" {
        return .yearly
    }
    return .never
}

func getRepeatString(_ type: RepeatType) -> String {
    switch type {
    case .daily:
        return "Daily"
    case .weekly:
        return "Weekly"
    case .monthly:
        return "Monthly"
    case .yearly:
        return "Yearly"
    case .never:
        return "Never"
    }
}

@objc public enum ActivityType: Int32 {
    case other = 0
    case feed = 1
    case groom = 2
    case trim = 3
    case vaccinate = 4
    case walk = 5
}

func getActivityTypeString(_ kind: ActivityType) -> String {
    switch kind {
    case .walk:
        return "Walk"
    case .feed:
        return "Feed"
    case .groom:
        return "Groom"
    case .trim:
        return "Trim"
    case .vaccinate:
        return "Vaccinate"
    case .other:
        return "Other"
    }
}

final class NotificationsViewModel: ObservableObject {
    
    func addNotification(date: Date, activity: ActivityType, title: String, pet: Pet, text: String, repeatPeriod: String, viewContext: NSManagedObjectContext) {
        
        let notification = NotificationItem(context: viewContext)
        notification.id = UUID().uuidString
        notification.timestamp = Date()
        
        updateNotification(notification: notification, date: date, activity: activity, title: title, pet: pet, text: text, repeatPeriod: repeatPeriod, viewContext: viewContext)
    }
    
    func updateNotification(notification: NotificationItem, date: Date, activity: ActivityType, title: String, pet: Pet, text: String, repeatPeriod: String, viewContext: NSManagedObjectContext) {
        
        notification.pet = pet
        notification.title = title
        notification.text = text
        notification.date = date
        notification.repeatType = repeatPeriod
        notification.activity = activity
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
                
        removeNotificationRequest(id: notification.id)
        addNotificationRequest(notification: notification)
    }
    
    func removeNotification(notification: NotificationItem, viewContext: NSManagedObjectContext) {
        viewContext.delete(notification)
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
