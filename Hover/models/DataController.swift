//
//  DataController.swift
//  Hover
//
//  Created by Muhammad Aleandro on 26/06/22.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    static let shared = DataController()
    
    let container: NSPersistentContainer = {
        // call the XCDataModel name
        let container = NSPersistentCloudKitContainer(name: "datLoveModel")
        
        // load persistent stores
        container.loadPersistentStores{ description, error in
            if let error = error{
                print("Core datanya gagal di load :( : \(error.localizedDescription)")
            }
        }
        return container
    }()
    
    func loadCurrentUser() {
        let idUser = UserDefaults.standard.string(forKey: "idUser")
        let idPartner = UserDefaults.standard.string(forKey: "idPartner")
        
        let request: NSFetchRequest<User> = NSFetchRequest<User>(entityName: "User")
        request.predicate = NSPredicate(format: "id IN %@", [idUser, idPartner])
        
        do {
            let users = try container.viewContext.fetch(request)
            for i in users {
                if i.id?.uuidString == idUser {
                    GlobalObject.shared.user = i
                } else if i.id?.uuidString == idPartner {
                    GlobalObject.shared.user = i
                }
            }
        } catch {
            print("gagal query \(error.localizedDescription)")
        }
    }
    
//    let container = NSPersistentContainer(name: "datLoveModel")
    
//    init(){
//        container.loadPersistentStores{ description, error in
//            if let error = error{
//                print("Core datanya gagal di load :( : \(error.localizedDescription)")
//            }
//        }
//    }
}
