//
//  CoreDataTest.swift
//  Hover
//
//  Created by Muhammad Aleandro on 26/06/22.
//

import SwiftUI

struct CoreDataTest: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var loveLanguages : FetchedResults <LoveLanguage>
    var body: some View {
        VStack{
            List(loveLanguages){loveLanguage in
                VStack{
                    
                    Text(loveLanguage.llName ?? "Test")
                        .bold()
                    Text(loveLanguage.detail ?? "Unknown")
                }
            }
            
//            Button("Add LL"){
//                let llName = ["Physical Touch", "Word of Affirmation", "Quality Time", "Receiving Gifts"]
//                let detail = ["To this person, nothing speaks more deeply than appropriate physical touch.","This language uses words to affirm other people.", "This language is all about giving the other person your undivided attention.", "For some people, receiving a heartfelt gift is what makes them feel most loved."]
//                let loveLanguage = LoveLanguage(context: moc)
//                
//                    loveLanguage.id = UUID()
//                    loveLanguage.llName = llName[2]
//                    loveLanguage.detail = detail[2]
//                    try? moc.save()
//                
//                
//                
//
//            }
        }
    }
}

struct CoreDataTest_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataTest()
    }
}
