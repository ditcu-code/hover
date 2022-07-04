//
//  Congrats.swift
//  Hover
//
//  Created by Aditya Cahyo on 05/07/22.
//

import SwiftUI

struct Congrats: View {
    @EnvironmentObject var globalObject: GlobalObject
    
    var body: some View {
        let name = globalObject.user.wrappedName
        
        ZStack {
            Color.backgroundColor.ignoresSafeArea()
            VStack {
                Image("congrats").resizable().aspectRatio(contentMode: .fit)
                VStack(alignment: .leading) {
                    Text("Nice Job, \(name)!").font(.title).bold()
                    Text("You have succeeded in making a special day plan to get closer to your partner.\n\nDon't forget to prepare yourself for the special day ✨")
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 8).fill(.white))
                
                Button {
                    globalObject.showCongrats.toggle()
                } label: {
                    Text("Got it")
                        .bold()
                        .frame(width: 300, height: 50)
                        .foregroundColor(.white)
                        .background(Color.activeButtonColor)
                        .cornerRadius(30)
                        .padding(.top, 10)
                }
            }.padding()
        }
    }
}

struct Congrats_Previews: PreviewProvider {
    static var previews: some View {
        Congrats()
            .environmentObject(GlobalObject.shared)
    }
}
