//
//  SpecialDateForm.swift
//  Hover
//
//  Created by Eddo Careera Iriyanto Putra on 24/06/22.
//

import SwiftUI

enum RepeatedEnum: String, CaseIterable {
    case year = "every year", month = "every month", week = "every week"
}

struct SpecialDateForm: View {
    @Environment(\.presentationMode) var presentationMode
    @State var navActive: Bool = false
    
    @State private var specialDayName: String = ""
    @State private var isRepeated: Bool = true
    @State private var isTaskWanted: Bool = true
    
    @State var selectedDate = Date()
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var activities : FetchedResults <ActivityList>
    @State var actSelections: [ActivityList] = []
    @State private var selectedRepeat: Repeat = .monthly
    @State private var selectedAlert: Alert = .oneDay
    
    @State var chatTextInput: String = ""
    @State var oldChatValue: String = ""
    @State var newChatValue: String = ""
    
    @State var textEntryFlag = true
    
    
    var body: some View {
        
        //        let nameNotEmpty = specialDayName.count > 0
        
        NavigationView {
            ScrollView {
                VStack {
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 8).fill(.white)
                        
                        VStack(alignment: .leading) {
                            
                            Text("I want to **celebrate**")
                            
                            TextField("", text: $specialDayName)
                                .textFieldStyle(.roundedBorder)
                                .overlay(RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.accentColor))
                            
                            HStack {
                                
                                Text("on").bold()
                                DatePicker("", selection: $selectedDate, displayedComponents: [.date])
                                    .labelsHidden()
                                    .scaleEffect(1.1)
                                    .padding(.horizontal, 5)
                                
                                Text("and")
                                Button(isRepeated ? "would" : "wouldn't") {
                                    withAnimation(.easeInOut) {
                                        isRepeated.toggle()
                                    }
                                }.buttonStyle(.bordered)
                                Text("be")
                                
                            }.font(.title3)
                            
                            HStack {
                                
                                Text("repeated\(isRepeated ? "" : ".")")
                                if isRepeated {
                                    Menu(selectedRepeat.rawValue) {
                                        ForEach(Repeat.allCases, id: \.self) { a in
                                            Button(a.rawValue) {
                                                selectedRepeat = a
                                            }
                                        }
                                    }.menuStyle(GrayButtonStyle())
                                }
                                
                            }.font(.title3)
                            
                            HStack {
                                Text("Please **remind** me")
                                Menu(selectedAlert.rawValue) {
                                    ForEach(Alert.allCases, id: \.self) { a in
                                        Button(a.rawValue) {
                                            selectedAlert = a
                                        }
                                    }
                                }.menuStyle(GrayButtonStyle(width: 115))
                            }.font(.title3)
                            
                            Text("before the date.")
                            
                        }.padding().font(.title2)
                        
                    }.padding(.horizontal)
                    
                }
                
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 8).fill(.white)
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("I think, I")
                            Button(isTaskWanted ? "want" : "haven't") {
                                withAnimation(.easeInOut) {
                                    isTaskWanted.toggle()
                                }
                            }.buttonStyle(.bordered)
                            Text("to do some")
                            
                        }
                        HStack{
                            Text("activities during the celebration.")
                        }
                        List {
                            HStack {
                                
                            }
                        }
                    }.padding().font(.title2)
                    
                }.padding(.horizontal)
                
            }
            .background(Color.backgroundColor)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save"){
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
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
        specialDay.name = specialDayName
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

struct GrayButtonStyle: MenuStyle {
    var width: CGFloat = 130
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8).fill(Color.bgButton).frame(width: width, height: 38)
            Menu(configuration)
        }
    }
}
