//
//  SplashScreen.swift
//  DeltaOil
//
//  Created by Mac on 16/01/2023.
//

import SwiftUI

struct SplashScreen: View {
    @State private var isActive = false
    @State private var opacity = 0.5
    @State private var size = 0.7
    @EnvironmentObject var userSession : userSetting
    
    var body: some View {
        if isActive {
            if userSession.isLogged == true{
                tabView()
            }else{
                loginView()
            }
        }else{
            ZStack {
                Color("greenColor")
                Image("Logo")
                    .aspectRatio(contentMode: .fill)
                    .scaleEffect(size)
            }.ignoresSafeArea()
                .opacity(opacity)
                .onAppear{
                    withAnimation(.easeIn(duration: 1.2)){
                        self.opacity = 1.0
                        self.size = 1.0
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.9) {
                        self.isActive = true
                    }
                }

        }
            }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
            .environmentObject(userSetting())
    }
}
