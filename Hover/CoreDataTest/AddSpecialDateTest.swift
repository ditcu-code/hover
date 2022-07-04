//
//  AddSpecialDateTest.swift
//  Hover
//
//  Created by Muhammad Aleandro on 30/06/22.
//

import SwiftUI

struct AddSpecialDateTest: View {
    @Environment(\.presentationMode) var presentationMode
    @State var navActive: Bool = false
    @State private var specialDateTextField: String = ""
    @State var selectedDate = Date()
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var activities : FetchedResults <ActivityList>
    @State var actSelections: [ActivityList] = []
    
    @State private var selectedRepeat: Repeat = .monthly
    @State private var selectedAlert: Alert = .oneDay
    var body: some View {
        NavigationView{
            VStack{
                TextField(
                        "What day is it?",
                        text: $specialDateTextField
                    )
                    .padding()
                    .frame(height: 44)
                    .background(.white)
                    .cornerRadius(5)
                    .shadow(color: .black, radius: 1)
                
                DatePicker("The Date:", selection: $selectedDate, displayedComponents: [.date])
                    .padding(.top)
                    .padding(.horizontal)
                HStack{
                    Text("Repeat:")
                        .padding(.horizontal)
                    Spacer()
                    Picker("Repeat", selection: $selectedRepeat) {
//                            Text("None").tag(Repeat.none)
                            Text("Monthly").tag(Repeat.monthly)
                            Text("Yearly").tag(Repeat.yearly)
                        }
                    .padding(.horizontal)
                }
                HStack{
                    Text("Alert:")
                        .padding(.horizontal)
                    Spacer()
                    Picker("Alert", selection: $selectedAlert) {
//                            Text("None").tag(Alert.none)
//                        Text("1 Minute").tag(Alert.oneMinute)
                            Text("1 day before").tag(Alert.oneDay)
                            Text("2 days before").tag(Alert.twoDay)
                            Text("3 days before").tag(Alert.threeDay)
                            Text("1 week before").tag(Alert.oneWeek)
                        }
                    .padding(.horizontal)
                }
                List {
                    ForEach(activities, id: \.self) { activity in
                        MultipleSelectionRow(title: activity.activity ?? "Unknown", isSelected: self.actSelections.contains(activity )) {
                            if self.actSelections.contains(activity) {
                                self.actSelections.removeAll(where: { $0.id?.uuidString == activity.id?.uuidString ?? "Unknown" })
                            }
                            else {
                                self.actSelections.append(activity)
                            }
                        }
                    }
                }
                Button("Add Activity"){
                    navActive = true
                }
                NavigationLink(isActive: $navActive) {
                    ActivityTest()
                } label: {
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Save"){
                            let notificationID = UUID().uuidString
                            saveData(notifID: notificationID)
                            createLocalNotification(title: specialDateTextField, date: selectedDate, repeat: selectedRepeat.rawValue, alert: selectedAlert, notifID: notificationID)
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
                
                
                
                Spacer()
            }
        }
    }
    func createLocalNotification(title: String, date: Date, repeat: String, alert: Alert, notifID: String){
//        if alert != .none{
            let content = UNMutableNotificationContent()
            content.title = title
            content.body = dateCaller(date)
            let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.day, .month, .year], from: alertDate(date, alert)), repeats: false)
            let request = UNNotificationRequest(identifier: notifID, content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request)
            UNUserNotificationCenter.current().getPendingNotificationRequests { a in
                print(a)
            }
//        }
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

struct AddSpecialDateTest_Previews: PreviewProvider {
    static var previews: some View {
        AddSpecialDateTest()
    }
}
