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
    
    @ObservedObject var globalObject: GlobalObject = GlobalObject()
    
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
            }
        }.onAppear {
            DataController.shared.loadCurrentUser()
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
