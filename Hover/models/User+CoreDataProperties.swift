//
//  User+CoreDataProperties.swift
//  Hover
//
//  Created by Eddo Careera Iriyanto Putra on 05/07/22.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var aos: Int32
    @NSManaged public var id: UUID?
    @NSManaged public var imageData: Data?
    @NSManaged public var isUser: Bool
    @NSManaged public var name: String?
    @NSManaged public var pt: Int32
    @NSManaged public var qt: Int32
    @NSManaged public var rg: Int32
    @NSManaged public var woa: Int32

    public var wrappedName: String {
        name ?? "Unknown Name"
    }
}

extension User : Identifiable {

}
