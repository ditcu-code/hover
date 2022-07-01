//
//  ShowSpecialDate.swift
//  Hover
//
//  Created by Muhammad Aleandro on 30/06/22.
//

import SwiftUI

struct ShowSpecialDay: View {
    @State var navActive: Bool = false
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var activities : FetchedResults <ActivityList>
    @FetchRequest(sortDescriptors: []) var specialDays : FetchedResults <SpecialDay>
    var body: some View {
        NavigationView{
            VStack{
                List{
                    ForEach(specialDays, id: \.self){specialDay in
                        Section(specialDay.wrappedName){
                            ForEach(specialDay.activityInSDArray, id:\.self){activity in
                                Text(activity.wrappedActivity)
                            }
                            Text(specialDay.notificationID ?? "Unknown")
                        }
                        Button(action: {
                            deleteItems(item: specialDay)}){
                            Text("Delete")
                        }
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Add Special Day"){
                            navActive.toggle()
                        }
                    }
                }
                .sheet(isPresented: $navActive){
                    AddSpecialDateTest()
                }
//                NavigationLink(isActive: $navActive) {
//                    AddSpecialDateTest()
//                } label: {
//
//                }
            }
        }
    }
    private func deleteItems(item:SpecialDay) {
        moc.delete(item)
        try?moc.save()
        }
}

struct ShowSpecialDate_Previews: PreviewProvider {
    static var previews: some View {
        ShowSpecialDay()
    }
}
