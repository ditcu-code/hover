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
    @State private var isActivityWanted: Bool = true
    
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
            VStack(alignment: .center) {
                
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
                    }
                    
                    HStack {
                        
                        Text("be repeated\(isRepeated ? "" : ".")")
                        if isRepeated {
                            Menu(selectedRepeat.rawValue) {
                                ForEach(Repeat.allCases, id: \.self) { a in
                                    Button(a.rawValue) {
                                        selectedRepeat = a
                                    }
                                }
                            }.menuStyle(GrayButtonStyle())
                        }
                        
                    }
                    
                    HStack {
                        Text("Please **remind** me")
                        Menu(selectedAlert.rawValue) {
                            ForEach(Alert.allCases, id: \.self) { a in
                                Button(a.rawValue) {
                                    selectedAlert = a
                                }
                            }
                        }.menuStyle(GrayButtonStyle(width: 115))
                    }
                    
                    Text("before the date.")
                    
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 8).fill(.white))
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("I think, I")
                        Button(isActivityWanted ? "want" : "haven't") {
                            withAnimation(.easeInOut) {
                                isActivityWanted.toggle()
                            }
                        }.buttonStyle(.bordered)
                        Text("to do some")
                    }
                    HStack {
                        Text("activities during the celebration.")
                        Spacer()
                    }
                    
                    if isActivityWanted {
                        ScrollView() {
                            ForEach((1...10), id: \.self) {_ in
                                ActivityItem()
                            }
                        }
                    }
                    
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 8).fill(.white))
                
                Spacer()
                
            }
            .padding()
            .font(.title2)
            .background(Color.backgroundColor)
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save"){
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
                
                ToolbarItem(placement: .bottomBar) {
                    if isActivityWanted {
                        withAnimation {
                            Button(action: {}) {
                                Label("I have my own activitiy plan", systemImage: "plus.circle.fill").labelStyle(.titleAndIcon)
                            }
                        }
                    }
                }
                ToolbarItem(placement: .bottomBar) {
                    if isActivityWanted {
                        Spacer()
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

struct ActivityItem: View {
    @State var selected: Bool = false
    
    var body: some View {
        HStack {
            LoveLanguageLogoBg(loveLanguageName: LoveLanguageEnum.combination.rawValue, size: 45, cornerRadius: 8)
            Text("Warm Hug Together").font(.body).bold()
            Spacer()
            if selected {
                Image(systemName: "checkmark.circle.fill").foregroundColor(.accentColor)
            }
        }
        .padding()
        .overlay(RoundedRectangle(cornerRadius: 8)
            .stroke(selected ? Color.accentColor : Color.gray))
        
        .onTapGesture {
            selected.toggle()
        }
        .animation(.default, value: selected)
    }
}
