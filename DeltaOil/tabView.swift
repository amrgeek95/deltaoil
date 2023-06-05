//
//  tabView.swift
//  DeltaOil
//
//  Created by Mac on 16/01/2023.
//

import SwiftUI

struct tabView: View {
    var body: some View {
        TabView {
            homeView()
                .tabItem{
                    Image("home")
                    Text("الرئيسية")
                        //.font(font)
                }
            orderView()
                .tabItem{
                    Image("requests")
                    Text("الطلبات")
                }
        }
        .shadow(color: .black, radius: 10, x: 0, y: 1)
        .tint(Color("tabGreenColor"))
        .accentColor(Color("tabGreenColor"))
        .ignoresSafeArea()
    }
}

struct tabView_Previews: PreviewProvider {
    static var previews: some View {
        tabView()
    }
}
