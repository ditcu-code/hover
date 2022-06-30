//
//  GlobalObject.swift
//  Hover
//
//  Created by Eddo Careera Iriyanto Putra on 30/06/22.
//

import Foundation

class GlobalObject: ObservableObject {
    static let shared: GlobalObject = GlobalObject()
    
    @Published var user: User = User()
    @Published var partner: User = User()
}
