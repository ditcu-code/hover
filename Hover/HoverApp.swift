//
//  HoverApp.swift
//  Hover
//
//  Created by Aditya Cahyo on 19/06/22.
//

import SwiftUI

@main
struct HoverApp: App {
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext )
        }
    }
}
