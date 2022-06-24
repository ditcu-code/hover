//
//  HomeScreen.swift
//  Hover
//
//  Created by Aditya Cahyo on 19/06/22.
//

import SwiftUI

struct HomeScreen: View {
    var body: some View {
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
            MemoryPage()
                .tabItem {
                    VStack {
                        Image(systemName: "folder.fill")
                        Text("Memories")
                    }
                }
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
