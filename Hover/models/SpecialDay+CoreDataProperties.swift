//
//  SpecialDay+CoreDataProperties.swift
//  Hover
//
//  Created by Muhammad Aleandro on 29/06/22.
//
//

import Foundation
import CoreData


extension SpecialDay {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SpecialDay> {
        return NSFetchRequest<SpecialDay>(entityName: "SpecialDay")
    }

    @NSManaged public var alert: String?
    @NSManaged public var date: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var notificationID: String?
    @NSManaged public var repeatNotif: String?
    @NSManaged public var specialToActivity: NSSet?

}

// MARK: Generated accessors for specialToActivity
extension SpecialDay {

    @objc(addSpecialToActivityObject:)
    @NSManaged public func addToSpecialToActivity(_ value: ActivityList)

    @objc(removeSpecialToActivityObject:)
    @NSManaged public func removeFromSpecialToActivity(_ value: ActivityList)

    @objc(addSpecialToActivity:)
    @NSManaged public func addToSpecialToActivity(_ values: NSSet)

    @objc(removeSpecialToActivity:)
    @NSManaged public func removeFromSpecialToActivity(_ values: NSSet)

}

extension SpecialDay : Identifiable {

}
