//
//  SpecialDayViewModel.swift
//  Hover
//
//  Created by Eddo Careera Iriyanto Putra on 25/07/22.
//

import Foundation
import Combine
import CoreData

class SpecialDayViewModel : ObservableObject {
    @Published var selectedSpecialDay : SpecialDay!
    @Published var name : String = ""
    @Published var date : Date = Date()
    @Published var notificationId : String = ""
    @Published var repeatNotif : Repeat = .monthly
    @Published var alert : Alert = .oneDay
    @Published var actSelections : [ActivityList] = []
    
    let persistenceController = DataController.shared
    
    func setSelectedSpecialDay(specialDay: SpecialDay) {
        selectedSpecialDay = specialDay
        name = specialDay.wrappedName
        date = specialDay.wrappedDate
        notificationId = specialDay.wrappedNotifID
        repeatNotif = Repeat.init(rawValue: specialDay.wrappedRepeatNotif) ?? .monthly
        alert = Alert.init(rawValue: specialDay.wrappedAlert) ?? .oneDay
        actSelections = specialDay.activityInSDArray
    }
    
    func reset() {
        name = ""
        date = Date()
        notificationId = ""
        repeatNotif = .monthly
        alert = .oneDay
        actSelections = []
    }
    
    func createSpecialDay() {
        if selectedSpecialDay == nil {
            let specialDay = SpecialDay(context: persistenceController.container.viewContext)
            specialDay.id = UUID()
            specialDay.name = name
            specialDay.date = date
            specialDay.notificationID = notificationId
            specialDay.repeatNotif = repeatNotif.rawValue
            specialDay.alert = alert.rawValue
            for act in actSelections {
                specialDay.addToSpecialToActivity(act)
            }
        } else {
            selectedSpecialDay.name = name
            selectedSpecialDay.date = date
            selectedSpecialDay.notificationID = notificationId
            selectedSpecialDay.repeatNotif = repeatNotif.rawValue
            selectedSpecialDay.alert = alert.rawValue
            for act in selectedSpecialDay.activityInSDArray {
                selectedSpecialDay.removeFromSpecialToActivity(act)
            }
            for act in actSelections {
                selectedSpecialDay.addToSpecialToActivity(act)
            }
        }
        
        save()
        if selectedSpecialDay == nil {reset()}
    }
    
    func deleteSpecialDay() {
        let context = persistenceController.container.viewContext
        context.delete(selectedSpecialDay)
        save()
    }
    
    func save(){
        let context = persistenceController.container.viewContext
        
        do{
            try context.save()
        }
        catch{
            print(error)
        }
    }
}
