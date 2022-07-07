//
//  IntroLoveLanguagePrompt.swift
//  Hover
//
//  Created by Eddo Careera Iriyanto Putra on 29/06/22.
//

import SwiftUI

struct IntroLoveLanguagePrompt: View {
    //    @Binding var onboardingStep: Int
    @EnvironmentObject var globalObject: GlobalObject
    @State private var skip: Bool = false
    @State private var isGoNext: Bool = false
    let userSentence = "Next,\nWe need to know\nyour Love Language so\nwe can recommend\nsome activities to you."
    let partnerSentence = "Next,\nWe need to know your partner Love Language so we can recommend some activities to you.\n\nPlease pass the phone to your partner."
    
    var onboardingStep: Int = 3
    
    var progress: Int {
        onboardingStep + 1
    }
    
    var currentUser: User {
        onboardingStep == 3 ? globalObject.user : globalObject.partner
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
                            Text("\(onboardingStep == 3 ? userSentence : partnerSentence)")
                                .font(.title)
                                .bold()
                        }
                        Spacer()
                    }
                    Spacer()
                    VStack {
                        NavigationLink(isActive: $isGoNext) {
                            LoveLanguagePrompt(user: currentUser, onboardingStep: onboardingStep + 1)
                        } label: {
                            
                        }
                        Button {
//                            globalObject.onboardingStep += 1
                            isGoNext.toggle()
                        } label: {
                            OnboardingNextButton()
                        }.padding(.bottom, 35)
                        NavigationLink(isActive: $skip) {
                            IntroLoveLanguagePrompt(onboardingStep: self.onboardingStep + 3)
                        } label: {
                        }
                        
                        Button {
                            if onboardingStep == 3 {
//                                globalObject.onboardingStep += 3
                                skip.toggle()
                            } else {
                                UserDefaults.standard.set(true, forKey: "isDoneOnboarding")
                            }
                        } label: {
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
        IntroLoveLanguagePrompt()
            .environmentObject(GlobalObject.shared)
    }
}
