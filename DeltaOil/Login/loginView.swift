//
//  loginView.swift
//  DeltaOil
//
//  Created by Mac on 23/01/2023.
//

import SwiftUI
import Combine


struct loginView: View {
    @Environment(\.managedObjectContext) var moc
    @StateObject var loginVM : loginViewModel = loginViewModel()
    @State var passwordTextField : String = ""
    @EnvironmentObject var session: userSetting

    
    var body: some View {
        VStack(alignment: .trailing) {
            topHeaderView()
            Spacer()
            VStack{
                Text("تسجيل دخول")
                    .foregroundColor(Color("greenColor"))
                    .fontWeight(.medium)
                    .font(.custom("Tajawal-Regular", size: 20))
                    .multilineTextAlignment(.trailing)
                    .frame(minWidth: 0,maxWidth: .infinity,alignment: .leading)

                mobileNumberView
                
                passwordTextInput
                Spacer()
            }
            .padding(.horizontal,20)
            VStack {
                Button(action: {
                    loginVM.showHome = true
                }, label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color("greenColor"), lineWidth: 1)
                        Text("تسجيل حساب جديد")
                            .foregroundColor(Color("greenColor"))
                            .font(.title3)
                            .fontWeight(.medium)
                    }
                })
                .sheet(isPresented: $loginVM.showHome) {
                    SignUpView()
                }
                .frame(width: .infinity, height: 50, alignment: .top)
                Button(action: {

                    loginVM.loginAction()
                }, label: {
                    ZStack{
                        
                        Text("تسجيل دخول ")
                            .font(Font.custom("Tajawal-Regular", size: 20))
                            .foregroundColor(Color.white)
                            .font(.title3)
                            .fontWeight(.medium)
                            .clipped()
                            .padding()
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .top)
                    .background(Color("greenColor"))
                    
                    
                    .cornerRadius(10)
                    
                    
                    
                })
                .opacity(loginVM.isFormValid ? 1 : 0.5)
                .disabled(!loginVM.isFormValid)
            }
            .padding(.horizontal,20.0)
            .padding(.bottom,35.0)
            
        }.ignoresSafeArea()
        
    }
}
struct topHeaderView : View {
    
    let containerHeight = UIScreen.main.bounds.size.height * 0.25
    var body : some View {
        VStack{
            VStack{
                ZStack (alignment: .center){
                    
                    Image("Logo")
                        .scaleEffect(0.8)
                        .frame(width: .infinity, height: containerHeight, alignment: .center)

                }.frame( idealWidth: .infinity, maxWidth: .infinity, idealHeight: containerHeight, maxHeight: containerHeight, alignment: .top)
                    .background(appColors.greenColor)
                RoundedCornersShape(corners: [.topLeft, .topRight], radius: 100.0)
                    .fill(Color.white)
                    .frame(width: UIScreen.main.bounds.size.width, height: 50, alignment: .bottom)
                    .offset(y:-50)
                Spacer()
            }.frame( idealWidth: .infinity, maxWidth: .infinity, idealHeight: containerHeight, maxHeight: containerHeight, alignment: .top)
            
            
            
        }.ignoresSafeArea()
    }
}

struct loginView_Previews: PreviewProvider {
    static var previews: some View {
        loginView()
            .environmentObject(userSetting())

    }
}
extension loginView {
    var mobileNumberView : some View {
        inputGenerator(input: $loginVM.mobileTextField,
                       placeHolder: "رقم الجوال",
                       isSecure: false,
                       label: "رقم الجوال",
                       contentType: .telephoneNumber,keyBoardType: .asciiCapableNumberPad
                       ,prompt: loginVM.inlineErrors.mobile)
    }
    var passwordTextInput : some View {
      
        inputGenerator(input: $loginVM.passwordTextField, placeHolder: "برجاء كتابة رقم كلمة المرور", isSecure: true, label: "كلمة المرور",contentType: .password,keyBoardType: .default,prompt: loginVM.inlineErrors.password)
        
    }
    
    var inputView : some View {
        
        Section{
            VStack(alignment: .leading,spacing: 10){

                mobileNumberView
                passwordTextInput
            }
            
            
            
        }header: {
            HStack(alignment:.top){
                Spacer()
                Text("تسجيل دخول")
                    
                    .font(.title)
                    .font(Font.custom("Tajawal-Regular", size: 20))

                    .foregroundColor(Color("greenColor"))
                    .fontWeight(.medium)
            }
            .padding()
        }   
    }
}
