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
    
    @Published var specialDayNoAct : SpecialDay = CoreDataPreviewHelper.dummySpecialDayEmptyActivity
    @Published var specialDayWithAct : SpecialDay = CoreDataPreviewHelper.dummySpecialDayWithActivity
    
//    @Published var onboardingStep: Int = 0
    @Published var showCongrats: Bool = false
    @Published var showResult: Bool = false

}
