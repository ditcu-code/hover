//
//  HomeScreen.swift
//  Hover
//
//  Created by Aditya Cahyo on 19/06/22.
//

import SwiftUI
import CoreData

struct HomeScreen: View {
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        NavigationView {
            TabView {
                Text("Home View")
                    .tabItem {
                        VStack {
                            Image(systemName: "house.fill")
                            Text("Home")
                        }
                    }
                SpecialDatePage()
                    .tabItem {
                        VStack {
                            Image(systemName: "calendar.badge.exclamationmark")
                            Text("Special Date")
                        }
                    }
                ProfilePage()
                    .tabItem {
                        VStack {
                            Image(systemName: "person.fill")
                            Text("Profile")
                        }
                    }
                    .navigationBarBackButtonHidden(true)
                    .navigationBarHidden(true)
            }
        }.onAppear {
            loadCurrentUser()
        }
    }
    
    func loadCurrentUser() {
        let idUser = UserDefaults.standard.string(forKey: "idUser")
        let idPartner = UserDefaults.standard.string(forKey: "idPartner")
        
        let request: NSFetchRequest<User> = NSFetchRequest<User>(entityName: "User")
        request.predicate = NSPredicate(format: "id IN %@", [idUser, idPartner])
        
        do {
            let users = try moc.fetch(request)
            for i in users {
                if i.id?.uuidString == idUser {
                    GlobalObject.shared.user = i
                } else if i.id?.uuidString == idPartner {
                    GlobalObject.shared.user = i
                }
            }
        } catch {
            print("gagal query \(error.localizedDescription)")
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
            .environment(\.managedObjectContext, CoreDataPreviewHelper.preview.container.viewContext)
    }
}
