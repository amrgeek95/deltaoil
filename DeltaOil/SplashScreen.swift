//
//  SplashScreen.swift
//  DeltaOil
//
//  Created by Mac on 16/01/2023.
//

import SwiftUI
import Combine
class splashViewModel:ObservableObject {
    func checkReview(){
        let Network = NetworkLayer()
        guard let urlComponent = NSURLComponents(string: EndPoint.checkReview) else {
            return
        }
            
            
            
            var urlRequest = URLRequest(url: urlComponent.url!)
            urlRequest.httpMethod = "GET"
            
            Network.saveData(type: responseSave.self, urlRequest: urlRequest) { [weak self] result in
                guard let self = self else { return  }
                switch result {
                case .success(let response):
                    checkReviewStatus = true
                    print(response)
                case.failure(let error):
                    checkReviewStatus = false
                }
            }
            
            
            
        
    
        
        
    }
}
struct SplashScreen: View {
    @State private var isActive = false
    @State private var opacity = 0.5
    @State private var size = 0.7
    @EnvironmentObject var userSession : userSetting
    let splashVM = splashViewModel()
    var body: some View {
        if isActive {
            if userSession.isLogged == true{
                tabView()
            }else{
                loginView()
            }
        }else{
            ZStack {
                Color(.white)
                Image("logowhite")
                    .aspectRatio(contentMode: .fit)
                    .scaleEffect(size)
                    .frame(width: 300)
            }.ignoresSafeArea()
                .opacity(opacity)
                .onAppear{
                    splashVM.checkReview()
                    withAnimation(.easeIn(duration: 1.2)){
                        self.opacity = 1.0
                        self.size = 1.5
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
