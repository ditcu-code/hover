//
//  CoreDataPreviewHelper.swift
//  Hover
//
//  Created by Eddo Careera Iriyanto Putra on 02/07/22.
//

import Foundation

class CoreDataPreviewHelper {
    static var preview: DataController = {
        let controller = DataController.shared
        
        let user = User(context: controller.container.viewContext)
        user.id = UUID()
        user.woa = 22
        user.aos = 23
        user.pt = 21
        user.qt = 20
        user.rg = 14
        
        let llName = ["Physical Touch", "Word of Affirmation", "Quality Time", "Receiving Gifts", "Acts of Service"]
        let detail = ["To this person, nothing speaks more deeply than appropriate physical touch.","This language uses words to affirm other people.", "This language is all about giving the other person your undivided attention.", "For some people, receiving a heartfelt gift is what makes them feel most loved.", "For these people, actions speak louder than words."]
        
        for i in 0...llName.count - 1 {
            let loveLanguage = LoveLanguages(context: controller.container.viewContext)
            loveLanguage.id = UUID()
            loveLanguage.llName = llName[i]
            loveLanguage.detail = detail[i]
        }
        
        return controller
    }()
    
    static var dummyUser: User = {
        let controller = DataController.shared
        let user = User(context: controller.container.viewContext)
        user.id = UUID()
        user.woa = 23
        user.aos = 22
        user.pt = 21
        user.qt = 20
        user.rg = 14
        
        return user
    }()
    
    static var initialUser: User = {
        let controller = DataController.shared
        let user = User(context: controller.container.viewContext)
        user.id = UUID()
        user.woa = 0
        user.aos = 0
        user.pt = 0
        user.qt = 0
        user.rg = 0
        
        return user
    }()
}
