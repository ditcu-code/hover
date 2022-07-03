//
//  UserExtension.swift
//  Hover
//
//  Created by Eddo Careera Iriyanto Putra on 03/07/22.
//

import Foundation
import CoreData

extension User {
    func getUserData(id: String) -> User {
        let request: NSFetchRequest<User> = NSFetchRequest<User>(entityName: "User")
        request.predicate = NSPredicate(format: "id = %@", id)
        
        
        return User()
    }
}
