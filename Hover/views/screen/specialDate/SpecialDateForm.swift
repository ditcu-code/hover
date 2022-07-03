//
//  SpecialDateForm.swift
//  Hover
//
//  Created by Eddo Careera Iriyanto Putra on 24/06/22.
//

import SwiftUI

struct SpecialDateForm: View {
    @Environment(\.presentationMode) var presentationMode
    @State var navActive: Bool = false
    @State private var specialDateTextField: String = ""
    @State var selectedDate = Date()
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var activities : FetchedResults <ActivityList>
    @State var actSelections: [ActivityList] = []
    @State private var selectedRepeat: Repeat = .none
    @State private var selectedAlert: Alert = .none
    var body: some View {
        NavigationView{
            ScrollView{
                ZStack{
                    Section{
                        TextField(
                                "I want to celebrate",
                                text: $specialDateTextField
                            )
                            .padding()
                            .frame(width: screenSize-50, height: 100, alignment: .top)
                            .background(.white)
                            .cornerRadius(5)
                            //.border(Colo)
                            .shadow(color: .black, radius: 1)
                    }
                    .frame(width: screenSize-20, height: 120, alignment: .center)
                    .background(.white)
                    .navigationBarTitleDisplayMode(.inline)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Save"){
//                            let notificationID = UUID().uuidString
//                            saveData(notifID: notificationID)
//                            createLocalNotification(title: specialDateTextField, date: selectedDate, repeat: selectedRepeat.rawValue, alert: selectedAlert, notifID: notificationID)
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
            }
            .background(Color.backgroundColor)
            .frame(width: screenSize, height: screenHeight)
        }
    }
    func createLocalNotification(title: String, date: Date, repeat: String, alert: Alert, notifID: String){
        if alert != .none{
            let content = UNMutableNotificationContent()
            content.title = title
            content.body = dateCaller(date)
            let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.day, .month, .year], from: alertDate(date, alert)), repeats: false)
            let request = UNNotificationRequest(identifier: notifID, content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request)
            UNUserNotificationCenter.current().getPendingNotificationRequests { a in
                print(a)
            }
        }
    }
    func saveData(notifID: String){
        let specialDay = SpecialDay(context: moc)
        specialDay.id = UUID()
        specialDay.notificationID = UUID().uuidString
        specialDay.date = selectedDate
        specialDay.name = specialDateTextField
        specialDay.repeatNotif = selectedRepeat.rawValue
        specialDay.alert = selectedAlert.rawValue
        let sdActivity = Set(actSelections)
        for act in sdActivity{
            specialDay.addToSpecialToActivity(act)
        }
        try?moc.save()
    }
}

struct SpecialDateForm_Previews: PreviewProvider {
    static var previews: some View {
        SpecialDateForm()
    }
}
