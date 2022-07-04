//
//  Checklist.swift
//  Hover
//
//  Created by Eddo Careera Iriyanto Putra on 29/06/22.
//

import SwiftUI

struct Checklist: View {
    var size: CGFloat = 37
    
    var body: some View {
        Image(systemName: "checkmark")
            .font(.body)
//            .aspectRatio(contentMode: .fit)
            .padding(2)
            .frame(width: size, height: size)
            .foregroundColor(Color.white)
            .background(Color.activeButtonColor)
            .clipShape(Circle())
    }
}

struct Checklist_Previews: PreviewProvider {
    static var previews: some View {
        Checklist()
    }
}
