//
//  moreView.swift
//  DeltaOil
//
//  Created by Amr Sobhy on 06/06/2023.
//

import SwiftUI
import Combine


struct moreView: View {
    @EnvironmentObject var userObject:userSetting

    @State private var profilePresented = false
    @State private var contactPresented = false
    @State private var privacyPresented = false
    @State private var packagePresented = false

    
    var body: some View {
            VStack {
                customNavBar(title: "المزيد",backBtnHidden: true)
                    .frame(minHeight: 130.0,maxHeight: 130.0)
                VStack{
                     Text("اهلا" + "\((userObject.userInfo?.name) ?? "")")
                        .modifier(titleLabelFont())
                    Text(userObject.userInfo?.mobile ?? "")
                        .modifier(subLabelCustomFont())
                    VStack {
                        profileBtn
                            .modifier(moreItemModifier())
                        packageBtn
                            .modifier(moreItemModifier())
                        contactUsBtn
                            .modifier(moreItemModifier())
                        privacyBtn
                            .modifier(moreItemModifier())
                        logoutBtn
                    }
                    .frame(maxWidth: .infinity, maxHeight: 380)
                    .background(appColors.textBGGrayColor)
                    .cornerRadius(10)
                    Spacer()
                }
                .padding(.horizontal,20.0)
                Spacer()
            }
        
        .ignoresSafeArea()
        
    }
}
extension moreView {
    var profileBtn : some View {
        Button(action: {profilePresented = true}) {
            HStack(alignment: .center) {
                Image("UserHomePage")
                    .scaledToFit()
                // .padding(.trailing,10)
                Text("الملف الشخصي")
                    .modifier(buttonCustomFont())

                    .font(.headline)
                    .foregroundColor(.black)
                Spacer()
            }
        }
        .sheet(isPresented: $profilePresented) {
            editProfileView()
        }

    }
    var packageBtn : some View {
        Button(action: {packagePresented = true}) {

            HStack(alignment: .center) {
                Image("packageTint")
                    .renderingMode(.template)
                    .foregroundColor(appColors.greenColor)
                
                    .scaledToFit()
                    .padding(.leading,10)
                Text("الباكدجات")
                    .modifier(buttonCustomFont())

                    .font(.headline)
                    .foregroundColor(.black)
                
                Spacer()
            }
        }
        .sheet(isPresented: $packagePresented) {
            packageListView()
        }

    }
    var contactUsBtn : some View {
        Button(action: {contactPresented = true}) {
            HStack(alignment: .center) {
                Image(systemName: "message")
                    .renderingMode(.template)
                    .foregroundColor(appColors.greenColor)
                    .padding(.leading,10)
                Text("شاركنا تجربتك")
                    .modifier(buttonCustomFont())

                    .font(.headline)
                    .foregroundColor(.black)
                
                Spacer()
            }
        }
        .sheet(isPresented: $contactPresented) {
            contactUsView()
        }

    }
    var privacyBtn : some View {
       
        Link(destination: URL(string: "http://www.deltaoileg.com/")!) {
            HStack(alignment: .center) {
                Image(systemName: "list.bullet.clipboard")
                    .renderingMode(.template)
                    .foregroundColor(appColors.greenColor)
                    .padding(.leading,10)
                Text("سياسة الخصوصية والاستخدام")
                    .modifier(buttonCustomFont())
                    .font(.headline)
                    .foregroundColor(.black)
                
                Spacer()
            }
        }

    }
    var logoutBtn : some View {
        Button(action: {
            profilePresented.toggle()
        }, label: {
            HStack(alignment: .center) {
                Text(checkReviewStatus ? "حذف الحساب": "تسجيل خروج" )
                    .modifier(buttonCustomFont())

                    .font(.headline)
                    .foregroundColor(.red)
            }
        })
        .frame(height: 50)
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .top)
        .foregroundColor(.gray)
        .clipped()
        .clipped()
        .background(
            RoundedRectangle(
                
                cornerRadius: 10,
                style: .continuous
            )
            .fill(.white)
        )
        .overlay {
            
            RoundedRectangle(
                cornerRadius: 10,
                style: .continuous
            )
            .stroke(.red, lineWidth: 1)
        }
        .padding(.horizontal,10)
        
    }
}

struct moreView_Previews: PreviewProvider {
    static var previews: some View {
        moreView()
            .environmentObject(userSetting())

    }
}
