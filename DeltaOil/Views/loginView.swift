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
    
    
    var body: some View {
        VStack {
            topHeaderView()
            Spacer()
            VStack{
                inputView
                Spacer()
            }
            .padding(.horizontal,20)
            VStack {
                Button(action: {
                    
                }, label: {
                    ZStack{
                        
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color("greenColor"), lineWidth: 1)
                        Text("Sign up ? ")
                            .foregroundColor(Color("greenColor"))
                            .font(.title3)
                            .fontWeight(.medium)
                        
                    }
                })
                .frame(width: .infinity, height: 50, alignment: .top)
                Button(action: {
                    let userdata = User(context: moc)
                    
                }, label: {
                    ZStack{
                        
                        Text("تسجيل الدخول ")
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
                    
                    // .background(Color.red)
                    
                    
                })
                .opacity(loginVM.loginValidate.buttonEnabled ? 1 : 0.5)
                .disabled(!loginVM.loginValidate.buttonEnabled)
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
                    Image("headerWithLogo")
                        .resizable()
                        .scaledToFill()
                        .frame(width: .infinity, height: containerHeight, alignment: .top)
                        .clipped()
                    Image("Logo")
                        .scaleEffect(0.8)
                }.frame( idealWidth: .infinity, maxWidth: .infinity, idealHeight: containerHeight, maxHeight: containerHeight, alignment: .top)
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
    }
}
extension loginView {
    var inputView : some View {
        
        Section{
            VStack(alignment: .trailing,spacing: 10){
                labelDefaultView(labelTitle: "Mobile Number")
                TextField(text: $loginVM.mobileNumberTextField,
                          label: {
                    Text(loginVM.loginValidate.mobileErrorText)
                    //   Text("dasdas")
                }).onChange(of: loginVM.mobileNumberTextField){ _ in
                    loginVM.validateMobileInput()
                }
                .textContentType(.telephoneNumber)
                .keyboardType(.phonePad)
                .padding()
                .background(Color("textBackgroundGrayColor"))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(loginVM.loginValidate.mobileError ? Color.red : Color("greenColor"), lineWidth: 0.5)
                )
                .multilineTextAlignment(.trailing)
                
                errorMessageLabel(labelTitle: loginVM.loginValidate.mobileErrorText)
                //error message for mobile number
                //Password
                labelDefaultView(labelTitle: "Password")
                
                SecureField(text: $loginVM.passwordTextField, label: {
                    Text(loginVM.loginValidate.passwordErrorText)
                    //   Text("dasdas")
                }).onChange(of: loginVM.passwordTextField, perform: { _ in
                    loginVM.validatePasswordInput()
                })
                .textContentType(.telephoneNumber)
                .keyboardType(.phonePad)
                .padding()
                .background(Color("textBackgroundGrayColor"))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(loginVM.loginValidate.passwordError ? Color.red : Color("greenColor"), lineWidth: 0.5)
                )
                .multilineTextAlignment(.trailing)
                errorMessageLabel(labelTitle: loginVM.loginValidate.passwordErrorText)

            }
            
            
            
        }header: {
            HStack(alignment:.top){
                Spacer()
                Text("Login")
                    .font(.title)
                    .foregroundColor(Color("greenColor"))
                    .fontWeight(.medium)
            }
            .padding()
        }   
    }
}
