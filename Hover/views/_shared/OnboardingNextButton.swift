//
//  OnboardingNextButton.swift
//  Hover
//
//  Created by Eddo Careera Iriyanto Putra on 28/06/22.
//

import SwiftUI

struct OnboardingNextButton: View {
    var isDisabled: Bool = false
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 90, height: 90)
                .foregroundColor(isDisabled ? Color.disabledButtonColor : Color.activeButtonColor)
            Image(systemName: "chevron.right")
                .font(.title)
                .padding(10)
                .frame(width: 37, height: 37)
                .foregroundColor(isDisabled ? Color.disabledButtonColor : Color.activeButtonColor)
                .background(Color.white)
                .clipShape(Circle())
        }
    }
}

struct OnboardingNextButton_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingNextButton()
    }
}
