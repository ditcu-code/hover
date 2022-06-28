//
//  LoveLanguagePrompt.swift
//  Hover
//
//  Created by Eddo Careera Iriyanto Putra on 24/06/22.
//

import SwiftUI

struct LoveLanguagePrompt: View {
    @Binding var onboardingStep: Int
    @State var isNavigationActive: Bool = false
    
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()
            VStack {
                HStack {
                    Text("What's your\nLove Language?")
                        .font(.title)
                        .bold()
                    Spacer()
                }
//                VStack(alignment: .leading) {
                HStack {
                    Text("We need to know your love language so we can recommend some activities to you.")
                            .font(.subheadline)
                        .foregroundColor(Color("CaptionColor"))
                    Spacer()
                }
//                }
//                Text("\(onboardingStep)")
                if onboardingStep == 3 {
                    NavigationLink {
                        LoveLanguagePrompt(onboardingStep: .constant(onboardingStep + 1))
                    } label: {
//                        Image(systemName: "chevron.forward")
                    }
                } else {
                    Button {
                        withAnimation {
                            UserDefaults.standard.set(false, forKey: "isNewUser")
                        }
                    } label: {
//                        Image(systemName: "chevron.forward")
                    }

                }
            }.padding()
        }
    }
}

struct LoveLanguagePrompt_Previews: PreviewProvider {
    static var previews: some View {
        LoveLanguagePrompt(onboardingStep: .constant(3))
    }
}
