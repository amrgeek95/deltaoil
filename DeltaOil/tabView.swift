//
//  tabView.swift
//  DeltaOil
//
//  Created by Mac on 16/01/2023.
//

import SwiftUI

struct tabView: View {
    @State var tabSelection: Int = 1

    var body: some View {
        TabView (selection: $tabSelection){
            homeView()
                .tabItem{
                    Image("home")
                    Text("الرئيسية")
                        //.font(font)
                }.tag(1)
            orderView()
                .tabItem{
                    Image("requests")
                    Text("الطلبات")
                }.tag(2)
                        moreView()
                .tabItem{
                    Image("more")
                    Text("المزيد")
                }.tag(3)
        }
        .shadow(color: .black, radius: 10, x: 0, y: 1)
        .tint(Color("tabGreenColor"))
        .accentColor(Color("tabGreenColor"))
        .ignoresSafeArea()
    }
}

struct tabView_Previews: PreviewProvider {
    static var previews: some View {
        tabView(tabSelection: 0)
    }
}
