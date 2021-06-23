//
//  NotificationItem+CoreDataProperties.swift
//  iPet
//
//  Created by Zelinskaya Anna on 23.06.2021.
//
//

import Foundation
import CoreData


extension NotificationItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NotificationItem> {
        return NSFetchRequest<NotificationItem>(entityName: "NotificationItem")
    }

    @NSManaged public var activity: ActivityType
    @NSManaged public var title: String
    @NSManaged public var date: Date
    @NSManaged public var id: String
    @NSManaged public var repeatType: String
    @NSManaged public var text: String?
    @NSManaged public var timestamp: Date?
    @NSManaged public var pet: Pet

}

extension NotificationItem : Identifiable {

}
