//
//  HomeScreen.swift
//  Hover
//
//  Created by Aditya Cahyo on 19/06/22.
//

import SwiftUI

struct HomeScreen: View {
    var body: some View {
        
        NavigationView {
            List {
                NavigationLink(destination: Tag()) {
                    HStack(spacing: 0) {
                        HStack {
                            Image("woman").resizable().frame(width: 60, height: 60).clipShape(Circle())
                            Image("man").resizable().frame(width: 60, height: 60).clipShape(Circle()).offset(x: -20, y: 0).zIndex(-1)
                        }
                        HStack {
                            Text("Jeniver").fontWeight(.bold)
                            Image(systemName: "app.connected.to.app.below.fill")
                            Text("Adit").fontWeight(.bold)
                        }.font(.title2)
                    }
                }
            }
            
//            .navigationBarHidden(true)
            .navigationTitle("Hover")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: Text("Plus")) {
                        Image(systemName: "plus.circle.fill").symbolRenderingMode(.palette)
                            .foregroundStyle(.black, .yellow)
                    }
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
