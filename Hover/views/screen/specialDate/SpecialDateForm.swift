//
//  SpecialDateForm.swift
//  Hover
//
//  Created by Eddo Careera Iriyanto Putra on 24/06/22.
//

import SwiftUI

struct SpecialDateForm: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var globalObject: GlobalObject
    
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
    
    @State var showAddPlan: Bool = false
    
    var body: some View {
        let nameNotEmpty = specialDayName.count > 0
        
        NavigationView {
            VStack(alignment: .center) {
                
                VStack(alignment: .leading) {
                    
                    Text("I want to **celebrate**")
                    
                    TextField("", text: $specialDayName)
                        .textFieldStyle(.roundedBorder)
                        .overlay(RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.accentColor))
                    
                    if nameNotEmpty {
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
                                    ForEach(Repeat.allCases, id: \.self) { item in
                                        Button(item.rawValue) {
                                            selectedRepeat = item
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
                    
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 8).fill(.white))
                
                if nameNotEmpty {
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
                                ActivityItem(actSelections: $actSelections)
                            }
                        }
                        
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8).fill(.white))
                }
                Spacer()
                
            }
            .padding()
            .font(.title2)
            .background(Color.backgroundColor)
            .animation(.default, value: nameNotEmpty)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel"){
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save"){
                        saveData()
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .bottomBar) {
                    if nameNotEmpty {
                        if isActivityWanted {
                            withAnimation {
                                Button(action: {showAddPlan.toggle()}) {
                                    Label("I have my own activitiy plan", systemImage: "plus.circle.fill").labelStyle(.titleAndIcon)
                                }
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
            .navigationTitle("New Special Day")
            .navigationBarTitleDisplayMode(.inline)
        }
        
        .sheet(isPresented: $showAddPlan) {
            AddActivityForm(actSelections: $actSelections)
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
    
    func saveData(){
        let specialDay = SpecialDay(context: moc)
        specialDay.id = UUID()
        specialDay.notificationID = UUID().uuidString
        specialDay.date = selectedDate
        specialDay.name = specialDayName
        specialDay.repeatNotif = selectedRepeat.rawValue
        specialDay.alert = selectedAlert.rawValue
        let sdActivity = Set(actSelections)
        print(sdActivity)
        for act in sdActivity{
            specialDay.addToSpecialToActivity(act)
        }
        try? moc.save()
        
        globalObject.showCongrats.toggle()
    }
    
}

struct SpecialDateForm_Previews: PreviewProvider {
    static var previews: some View {
        SpecialDateForm().environmentObject(GlobalObject.shared)
    }
}

struct ActivityItem: View {
    @EnvironmentObject var globalObject: GlobalObject
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var activities : FetchedResults <ActivityList>
    var loveLanguageUser: LoveLanguageUser {
        LoveLanguageUser(user: globalObject.user)
    }
    var loveLanguagePartner: LoveLanguageUser {
        LoveLanguageUser(user: globalObject.partner)
    }
    @Binding var actSelections: [ActivityList]
    
    var body: some View {
        ForEach(activities){activity in
            if checkActivityToShow(llList: activity.llArray){
                MultipleSelectionRow(title: activity.activity ?? "Unknown", isSelected: self.actSelections.contains(activity ), llData: activity.llArray) {
                    if self.actSelections.contains(activity) {
                        let _ = print("engga")
                        self.actSelections.removeAll(where: { $0.id?.uuidString == activity.id?.uuidString ?? "Unknown" })
                    }
                    else {
                        let _ = print("NAMBAAAH")
                        self.actSelections.append(activity)
                    }
                }
            }
        }
    }
    func getPrimaryLoveLanguageUser() -> String {
        return loveLanguageUser.getPrimaryLoveLanguage()
    }
    func getPrimaryLoveLanguagePartner() -> String {
        return loveLanguagePartner.getPrimaryLoveLanguage()
    }
    func getSecondaryLoveLanguagePartner() -> String {
        return loveLanguagePartner.getSecondaryLoveLanguage()
    }
    func checkActivityToShow(llList: [LoveLanguages]) -> Bool{
        var isPassed: Bool = false
        for ll in llList {
            if ll.wrappedLLName == getPrimaryLoveLanguageUser(){
                isPassed = true
            }else if ll.wrappedLLName == getPrimaryLoveLanguagePartner(){
                isPassed = true
            }else if ll.wrappedLLName == getSecondaryLoveLanguagePartner(){
                isPassed = true
            }else{
                isPassed = false
            }
        }
        return isPassed
    }
}
struct MultipleSelectionRow: View {
    var title: String
    var isSelected: Bool
    @State var llData:[LoveLanguages]
    var action: () -> Void
    
    var body: some View {
        Button(action: self.action) {
            HStack {
                LoveLanguageLogoBg(loveLanguageName: getLLLogo(), size: 45, cornerRadius: 8)
                Text(title).font(.body).bold()
                Spacer()
                if self.isSelected {
                    Image(systemName: "checkmark.circle.fill").foregroundColor(.accentColor)
                }
            }
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 8)
                .stroke(self.isSelected ? Color.accentColor : Color.gray))
            .animation(.default, value: self.isSelected)
        }
    }
    
    func getLLLogo()-> String{
        var counter: Int = 1
        var LLName: String = ""
        for ll in llData{
            if counter == 1{
                LLName = ll.wrappedLLName
            }else if counter == 2{
                LLName = LoveLanguageEnum.combination.rawValue
            }
            counter += 1
        }
        return LLName
    }
}
