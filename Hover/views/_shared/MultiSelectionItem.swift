//
//  MultiSelectionItem.swift
//  Hover
//
//  Created by Eddo Careera Iriyanto Putra on 29/06/22.
//

import SwiftUI

struct MultiSelectionItem: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct MultiSelectionItem_Previews: PreviewProvider {
    static var previews: some View {
        MultiSelectionItem()
    }
}
