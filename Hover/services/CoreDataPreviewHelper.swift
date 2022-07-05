//
//  CoreDataPreviewHelper.swift
//  Hover
//
//  Created by Eddo Careera Iriyanto Putra on 02/07/22.
//

import Foundation

class CoreDataPreviewHelper {
    static var preview: DataController = {
        var llActivityRec = ListActivityRecommendation()
        var lls : [LoveLanguages] = []
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
            
            lls.append(loveLanguage)
        }
        
        for a in llActivityRec.activityListLL {
            saveActivityWithLL(activity: a)
        }
        
        func saveActivityWithLL(activity: ListActivityRecommendationStructure) {
            let a = ActivityList(context: controller.container.viewContext)
            var ll : [LoveLanguages] = []
            for lovelanguage in lls {
                if lovelanguage.llName == activity.firstLL{
                    ll.append(lovelanguage)
                }
                if lovelanguage.llName == activity.secondLL{
                    ll.append(lovelanguage)
                }
            }
            a.id = UUID()
            a.activity = activity.activity
            let llActivity = Set(ll)
            for i in llActivity{
                a.addToActivityToLL(i)
            }
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
    
    static var dummySpecialDayEmptyActivity: SpecialDay = {
        let controller = DataController.shared
        let specialDay = SpecialDay(context: controller.container.viewContext)
        specialDay.id = UUID()
        specialDay.name = "Special Day Name"
        specialDay.date = Date.now
        
        return specialDay
    }()
    
    static var dummySpecialDayWithActivity: SpecialDay = {
        let controller = DataController.shared
        let specialDay = SpecialDay(context: controller.container.viewContext)
        let dummyActivity = ActivityList(context: controller.container.viewContext)
        dummyActivity.activity = "Isi Activity"
        let dummyLL = LoveLanguages(context: controller.container.viewContext)
        dummyLL.llName = LoveLanguageEnum.qualityTime.rawValue
        dummyActivity.activityToLL = [dummyLL]
        specialDay.id = UUID()
        specialDay.name = "Special Day Name"
        specialDay.date = Date.now
        specialDay.specialToActivity = [dummyActivity]
        
        return specialDay
    }()
}
