//
//  ContentView.swift
//  Hover
//
//  Created by Aditya Cahyo on 19/06/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @StateObject var globalObject = GlobalObject.shared
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \LoveLanguages.llName, ascending: true)]) var loveLanguages : FetchedResults <LoveLanguages>
    
    @AppStorage("isDoneOnboarding") private var isDoneOnboarding: Bool = false
    @AppStorage("idUser") private var idUser: String = ""
    @AppStorage("idPartner") private var idPartner: String = ""
    
    var body: some View {
        ZStack {
            Color.backgroundColor
                .ignoresSafeArea()
            if isDoneOnboarding {
                HomeScreen()
                    .environmentObject(globalObject)
            } else {
                OnboardingPage()
                    .onAppear(){
                        if loveLanguages.isEmpty {
                            let llName = ["Physical Touch", "Word of Affirmation", "Quality Time", "Receiving Gifts", "Acts of Service"]
                            let detail = ["To this person, nothing speaks more deeply than appropriate physical touch.","This language uses words to affirm other people.", "This language is all about giving the other person your undivided attention.", "For some people, receiving a heartfelt gift is what makes them feel most loved.", "For these people, actions speak louder than words."]
                            
                            for i in 0...llName.count - 1 {
                                saveLL(llname: llName[i], detail: detail[i])
                            }
                            
                            for a in ["Duh", "Gw", "Bingung"] {
                                saveActivityWithLL(activity: a)
                            }
                        }
                    }
                    .environmentObject(globalObject)
            }
        }
    }
    
    func saveLL(llname: String, detail: String){
        let loveLanguage = LoveLanguages(context: moc)
        loveLanguage.id = UUID()
        loveLanguage.llName = llname
        loveLanguage.detail = detail
        try? moc.save()
    }
    
    func saveActivityWithLL(activity: String) {
        let a = ActivityList(context: moc)
        a.id = UUID()
        a.activity = activity
        for s in 0...1 {
            var llActivity = Set([loveLanguages.randomElement()!])
            if s % 2 == 0 {
                llActivity = Set(loveLanguages.filter({ f in
                    f.wrappedLLName == LoveLanguageEnum.qualityTime.rawValue || f.wrappedLLName == LoveLanguageEnum.receivingGift.rawValue
                }))
            } else {
                llActivity = Set(loveLanguages.filter({ f in
                    f.wrappedLLName == LoveLanguageEnum.qualityTime.rawValue
                }))
            }
            for ll in llActivity {
                a.addToActivityToLL(ll)
            }
        }
        
        try? moc.save()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
