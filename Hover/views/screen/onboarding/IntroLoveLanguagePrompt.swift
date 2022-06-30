//
//  IntroLoveLanguagePrompt.swift
//  Hover
//
//  Created by Eddo Careera Iriyanto Putra on 29/06/22.
//

import SwiftUI

struct IntroLoveLanguagePrompt: View {
    @Binding var onboardingStep: Int
    
    var progress: Int {
        onboardingStep + 1
    }
    
    var currentUser: User {
        onboardingStep == 3 ? GlobalObject.shared.user : GlobalObject.shared.partner
    }
    
    var body: some View {
        ZStack {
            Color.backgroundColor.ignoresSafeArea()
            VStack {
                VStack {
                    ProgressView(value: (Float(progress) / Float(onboardingTotalStep)))
                        .animation(.easeInOut(duration: 1), value: onboardingTotalStep)
                        .padding(.bottom, 160)
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Next,\nWe need to know\nyour Love Language so\nwe can recommend\nsome activities to you.")
                                .font(.title)
                                .bold()
                        }
                        Spacer()
                    }
                    Spacer()
                    VStack {
                        NavigationLink(destination: LoveLanguagePrompt(onboardingStep: .constant(onboardingStep + 1), user: currentUser)) {
                            OnboardingNextButton()
                        }.padding(.bottom, 35)
                        NavigationLink(destination: IntroLoveLanguagePrompt(onboardingStep: .constant(onboardingStep + 2))) {
                            Text("Maybe Later")
                                .foregroundColor(.black)
                                .font(.subheadline)
                                .underline()
                        }
                    }
                }.padding(.bottom, 50)
            }
            .padding()
            .navigationBarHidden(true)
        }
    }
}

struct IntroLoveLanguagePrompt_Previews: PreviewProvider {
    static var previews: some View {
        IntroLoveLanguagePrompt(onboardingStep: .constant(3))
    }
}
