//
//  DataController.swift
//  Hover
//
//  Created by Muhammad Aleandro on 26/06/22.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "datLove")
    
    init(){
        container.loadPersistentStores{ description, error in
            if let error = error{
                print("Core datanya gagal di load :( : \(error.localizedDescription)")
            }
        }
    }
}
