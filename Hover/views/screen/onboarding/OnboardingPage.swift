//
//  OnboardingPage.swift
//  Hover
//
//  Created by Eddo Careera Iriyanto Putra on 24/06/22.
//

import SwiftUI

struct OnboardingPage: View {
    @State private var onboardingStep: Int = 0
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Image("BackgroundImage")
                        .resizable()
                        .frame(height: screenHeight / 2)
                    VStack(spacing: 20) {
                        VStack {
                            Text("Dat LOVE")
                                .font(.title)
                                .bold()
                        }
                        HStack(spacing: 20) {
                            LoveLanguageLogoBg(loveLanguageName: LoveLanguage.combination.rawValue)
                            LoveLanguageLogoBg(loveLanguageName: LoveLanguage.actOfService.rawValue)
                            LoveLanguageLogoBg(loveLanguageName: LoveLanguage.physicalTouch.rawValue)
                        }.offset(x: -50)
                        HStack(spacing: 20) {
                            LoveLanguageLogoBg(loveLanguageName: LoveLanguage.receivingGift.rawValue)
                            LoveLanguageLogoBg(loveLanguageName: LoveLanguage.qualityTime.rawValue)
                            LoveLanguageLogoBg(loveLanguageName: LoveLanguage.wordsOfAffirmation.rawValue)
                        }.offset(x: 50)
                    }
                }
                VStack {
                    Text("Giving Recommendation")
                        .font(.title)
                        .bold()
                        .padding(.bottom, 2)
                    Text("Help partner strenghthen their romance relationship through know the Love Language and get recommendation to plan their date")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                    Spacer()
                    NavigationLink(destination: NamePrompt(onboardingStep: $onboardingStep)) {
                        OnboardingNextButton()
                    }
                    Spacer().frame(height: 150)
                }.background(
                    getLoveLanguageIcon(loveLanguage: LoveLanguage.combination.rawValue)
                        .font(Font.system(size: 521))
                        .foregroundColor(getLoveLanguageColor(loveLanguage: LoveLanguage.combination.rawValue).opacity(0.1))
                        .offset(x: 130, y: 50)
                        .rotationEffect(Angle(degrees: 334))
                )
            }
            .background(Color.backgroundColor).ignoresSafeArea()
            .navigationBarHidden(true)
        }
    }
}

struct OnboardingPage_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingPage()
    }
}
