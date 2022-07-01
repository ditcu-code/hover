//
//  ActivityList+CoreDataProperties.swift
//  Hover
//
//  Created by Muhammad Aleandro on 29/06/22.
//
//

import Foundation
import CoreData


extension ActivityList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ActivityList> {
        return NSFetchRequest<ActivityList>(entityName: "ActivityList")
    }

    @NSManaged public var activity: String?
    @NSManaged public var id: UUID?
    @NSManaged public var activityToLL: NSSet?
    @NSManaged public var activityToSpecial: NSSet?

    public var wrappedActivity: String {
        activity ?? "Unknown Activity"
    }
    public var llArray: [LoveLanguages]{
        let set = activityToLL as? Set<LoveLanguages> ?? []
        
        return set.sorted{
            $0.wrappedLLName < $1.wrappedLLName
        }
    }
    public var SpecialDayArray: [SpecialDay]{
        let set = activityToSpecial as? Set<SpecialDay> ?? []
        
        return set.sorted{
            $0.wrappedName < $1.wrappedName
        }
    }
}

// MARK: Generated accessors for activityToLL
extension ActivityList {
    // ActivityToLL
    @objc(addActivityToLLObject:)
    @NSManaged public func addToActivityToLL(_ value: LoveLanguages)

    @objc(removeActivityToLLObject:)
    @NSManaged public func removeFromActivityToLL(_ value: LoveLanguages)

    @objc(addActivityToLL:)
    @NSManaged public func addToActivityToLL(_ values: NSSet)

    @objc(removeActivityToLL:)
    @NSManaged public func removeFromActivityToLL(_ values: NSSet)
    
    // ActivityToSpecial
    @objc(activityToSpecialObject:)
    @NSManaged public func addToActivityToSpecial(_ value: SpecialDay)

    @objc(removeActivityToSpecialObject:)
    @NSManaged public func removeFromActivityToSpecial(_ value: SpecialDay)

    @objc(addActivityToSpecial:)
    @NSManaged public func addToActivityToSpecial(_ values: NSSet)

    @objc(removeActivityToSpecial:)
    @NSManaged public func removeFromActivityToSpecial(_ values: NSSet)

}

extension ActivityList : Identifiable {

}
