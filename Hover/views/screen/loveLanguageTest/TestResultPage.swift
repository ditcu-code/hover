//
//  TestResultPage.swift
//  Hover
//
//  Created by Eddo Careera Iriyanto Putra on 24/06/22.
//

import SwiftUI

struct TestResultPage: View {
    @Environment(\.managedObjectContext) var moc
    @Binding var onboardingStep: Int
    @State private var selectionPage: String? = nil
    
    var user: User
    var progress: Int {
        onboardingStep + 1
    }
    
    var loveLanguageUser: LoveLanguageUser {
        LoveLanguageUser(user: user)
    }
    
    var body: some View {
        ZStack {
            ZStack {
                Color.backgroundColor.ignoresSafeArea()
                getLoveLanguageIcon(loveLanguage: getPrimaryLoveLanguage())
                    .resizable()
                    .frame(width: 420, height: 420)
                    .foregroundColor(getLoveLanguageColor(loveLanguage: getPrimaryLoveLanguage()).opacity(0.1))
                    .offset(x: 70, y: 50)
            }
            VStack {
                VStack {
                    ProgressView(value: (Float(progress) / Float(onboardingTotalStep)))
                        .animation(.easeInOut(duration: 1), value: onboardingTotalStep)
                        .padding(.bottom, 160)
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Your Love Language is")
                                .font(.title)
                                .bold()
                            Text(getPrimaryLoveLanguage())
                                .foregroundColor(getLoveLanguageColor(loveLanguage: getPrimaryLoveLanguage()))
                                .font(.title)
                                .bold()
                        }
                        Spacer()
                    }
                    Spacer()
                    Text("People whose love language is physical touch enjoy when their partners express affection for them in physical ways, such as hugs, kisses, and even just a hand on the shoulder.")
                        .font(.headline)
                        .fontWeight(.semibold)
                    Spacer()
                    NavigationLink(destination: LoveLanguagePrompt(onboardingStep: .constant(onboardingStep + 1), user: GlobalObject.shared.partner), tag: "PartnerLoveLanguage", selection: $selectionPage) { }
                    NavigationLink(destination: HomeScreen(), tag: "HomePage", selection: $selectionPage) { }
                    Button {
                        if onboardingStep == 6 {
                            selectionPage = "PartnerLoveLanguage"
                        } else {
                            if UserDefaults.standard.bool(forKey: "isNewUser") {
                                UserDefaults.standard.set(false, forKey: "isNewUser")
                            } else {
                                selectionPage = "HomePage"
                            }
                        }
                    } label: {
                        Text(onboardingStep == 6 ? "Partner Love Language" : "Continue to Home Page")
                            .fontWeight(.semibold)
                            .frame(width: 300, height: 50)
                            .foregroundColor(.black)
                            .background(Color.yellowSun)
                            .cornerRadius(30)
                    }
                }.padding()
            }
            .padding()
            .navigationBarHidden(true)
        }
    }
    
    func getPrimaryLoveLanguage() -> String {
        return loveLanguageUser.getPrimaryLoveLanguage()
        // just for preview
//        return LoveLanguageEnum.wordsOfAffirmation.rawValue
    }
}

struct TestResultPage_Previews: PreviewProvider {
    static var previews: some View {
        TestResultPage(onboardingStep: .constant(6), user: GlobalObject.shared.user)
    }
}
