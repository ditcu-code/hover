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
    
    @AppStorage("isNewUser") private var isNewUser: Bool = true
    @AppStorage("idUser") private var idUser: String = ""
    @AppStorage("idPartner") private var idPartner: String = ""
    
    var body: some View {
        ZStack {
            Color.backgroundColor
                .ignoresSafeArea()
            if isNewUser {
                OnboardingPage()
            } else {
                HomeScreen()
                    .onAppear {
                        initializeSessionUser()
                    }
            }
        }
    }
    
    func initializeSessionUser() {
        let idUser = UserDefaults.standard.string(forKey: "idUser")
        let idPartner = UserDefaults.standard.string(forKey: "idPartner")
        @FetchRequest(
            sortDescriptors: [],
            predicate: NSPredicate(format: "id IN %@", [idUser, idPartner])
        ) var users: FetchedResults<User>
        
        for user in users {
            if user.id?.uuidString == idUser {
                GlobalObject.shared.user = user
            } else if user.id?.uuidString == idPartner {
                GlobalObject.shared.partner = user
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
