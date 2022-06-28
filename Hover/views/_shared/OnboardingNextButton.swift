//
//  OnboardingNextButton.swift
//  Hover
//
//  Created by Eddo Careera Iriyanto Putra on 28/06/22.
//

import SwiftUI

struct OnboardingNextButton: View {
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 90, height: 90)
                .foregroundColor(Color("PrimaryColor"))
            Image(systemName: "chevron.right")
                .font(.title)
//                .resizable()
//                .aspectRatio(contentMode: .fit)
                .padding(10)
                .frame(width: 37, height: 37)
                .foregroundColor(Color("PrimaryColor"))
                .background(Color.black)
                .clipShape(Circle())
        }
    }
}

struct OnboardingNextButton_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingNextButton()
    }
}
