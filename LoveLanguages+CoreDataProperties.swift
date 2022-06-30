//
//  LoveLanguages+CoreDataProperties.swift
//  Hover
//
//  Created by Muhammad Aleandro on 29/06/22.
//
//

import Foundation
import CoreData


extension LoveLanguages {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LoveLanguages> {
        return NSFetchRequest<LoveLanguages>(entityName: "LoveLanguages")
    }

    @NSManaged public var detail: String?
    @NSManaged public var id: UUID?
    @NSManaged public var llName: String?
    @NSManaged public var llToActivity: NSSet?
    
    public var wrappedLLName: String{
        llName ?? "Unknown Love Language"
    }
    public var wrappedDetail: String{
        detail ?? "Unknown Love Language"
    }
    public var activityArray: [ActivityList]{
        let set = llToActivity as? Set<ActivityList> ?? []
        
        return set.sorted{
            $0.wrappedActivity < $1.wrappedActivity
        }
    }

}

// MARK: Generated accessors for llToActivity
extension LoveLanguages {

    @objc(addLlToActivityObject:)
    @NSManaged public func addToLlToActivity(_ value: ActivityList)

    @objc(removeLlToActivityObject:)
    @NSManaged public func removeFromLlToActivity(_ value: ActivityList)

    @objc(addLlToActivity:)
    @NSManaged public func addToLlToActivity(_ values: NSSet)

    @objc(removeLlToActivity:)
    @NSManaged public func removeFromLlToActivity(_ values: NSSet)

}

extension LoveLanguages : Identifiable {

}
