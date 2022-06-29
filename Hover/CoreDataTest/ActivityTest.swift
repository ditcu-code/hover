//
//  ActivityTest.swift
//  Hover
//
//  Created by Muhammad Aleandro on 28/06/22.
//

import SwiftUI

//extension LoveLanguages{
//    public var activityArray: [ActivityList]{
//        let set = llToActivity as? Set<ActivityList> ?? []
////        return set.sorted(by: <#T##(ActivityList, ActivityList) throws -> Bool#>)
//    }
//}
struct ActivityTest: View {
    @State private var activityTextField: String = ""
    @State var llselections: [String] = []
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \LoveLanguages.llName, ascending: true)]) var loveLanguages : FetchedResults <LoveLanguages>
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \ActivityList.activity, ascending: true)]) var activities : FetchedResults <ActivityList>
    var body: some View {
        VStack{
            List {
                ForEach(loveLanguages, id: \.self) { lovelanguage in
                    MultipleSelectionRow(title: lovelanguage.llName ?? "Unknown", isSelected: self.llselections.contains(lovelanguage.id?.uuidString ?? "Unknown" )) {
                        if self.llselections.contains(lovelanguage.id?.uuidString ?? "Unknown") {
                            self.llselections.removeAll(where: { $0 == lovelanguage.id?.uuidString ?? "Unknown" })
                        }
                        else {
                            if self.llselections.count <= 1 {
                                self.llselections.append(lovelanguage.id?.uuidString ?? "Unknown")
                            }else{
                                self.llselections.removeAll(where: { $0 == self.llselections.first})
                                self.llselections.append(lovelanguage.id?.uuidString ?? "Unknown")
                            }
                        }
                    }
                }
            }
            TextField(
                "User name (email address)",
                text: $activityTextField
            )
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .border(.secondary)
            
            Button("Add Activity"){
                let activity = ActivityList(context: moc)
                activity.id = UUID()
                activity.activity = activityTextField
                
                //                for i in 0...llselections.count-1{
                //                    addActivityLL(idActivity: activity.id?.uuidString ?? "Unknown", idLL: llselections[i])
                //                }
                if llselections.count != 0 {
                    try? moc.save()
                }else{
                    print("Test")
                }
            }
        }
    }
}
struct MultipleSelectionRow: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: self.action) {
            HStack {
                Text(self.title)
                if self.isSelected {
                    Spacer()
                    Image(systemName: "checkmark")
                }
            }
        }
    }
}
struct ActivityTest_Previews: PreviewProvider {
    static var previews: some View {
        ActivityTest()
    }
}
