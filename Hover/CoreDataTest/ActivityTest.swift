//
//  ActivityTest.swift
//  Hover
//
//  Created by Muhammad Aleandro on 28/06/22.
//

import SwiftUI


struct ActivityTest: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var activityTextField: String = ""
    @State var llselections: [LoveLanguages] = []
    @EnvironmentObject var globalObject: GlobalObject
    @State var navActive: Bool = false
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var loveLanguages : FetchedResults <LoveLanguages>
    @FetchRequest(sortDescriptors: []) var activities : FetchedResults <ActivityList>
    @FetchRequest(sortDescriptors: []) var users : FetchedResults <User>
    var loveLanguageUser: LoveLanguageUser {
        LoveLanguageUser(user: globalObject.user)
    }
    var loveLanguagePartner: LoveLanguageUser {
        LoveLanguageUser(user: globalObject.partner)
    }
    var body: some View {
        NavigationView{
            VStack{
                TextField(
                        "What you want to do? HAH!",
                        text: $activityTextField
                    )
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .border(.secondary)
                    .cornerRadius(20)
                List {
//                    ForEach(loveLanguages, id: \.self) { lovelanguage in
//                        if checkLLUser(llname: lovelanguage.llName ?? "Unknown"){
//                            MultipleSelectionRow(title: lovelanguage.llName ?? "Unknown", isSelected: self.llselections.contains(lovelanguage )) {
//                                if self.llselections.contains(lovelanguage) {
//                                    self.llselections.removeAll(where: { $0.id?.uuidString == lovelanguage.id?.uuidString ?? "Unknown" })
//                                }
//                                else {
//                                    if self.llselections.count <= 1 {
//                                    self.llselections.append(lovelanguage)
//                                    }else{
//                                        self.llselections.removeAll(where: { $0 == self.llselections.first})
//                                        self.llselections.append(lovelanguage)
//                                    }
//                                }
//                            }
//                        }
//                    }
                }
                
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Add Activity"){ 
                            let activity = ActivityList(context: moc)
                            activity.id = UUID()
                            activity.activity = activityTextField
                            let llactivity = Set(llselections)
                            for ll in llactivity{
                                activity.addToActivityToLL(ll)
                            }
                            
                            if llselections.count != 0 {
                                try? moc.save()
                                self.presentationMode.wrappedValue.dismiss()
                            }else{
                                print("Test")
                            }
                        }
                    }
                }
                
            }
        }
    }
    
    func checkLLUser(llname : String) -> Bool{
        var isLLTrue = false
        var llUserPartner : [String] = []
        let userPrimaryLL = getPrimaryLoveLanguageUser()
        let partnerPrimaryLL = getPrimaryLoveLanguagePartner()
        let partnerSecondaryLL = getSecondaryLoveLanguagePartner()
        llUserPartner.append(userPrimaryLL)
        llUserPartner.append(partnerPrimaryLL)
        if !partnerSecondaryLL.isEmpty{
            llUserPartner.append(partnerSecondaryLL)
        }
        for ll in llUserPartner {
            if llname == ll{
                isLLTrue = true
            }
        }
        
        return isLLTrue
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
}

//struct MultipleSelectionRow: View {
//    var title: String
//    var isSelected: Bool
//    var action: () -> Void
//    
//    var body: some View {
//        Button(action: self.action) {
//            HStack {
//                Text(self.title)
//                if self.isSelected {
//                    Spacer()
//                    Image(systemName: "checkmark")
//                }
//            }
//        }
//    }
//}
struct ActivityTest_Previews: PreviewProvider {
    static var previews: some View {
        ActivityTest()
    }
}
