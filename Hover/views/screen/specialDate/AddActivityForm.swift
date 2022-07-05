//
//  AddActivityForm.swift
//  Hover
//
//  Created by Aditya Cahyo on 04/07/22.
//

import SwiftUI

struct AddActivityForm: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var globalObject: GlobalObject
    @Environment(\.managedObjectContext) var moc
    @Binding var actSelections: [ActivityList]
    @State var activityName: String = ""
    @State var llSelections: [LoveLanguageEnum] = []
    @FetchRequest(sortDescriptors: []) var loveLanguages : FetchedResults <LoveLanguages>
    @State var loveLanguageSelected: LoveLanguageEnum = .combination
    var loveLanguageUser: LoveLanguageUser {
        LoveLanguageUser(user: globalObject.user)
    }
    var loveLanguagePartner: LoveLanguageUser {
        LoveLanguageUser(user: globalObject.partner)
    }
    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .leading) {
                    Text("\(globalObject.partner.wrappedName) will happy if I do this")
                    
                    TextField("", text: $activityName)
                        .textFieldStyle(.roundedBorder)
                        .overlay(RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.accentColor))
                    Text("and this activity belongs to")
                    
                    Menu(loveLanguageSelected.rawValue.lowercased()){
                        ForEach(LoveLanguageEnum.allCases, id: \.self) { llEnum in
                            if checkLLtoShow(ll: llEnum.rawValue){
                                Button(llEnum.rawValue.lowercased()){
                                    loveLanguageSelected = llEnum
                                }
                            }
                            
                        }
                    }.menuStyle(GrayButtonStyle(width: 220))
                    Text("love language.")
                    
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 8).fill(.white))
                Spacer()
            }
            .padding()
            .font(.title2)
            .background(Color.backgroundColor)
            
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel"){
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        saveActivity()
                        dismiss()
                    }){
                        Text("Save").bold()
                    }
                }
            }
            .navigationTitle("New Plan")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    func saveActivity(){
        let activity = ActivityList(context: moc)
        activity.id = UUID()
        activity.activity = activityName
        var llAct : [LoveLanguages] = []
        for ll in loveLanguages {
            if loveLanguageSelected.rawValue == ll.wrappedLLName{
                llAct.append(ll)
            }else if loveLanguageSelected == .combination{
                if ll.wrappedLLName == getPrimaryLoveLanguageUser() || ll.wrappedLLName == getPrimaryLoveLanguagePartner(){
                    llAct.append(ll)
                }
            }
        }
        let llactivity = Set(llAct)
        for ll in llactivity{
            activity.addToActivityToLL(ll)
        }
        
        if llAct.count != 0 {
            actSelections.append(activity)
            try? moc.save()
        }else{
            print("Test")
        }
    }
    
    func checkLLtoShow(ll: String) -> Bool{
        var isPassed : Bool = false
        if  ll == getPrimaryLoveLanguagePartner() || ll == getSecondaryLoveLanguagePartner() || ll == LoveLanguageEnum.combination.rawValue {
            isPassed = true
        }
        return isPassed
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


struct AddActivityForm_Previews: PreviewProvider {
    static var previews: some View {
        AddActivityForm(actSelections: .constant([]))
    }
}
