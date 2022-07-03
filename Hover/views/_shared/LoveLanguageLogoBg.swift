//
//  LoveLanguageLogoBg.swift
//  Hover
//
//  Created by Eddo Careera Iriyanto Putra on 29/06/22.
//

import SwiftUI

struct LoveLanguageLogoBg: View {
    var loveLanguageName: String = "Physical Touch"
    var size: CGFloat = 120
    var cornerRadius: CGFloat = 5
    
    var body: some View {
        getLoveLanguageIcon(loveLanguage: loveLanguageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding(size > 100 ? 25 : 8)
            .frame(width: size, height: size)
            .foregroundColor(getLoveLanguageColor(loveLanguage: loveLanguageName))
            .background(getLoveLanguageBackgroundColor(loveLanguage: loveLanguageName))
            .cornerRadius(cornerRadius)
    }
}

struct LoveLanguageLogoBg_Previews: PreviewProvider {
    static var previews: some View {
        LoveLanguageLogoBg(size: 30, cornerRadius: 90)
    }
}
