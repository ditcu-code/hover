//
//  IntroLoveLanguagePrompt.swift
//  Hover
//
//  Created by Eddo Careera Iriyanto Putra on 29/06/22.
//

import SwiftUI

struct IntroLoveLanguagePrompt: View {
    @Binding var onboardingStep: Int
    @State private var skip: Bool = false
    let userSentence = "Next,\nWe need to know\nyour Love Language so\nwe can recommend\nsome activities to you."
    let partnerSentence = "Next,\nWe need to know your partner Love Language so we can recommend some activities to you.\n\nPlease pass the phone to your partner."
    
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
                            Text("\(onboardingStep == 3 ? userSentence : partnerSentence)")
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
                        NavigationLink(isActive: $skip) {
                            IntroLoveLanguagePrompt(onboardingStep: .constant(onboardingStep + 3))
                        } label: {
                        }
                        
                        Button {
                            if onboardingStep == 3 {
                                skip.toggle()
                            } else {
                                print("masuk pak eko")
                                UserDefaults.standard.set(false, forKey: "isNewUser")
                                print(UserDefaults.standard.bool(forKey: "isNewUser"))
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
        IntroLoveLanguagePrompt(onboardingStep: .constant(3))
    }
}
