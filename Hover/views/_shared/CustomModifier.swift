//
//  CustomModifier.swift
//  Hover
//
//  Created by Eddo Careera Iriyanto Putra on 29/06/22.
//

import Foundation
import SwiftUI

struct ClearButton: ViewModifier
{
    @Binding var text: String

    public func body(content: Content) -> some View
    {
        ZStack(alignment: .trailing)
        {
            content

            if !text.isEmpty
            {
                Button(action:
                {
                    self.text = ""
                })
                {
                    Image(systemName: "xmark.circle")
                        .foregroundColor(Color(UIColor.opaqueSeparator))
                }
                .padding(.trailing, 8)
            }
        }
    }
}

struct GrayButtonStyle: MenuStyle {
    var width: CGFloat = 130
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8).fill(Color.bgButton).frame(width: width, height: 38)
            Menu(configuration)
        }
    }
}
