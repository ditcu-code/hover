//
//  SpecialDateList.swift
//  Hover
//
//  Created by Eddo Careera Iriyanto Putra on 24/06/22.
//

import SwiftUI

struct SpecialDatePage: View {
    @State var navActive : Bool = false
    var body: some View {
        NavigationView{
            List{
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add Special Day"){
                        navActive.toggle()
                    }
                }
            }
            .sheet(isPresented: $navActive){
                SpecialDateForm()
            }
        }
    }
}

struct SpecialDatePage_Previews: PreviewProvider {
    static var previews: some View {
        SpecialDatePage()
    }
}
