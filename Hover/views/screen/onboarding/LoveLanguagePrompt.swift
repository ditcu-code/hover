//
//  LoveLanguagePrompt.swift
//  Hover
//
//  Created by Eddo Careera Iriyanto Putra on 24/06/22.
//

import SwiftUI

struct LoveLanguagePrompt: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \LoveLanguages.llName, ascending: true)]) var loveLanguages : FetchedResults <LoveLanguages>
    
    @Binding var onboardingStep: Int
    @State var isNavigationActive: Bool = false
    @State var isGotoTest: Bool = false
    @State var llselections: [LoveLanguages] = []
    
    var progress: Int {
        onboardingStep + 1
    }
    
    var disabledForm: Bool {
        llselections.isEmpty
    }
    
    var body: some View {
        VStack {
            VStack {
                ProgressView(value: (Float(progress) / Float(onboardingTotalStep)))
                    .animation(.easeInOut(duration: 1), value: onboardingTotalStep)
                    .padding(.bottom, 50)
                HStack {
                    Text("What is your\nLove Language? \(onboardingStep)")
                        .font(.title)
                        .bold()
                    Spacer()
                }
            }
            Spacer()
            ForEach(loveLanguages, id: \.self) { loveLanguage in
                LoveLanguageOption(title: loveLanguage.llName ?? "Unknown", isSelected: self.llselections.contains(loveLanguage)) {
                    if self.llselections.contains(loveLanguage) {
                        self.llselections.removeAll(where: { $0 == loveLanguage})
                    } else {
                        if self.llselections.count < 1 {
                            self.llselections.append(loveLanguage)
                        } else {
                            self.llselections.removeAll()
                            self.llselections.append(loveLanguage)
                        }
                    }
                }.padding(.bottom, 10)
            }
            Spacer().frame(height: 20)
            NavigationLink(isActive: $isNavigationActive) {
                LoveLanguagePrompt(onboardingStep: .constant(onboardingStep + 1))
            } label: {
            }
            VStack {
                Button {
                    if self.onboardingStep == 4 {
                        self.isNavigationActive.toggle()
                    } else {
                        withAnimation {
                            UserDefaults.standard.set(false, forKey: "isNewUser")
                        }
                    }
                } label: {
                    OnboardingNextButton()
                        .disabled(disabledForm)
                }.padding(.bottom, 35)
                Text("Don't know \(self.onboardingStep == 4 ? "your": "your partner") Love Language yet?")
                    .font(.subheadline)
                    .foregroundColor(Color("CaptionColor"))
                NavigationLink {
                    QuestionLoveLanguage()
                } label: {
                    Text("Take the test now")
                        .padding(.bottom, 60)
                }
            }
        }
        .padding(.horizontal)
        .background(Color.backgroundColor)
        .navigationBarHidden(true)
    }
    
    func saveLoveLanguage() {
        
    }
}

private struct LoveLanguageOption: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: self.action) {
            HStack {
                Text(self.title)
                Spacer()
                if self.isSelected {
                    Checklist(size: 25)
                }
            }
            .padding()
            .frame(height: 44)
            .background(.white)
            .cornerRadius(15)
            .shadow(color: .black, radius: 1)
        }
    }
}

struct LoveLanguagePrompt_Previews: PreviewProvider {
    static var previews: some View {
        LoveLanguagePrompt(onboardingStep: .constant(3))
    }
}
