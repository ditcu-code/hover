//
//  CoreDataTest.swift
//  Hover
//
//  Created by Muhammad Aleandro on 26/06/22.
//

import SwiftUI

struct CoreDataTest: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var loveLanguages : FetchedResults <LoveLanguages>
    var body: some View {
        VStack{
            List(loveLanguages){loveLanguage in
                VStack{
                    
                    Text(loveLanguage.llName ?? "Test")
                        .bold()
                    Text(loveLanguage.detail ?? "Unknown")
                }
            }
            
            Button("Add LL"){
                let llName = ["Physical Touch", "Word of Affirmation", "Quality Time", "Receiving Gifts", "Acts of Service"]
                let detail = ["To this person, nothing speaks more deeply than appropriate physical touch.","This language uses words to affirm other people.", "This language is all about giving the other person your undivided attention.", "For some people, receiving a heartfelt gift is what makes them feel most loved.", "For these people, actions speak louder than words."]
                saveLL(llname: llName[0], detail: detail[0])
//                for i in 1...llName.count-1{
//
//                }
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

struct CoreDataTest_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataTest()
    }
}
