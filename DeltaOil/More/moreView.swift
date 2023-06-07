//
//  moreView.swift
//  DeltaOil
//
//  Created by Amr Sobhy on 06/06/2023.
//

import SwiftUI
import Combine

class moreViewModel: ObservableObject {
    
}
struct moreView: View {
    @EnvironmentObject var userObject:userSetting

    let moreVM = moreViewModel()
    var body: some View {
        VStack {
            customNavBar(title: "المزيد",backBtnHidden: true)
                .frame(minHeight: 130.0,maxHeight: 130.0)
            VStack{
                
                
                Text("اهلا" + "\((userObject.userInfo?.name))")
                Text(userObject.userInfo?.mobile ?? "")
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
        Spacer()
        
    }
}
extension moreView {
    var profileBtn : some View {
        Button(action: {
            
        }, label: {
            HStack(alignment: .center) {
                Image("UserHomePage")
                    .scaledToFit()
                // .padding(.trailing,10)
                Text("إرسال")
                    .font(.headline)
                    .foregroundColor(.black)
                Spacer()
            }
        })
    }
    var packageBtn : some View {
        Button(action: {
            
        }, label: {
            HStack(alignment: .center) {
                Image("packageTint")
                    .renderingMode(.template)
                    .foregroundColor(appColors.greenColor)
                
                    .scaledToFit()
                    .padding(.leading,10)
                Text("الباكدجات")
                    .font(.headline)
                    .foregroundColor(.black)
                
                Spacer()
            }
        })
    }
    var contactUsBtn : some View {
        Button(action: {
            
        }, label: {
            HStack(alignment: .center) {
                Image(systemName: "message")
                    .renderingMode(.template)
                    .foregroundColor(appColors.greenColor)
                    .padding(.leading,10)
                Text("شاركنا تجربتك")
                    .font(.headline)
                    .foregroundColor(.black)
                
                Spacer()
            }
        })
    }
    var privacyBtn : some View {
        Button(action: {
            
        }, label: {
            HStack(alignment: .center) {
                Image(systemName: "list.bullet.clipboard")
                    .renderingMode(.template)
                    .foregroundColor(appColors.greenColor)
                    .padding(.leading,10)
                Text("سياسة الخصوصية والاستخدام")
                    .font(.headline)
                    .foregroundColor(.black)
                
                Spacer()
            }
        })
    }
    var logoutBtn : some View {
        Button(action: {
            
        }, label: {
            HStack(alignment: .center) {
                Text("تسحيل خروج")
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
struct moreItemModifier : ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(height: 55)
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .top)
            .foregroundColor(.gray)
            .background(.white)
            .clipped()
            .cornerRadius(10)
            .padding(.horizontal,10)
            .padding(.vertical,5)
        
    }
}
struct moreView_Previews: PreviewProvider {
    static var previews: some View {
        moreView()
            .environmentObject(userSetting())

    }
}
