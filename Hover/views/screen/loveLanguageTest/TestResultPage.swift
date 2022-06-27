//
//  TestResultPage.swift
//  Hover
//
//  Created by Eddo Careera Iriyanto Putra on 24/06/22.
//

import SwiftUI

struct TestResultPage: View {
    var result: [String: Int] = [:]
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Your Love Language is")
                        .font(.title)
                        .bold()
                    Text("sadsdasdas")
                        .font(.title)
                        .bold()
                        .foregroundColor(Color(getLoveLanguageColorName(code: "A")))
                }
                Spacer()
            }
            Spacer()
            ForEach(result.sorted(by: { first, second in
                return first.value > second.value
            }), id: \.key) { key, value in
                HStack {
                    Image(systemName: getLoveLanguageSymbolName(code: key))
                    Text("\(getLoveLanguageByCode(code: key))")
                    Spacer()
                    Text("\(calculate(value: value))")
                }
                .background(.white)
//                .frame(width: screenSize * 0.9)
                .foregroundColor(Color(getLoveLanguageColorName(code: key)))
                .cornerRadius(15)
//                .padding()
            }
            Text("Ini nanti penjelasan love languagenya")
                .font(.subheadline)
            Spacer()
        }
        .padding()
    }
    
    func calculate(value: Int) -> Int {
        var total = 0
        for option in result {
            total += option.value
        }
        
        return (value * 100 / total)
    }
}

struct TestResultPage_Previews: PreviewProvider {
    static var previews: some View {
        TestResultPage(result: ["A": 10])
    }
}
