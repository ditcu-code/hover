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
    @State var isGotoTest: Bool = false
    
    let loveLanguages = ["Words of Affirmation", "Receiving Gifts", "Physical Touch", "Act of Service", "Quality Time"]
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Text("What's \(onboardingStep == 3 ? "your": "your partner")\nLove Language?")
                    .font(.title)
                    .bold()
                Spacer()
            }
            HStack {
                Text("We need to know \(onboardingStep == 3 ? "your": "your partner") love language so we can recommend some activities to you.")
                    .font(.subheadline)
                    .foregroundColor(Color("CaptionColor"))
                Spacer()
            }
            NavigationLink(isActive: $isNavigationActive) {
                LoveLanguagePrompt(onboardingStep: .constant(onboardingStep + 1))
            } label: {
            }
            ForEach(loveLanguages, id: \.self) { loveLanguage in
                HStack {
                    Text(loveLanguage)
                    Spacer()
                }
                .padding()
                .frame(height: 44)
                .background(.white)
                .cornerRadius(5)
                .shadow(color: .black, radius: 1)
            }
            //            Spacer().frame(height: 30)
            Button {
                if self.onboardingStep == 3 {
                    self.isNavigationActive.toggle()
                } else {
                    withAnimation {
                        UserDefaults.standard.set(false, forKey: "isNewUser")
                    }
                }
            } label: {
                OnboardingNextButton()
            }
            Spacer()
                .frame(height: 20)
            Text("Don't know \(self.onboardingStep == 4 ? "your": "your partner") Love Language yet?")
                .font(.subheadline)
                .foregroundColor(Color("CaptionColor"))
            NavigationLink {
                QuestionLoveLanguage()
            } label: {
                Text("Take the test now")
            }
            Spacer().frame(height: 25)
        }
        .padding()
        //        .frame(height: UIScreen.main.bounds.height)
        .background(Color("BackgroundColor")).ignoresSafeArea()
    }
    
}

struct LoveLanguagePrompt_Previews: PreviewProvider {
    static var previews: some View {
        LoveLanguagePrompt(onboardingStep: .constant(3))
    }
}
