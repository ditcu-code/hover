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
//    @FetchRequest(sortDescriptors: []) var activities_ll : FetchedResults <Activity_LL>
    @FetchRequest(sortDescriptors: []) var loveLanguages : FetchedResults <LoveLanguages>
    var body: some View {
        VStack{
            List(activities){activity in
                VStack{
                    Text(activity.activity ?? "Test")
                        .bold()
                }
                
            }
        }
        
    }
//    func callLL(activityID: String, llID: String){
//        var result: Bool
//        ForEach(activities_ll){activityll in
//            if activityID == activityll.idActivity{
//                
//            }
//        }
//    }
}


struct ShowDataActivityTest_Previews: PreviewProvider {
    static var previews: some View {
        ShowDataActivityTest()
    }
}

