//
//  homeView.swift
//  DeltaOil
//
//  Created by Mac on 16/01/2023.
//

import SwiftUI

struct homeView: View {
    @EnvironmentObject var userObject:userSetting
    @State private var showSignUp = false
    @State private var showNewOrder = false
    var body: some View {
        NavigationView{
            VStack(spacing:0.0) {
                ZStack {
                    
                    customNavBar(title: "الرئيسية", backBtnHidden: true, subBtnHidden: false)
                    VStack {
                        if userObject.userInfo != nil {
                            homeSliderView(title: " جاهز تبدل الزيت ؟ يا  \(userObject.userInfo?.name ?? "") ")
                        }else{
                            homeSliderView(title: "")

                        }
                        VStack(spacing:30) {
                                Button{
                                    showNewOrder.toggle()
                                } label: {
                                    homeItemView(title: "طلب جديد", mainIcon: "NewOrderHomepage", leftIcon: "newOrderLight", itemColor: "lightPurbleBox")
                                }.fullScreenCover(isPresented: $showNewOrder) {
                                    newRequestView() 
                                }
                                Button{
                                    if userObject.userInfo != nil {
                                        showSignUp.toggle()
                                    }else{
                                            SignUpView()
                                    }
                                } label: {
                                    if userObject.userInfo != nil {
                                        homeItemView(title: "نقاطي", mainIcon: "UserHomePage", leftIcon: "profileLight", itemColor: "lightGreenBox")
                                    }else{
                                        homeItemView(title: "تسجيل حساب جديد", mainIcon: "UserHomePage", leftIcon: "profileLight", itemColor: "lightGreenBox")

                                    }
                                }.fullScreenCover(isPresented: $showSignUp) {
                                    SignUpView()
                                }
                            }
                    }

                    
                    

                    
                }
                
                
             //   Spacer()
            }
            .navigationBarHidden(true)
            .edgesIgnoringSafeArea(.all)

        }
        
    }

}
struct RoundedCornersShape: Shape {
    let corners: UIRectCorner
    let radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct homeSliderView: View {
    var containerHeight = UIScreen.main.bounds.size.height * 0.22
    var title:String
    var body: some View {
        ZStack {
            Image("Slider")
                .resizable()
                .clipped()
                .cornerRadius(10)
            HStack{
                Image("Man")
                    .aspectRatio(contentMode: .fit)
                    .padding(.trailing,10.0)
                    .padding(.leading,0)
                    .frame(alignment: .bottom)
                
                Spacer()
                VStack {
                    Spacer()
                    Text(title)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.trailing)
                        .padding(.bottom, 10.0)
                    
                    Text ("استبدل الزيت المستعمل بمواد عينية")
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.trailing)
                }
                .padding([.bottom, .trailing], 10.0)
                .frame( maxHeight: containerHeight)
                
                .clipped()

            }
        }
        .padding(.horizontal,10.0)
        .padding(.bottom,10.0)
        .frame(width: UIScreen.main.bounds.size.width , height: containerHeight)
    }
}

struct homeItemView: View {
    var containerHeight = UIScreen.main.bounds.size.height * 0.17
     var title : String
     var mainIcon : String
     var leftIcon : String
     var itemColor : String
     var body: some View {
         ZStack {
             Rectangle()
             .fill(Color(itemColor))
             .cornerRadius(20.0)
             .padding(.horizontal,10)
             VStack(alignment: .leading){
                 Image(mainIcon)
                     .frame( alignment: .trailing)
                     .padding(.bottom,10)
                 HStack{
                     Text(title)
                         .foregroundColor(Color.primary)
                     Spacer()
                     Image(leftIcon)
                         
                 }
             }
             .padding(.horizontal,30)

         }
         .frame(maxWidth: .infinity, idealHeight: containerHeight,maxHeight:containerHeight)



    }
}

struct homeView_Previews: PreviewProvider {
    static var previews: some View {
        homeView()
            .ignoresSafeArea()
            .environmentObject(userSetting())
    }
}
