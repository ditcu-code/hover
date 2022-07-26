//
//  HoverApp.swift
//  Hover
//
//  Created by Aditya Cahyo on 19/06/22.
//

import SwiftUI

@main
struct HoverApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
//    @StateObject private var dataController = DataController()
    let persistentController = DataController.shared
    @StateObject var specialDayVM = SpecialDayViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistentController.container.viewContext)
                .environmentObject(specialDayVM)
        }
    }
}
