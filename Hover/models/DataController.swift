//
//  DataController.swift
//  Hover
//
//  Created by Muhammad Aleandro on 26/06/22.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    //    static let shared = DataController()
    
    //    let container: NSPersistentContainer = {
    //        // call the XCDataModel name
    //        let container = NSPersistentContainer(name: "datLoveModel")
    //
    //        // load persistent stores
    //        container.loadPersistentStores{ description, error in
    //            if let error = error{
    //                print("Core datanya gagal di load :( : \(error.localizedDescription)")
    //            }
    //        }
    //        return container
    //    }()
    
    let container = NSPersistentContainer(name: "datLoveModel")
    
    init(){
        container.loadPersistentStores{ description, error in
            if let error = error{
                print("Core datanya gagal di load :( : \(error.localizedDescription)")
            }
        }
    }
}
