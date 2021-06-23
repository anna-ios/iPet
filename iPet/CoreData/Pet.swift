//
//  Pet+CoreDataProperties.swift
//  iPet
//
//  Created by Zelinskaya Anna on 23.06.2021.
//
//

import Foundation
import CoreData


extension Pet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pet> {
        return NSFetchRequest<Pet>(entityName: "Pet")
    }

    @NSManaged public var adaptability: Double
    @NSManaged public var affectionLevel: Double
    @NSManaged public var breedDescription: String?
    @NSManaged public var breedName: String
    @NSManaged public var childFriendly: Double
    @NSManaged public var dogFriendly: Double
    @NSManaged public var energyLevel: Double
    @NSManaged public var grooming: Double
    @NSManaged public var healthIssues: Double
    @NSManaged public var id: UUID
    @NSManaged public var image: Data?
    @NSManaged public var intelligence: Double
    @NSManaged public var kind: String
    @NSManaged public var name: String
    @NSManaged public var origin: String?
    @NSManaged public var sheddingLevel: Double
    @NSManaged public var socialNeeds: Double
    @NSManaged public var strangerFriendly: Double
    @NSManaged public var temperament: String?
    @NSManaged public var timestamp: Date?
    @NSManaged public var weight: String?
    @NSManaged public var wikipediaUrl: String?
    @NSManaged public var notification: NSSet?

}

// MARK: Generated accessors for notification
extension Pet {

    @objc(addNotificationObject:)
    @NSManaged public func addToNotification(_ value: NotificationItem)

    @objc(removeNotificationObject:)
    @NSManaged public func removeFromNotification(_ value: NotificationItem)

    @objc(addNotification:)
    @NSManaged public func addToNotification(_ values: NSSet)

    @objc(removeNotification:)
    @NSManaged public func removeFromNotification(_ values: NSSet)

}

extension Pet : Identifiable {

}
