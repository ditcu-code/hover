//
//  ContentView.swift
//  Hover
//
//  Created by Aditya Cahyo on 19/06/22.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("isNewUser") private var isNewUser: Bool = true
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var loveLanguages : FetchedResults <LoveLanguages>
    var body: some View {
        if isNewUser {
            OnboardingPage().onAppear(){
                let llName = ["Physical Touch", "Word of Affirmation", "Quality Time", "Receiving Gifts", "Acts of Service"]
                let detail = ["To this person, nothing speaks more deeply than appropriate physical touch.","This language uses words to affirm other people.", "This language is all about giving the other person your undivided attention.", "For some people, receiving a heartfelt gift is what makes them feel most loved.", "For these people, actions speak louder than words."]
                
                for i in 0...llName.count-1{
                    saveLL(llname: llName[i], detail: detail[i])
                }
            }
        } else {
            ActivityTest()
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
