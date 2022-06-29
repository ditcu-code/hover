//
//  QuestionLoveLanguage.swift
//  Hover
//
//  Created by Eddo Careera Iriyanto Putra on 24/06/22.
//

import SwiftUI

struct QuestionLoveLanguage: View {
    @State private var questionLabel: String = "It's more meaningful to me when ..."
    @State private var option1Label: String = "Opsi 1"
    @State private var option2Label: String = "Opsi 2"
    @State private var counter: Int = 0
    @State private var chosenOptions: [String:Int] = ["A": 0, "B": 0, "C": 0, "D": 0, "E": 0]
    @State private var isTestDone: Bool = false
        
    var loveLanguageQuestion = LoveLanguageQuestion()
    
    var body: some View {
        VStack {
            Text("\(counter + 1) / 30")
                .font(.title2)
                .bold()
            Spacer()
            Text(questionLabel)
                .font(.title)
                .frame(width: screenSize * 0.9, height: 200)
                .background(.red)
                .cornerRadius(15)
                .padding()
            Button {
                processChoice(chosenOption: loveLanguageQuestion.options[counter].valueOption1)
                updateUI()
            } label: {
                Text(option1Label)
                    .padding()
                    .frame(width: screenSize * 0.9, height: 100)
                    .background(.black)
                    .cornerRadius(15)
            }
            Button {
                processChoice(chosenOption: loveLanguageQuestion.options[counter].valueOption2)
                updateUI()
            } label: {
                Text(option2Label)
                    .padding()
                    .frame(width: screenSize * 0.9, height: 100)
                    .background(.black)
                    .cornerRadius(15)
            }
            Spacer()
        }
        .onAppear {
            updateUI()
        }
        .background(
            NavigationLink("", isActive: $isTestDone) {
                TestResultPage(result: chosenOptions)
            }
        )
//        .navigationBarHidden(true)
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func processChoice(chosenOption: String) {
        chosenOptions[chosenOption] = (chosenOptions[chosenOption] ?? 0) + 1
        if counter+1 < loveLanguageQuestion.options.count {
            counter += 1
        } else {
            isTestDone.toggle()
        }
    }
    
    func updateUI() {
        option1Label = loveLanguageQuestion.options[counter].labelOption1
        option2Label = loveLanguageQuestion.options[counter].labelOption2
    }
}

struct QuestionLoveLanguage_Previews: PreviewProvider {
    static var previews: some View {
        QuestionLoveLanguage()
    }
}
