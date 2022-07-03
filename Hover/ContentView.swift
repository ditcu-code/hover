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
    @StateObject var globalObject : GlobalObject = GlobalObject.shared
    
    @FetchRequest(sortDescriptors: []) var loveLanguages : FetchedResults <LoveLanguages>
    @AppStorage("isDoneOnboarding") private var isDoneOnboarding: Bool = false
    @AppStorage("idUser") private var idUser: String = ""
    @AppStorage("idPartner") private var idPartner: String = ""
    
    var body: some View {
        ZStack {
            Color.backgroundColor
                .ignoresSafeArea()
            if UserDefaults.standard.bool(forKey: "isDoneOnboarding") {
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
                        }
                    }
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
