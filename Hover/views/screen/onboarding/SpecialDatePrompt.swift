//
//  SpecialDatePrompt.swift
//  Hover
//
//  Created by Eddo Careera Iriyanto Putra on 24/06/22.
//

import SwiftUI

struct SpecialDatePrompt: View {
    @Environment(\.managedObjectContext) var moc
    @Binding var onboardingStep: Int
    @State var specialDateName: String = ""
    @State var date: Date = Date()
    @State var isNavigateActive: Bool = false
    
    var disabledForm: Bool {
        specialDateName.isEmpty
    }
    
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()
            VStack {
                Spacer()
                HStack {
                    Text("Tell me about\nyour special date\nwith your partner")
                        .font(.title)
                    .bold()
                    Spacer()
                }
                Spacer(minLength: 3)
                TextField("Special Date", text: $specialDateName)
                    .padding()
                    .frame(height: 44)
                    .background(.white)
                    .cornerRadius(5)
                    .shadow(color: .black, radius: 1)
                DatePicker(
                    selection: $date,
                    in: ...Date.now,
                    displayedComponents: [.date]
                ) {
                    Text("Date")
                }
                .padding()
                .frame(height: 44)
                .background(.white)
                .cornerRadius(5)
                .shadow(color: .black, radius: 1)
                Text("Insert special date, such as wedding anniversary, partner’s birhtday, valentine’s day, etc")
                    .font(.subheadline)
                    .foregroundColor(Color("CaptionColor"))
                Spacer()
                Button {
                    saveSpecialDate()
                    isNavigateActive.toggle()
                } label: {
                    OnboardingNextButton()
                }.disabled(disabledForm)
                NavigationLink(isActive: $isNavigateActive) {
                    LoveLanguagePrompt(onboardingStep: .constant(onboardingStep + 1))
                } label: {
                }
                Spacer()
            }.padding()
        }
    }
    
    func saveSpecialDate() {
        let specialDate = SpecialDate(context: moc)
        specialDate.id = UUID()
        specialDate.name = specialDateName
        specialDate.date = date
        
        try? moc.save()
    }
}

struct SpecialDatePrompt_Previews: PreviewProvider {
    static var previews: some View {
        SpecialDatePrompt(onboardingStep: .constant(2))
    }
}
