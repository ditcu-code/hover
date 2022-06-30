//
//  ShowDataActivityTest.swift
//  Hover
//
//  Created by Muhammad Aleandro on 29/06/22.
//

import SwiftUI

struct ShowDataActivityTest: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var activities : FetchedResults <ActivityList>
    @FetchRequest(sortDescriptors: []) var loveLanguages : FetchedResults <LoveLanguages>
    var body: some View {
        VStack{
            List{
                ForEach(activities, id: \.self){activity in
                    Section(activity.wrappedActivity){
                        ForEach(activity.llArray, id:\.self){loveLanguage in
                            Text(loveLanguage.wrappedLLName)
                        }
                    }
                    Button(action: {
                        deleteItems(item: activity)}){
                        Text("Delete")
                    }
                }
            }
        }
    }
    private func deleteItems(item:ActivityList) {
        moc.delete(item)
        try?moc.save()
        }
}


struct ShowDataActivityTest_Previews: PreviewProvider {
    static var previews: some View {
        ShowDataActivityTest()
    }
}

