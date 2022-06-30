//
//  ContentView.swift
//  Hover
//
//  Created by Aditya Cahyo on 19/06/22.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("isNewUser") private var isNewUser: Bool = true
    
    var body: some View {
        ZStack {
            Color.backgroundColor
                .ignoresSafeArea()
            if true {
                OnboardingPage()
            } else {
                HomeScreen()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
