//
//  GlobalObject.swift
//  Hover
//
//  Created by Eddo Careera Iriyanto Putra on 30/06/22.
//

import Foundation

class GlobalObject: ObservableObject {
    static let shared: GlobalObject = GlobalObject()
    
    @Published var user: User = CoreDataPreviewHelper.initialUser
    @Published var partner: User = CoreDataPreviewHelper.initialUser
}
