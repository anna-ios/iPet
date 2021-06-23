//
//  Pet+CoreDataProperties.swift
//  iPet
//
//  Created by Zelinskaya Anna on 18.05.2021.
//
//

import Foundation
import CoreData


extension Pet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pet> {
        return NSFetchRequest<Pet>(entityName: "Pet")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: String?

}

extension Pet : Identifiable {

}
