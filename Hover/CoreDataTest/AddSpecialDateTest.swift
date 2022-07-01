//
//  AddSpecialDateTest.swift
//  Hover
//
//  Created by Muhammad Aleandro on 30/06/22.
//

import SwiftUI

struct AddSpecialDateTest: View {
    @Environment(\.presentationMode) var presentationMode
    @State var navActive: Bool = true
    @State private var specialDateTextField: String = ""
    @State var selectedDate = Date()
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var activities : FetchedResults <ActivityList>
    @State var actSelections: [ActivityList] = []
    enum Repeat: String, CaseIterable, Identifiable {
        case none, monthly, yearly
        var id: Self { self }
    }
    @State private var selectedRepeat: Repeat = .none
    
    enum Alert: String, CaseIterable, Identifiable {
        case none, oneDay, twoDay, threeDay, oneWeek
        var id: Self { self }
    }
    @State private var selectedAlert: Alert = .none
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
                
                DatePicker("The Date:", selection: $selectedDate, displayedComponents: .date)
                    .padding(.top)
                    .padding(.horizontal)
                HStack{
                    Text("Repeat:")
                        .padding(.horizontal)
                    Spacer()
                    Picker("Repeat", selection: $selectedRepeat) {
                            Text("None").tag(Repeat.none)
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
                            Text("None").tag(Alert.none)
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
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Save"){
                            saveData()
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
                
                
                
                Spacer()
            }
        }
    }
    func saveData(){
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
    func addNotification(){
        
    }
}

struct AddSpecialDateTest_Previews: PreviewProvider {
    static var previews: some View {
        AddSpecialDateTest()
    }
}
