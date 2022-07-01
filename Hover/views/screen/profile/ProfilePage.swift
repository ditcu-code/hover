//
//  ProfilePage.swift
//  Hover
//
//  Created by Eddo Careera Iriyanto Putra on 24/06/22.
//

import SwiftUI

struct ProfilePage: View {
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \LoveLanguages.llName, ascending: true)]) var loveLanguages : FetchedResults <LoveLanguages>
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePage()
    }
}
