//
//  SignUpView.swift
//  DeltaOil
//
//  Created by Mac on 31/01/2023.
//

import SwiftUI
import Foundation
import Combine

struct SignUpView: View {
    @EnvironmentObject var session: userSetting

    @StateObject var signupVM = signupViewModel()
    
    var body: some View {
        NavigationView{
            ScrollView {
                topHeaderView()
                VStack(alignment:.trailing,spacing: 20){
                    Section {
                        nameTextInput
                        mobileNumberView
                        emailTextInput
                        addressTextInput
                        cityPickerInput
                        areaPickerInput
                        signUpBtn
                           .disabled(!signupVM.isFormValid)
                           .opacity(signupVM.isFormValid ? 1:0.5)
                            
                    } header: {
                        Text("تسجيل جديد")
                            .modifier(buttonCustomFont())

                    }
                }.padding(.horizontal,20)
                    .padding(.bottom,20)
                
                
            }
            
            .alert(signupVM.error?.errorDescription ?? "", isPresented: $signupVM.hasError) {
                Button("OK", role: .cancel) { }
            }
            .onAppear{
                signupVM.setUp(session: session)
                signupVM.getCities()
            }
            
            .ignoresSafeArea()
            .onTapGesture {
                      self.hideKeyboard()
                    }
        }
    }
}
extension SignUpView {
    var nameTextInput : some View {
        inputGenerator(input: $signupVM.nameTextField,
                       placeHolder: "برجاء كتابة الاسم", isSecure: false,
                       label: "الاسم",contentType: .name,keyBoardType: .default,
                       prompt: signupVM.inlineErrors.name)
        
    }
    var mobileNumberView : some View {
        inputGenerator(input: $signupVM.mobileTextField,
                       placeHolder: "الموبايل",
                       isSecure: false,
                       label: "الموبايل",
                       contentType: .telephoneNumber,keyBoardType: .asciiCapableNumberPad
                       ,prompt: signupVM.inlineErrors.mobile)
    }
    
    var emailTextInput : some View {
        inputGenerator(input: $signupVM.emailTextField, placeHolder: "برجاء كتابة البريد الالكتروني بشكل صحيح", isSecure: false, label: "البريد الالكتروني",contentType: .emailAddress,keyBoardType: .emailAddress,prompt: signupVM.inlineErrors.email)
        
    }
    
   
    var addressTextInput : some View {
        
        inputGenerator(input: $signupVM.addressTextField, placeHolder: "برجاء كتابة العنوان", isSecure: false, label: "العنوان",contentType: .fullStreetAddress,keyBoardType: .default,prompt: signupVM.inlineErrors.address)
        
    }
}
extension SignUpView {
    var cityPickerInput : some View {
        VStack(alignment:.trailing){
            labelDefaultView(labelTitle: signupVM.selectPlaceHolder.city)
                .frame(minWidth: 0,maxWidth: .infinity,alignment: .leading)

            Menu(signupVM.selectPlaceHolder.city) {
                Picker(selection: $signupVM.selectedCity, label: Text("")) {
                    ForEach(signupVM.cities, id: \.self) { city in
                                Text(city.name)
                           }
                       }.onChange(of: signupVM.selectedCity) { _ in
                    signupVM.selectPlaceHolder.city = signupVM.selectedCity.name
                           signupVM.getAreas()
                }
            }
            .frame(minWidth: 0,maxWidth: .infinity,alignment: .leading)
                .padding()
                .background(appColors.textBGGrayColor)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(appColors.greenColor, lineWidth: 0.5)
                )
                .foregroundColor(appColors.greenColor)
        
        }
    }
    var areaPickerInput : some View {
       
        VStack(alignment:.trailing){
            labelDefaultView(labelTitle: "برجاء اختيار المنطقة")
                .frame(minWidth: 0,maxWidth: .infinity,alignment: .leading)

            Menu(signupVM.selectPlaceHolder.area) {
                Picker(selection: $signupVM.selectedArea, label: Text("")) {
                    ForEach(signupVM.areas, id: \.self) { area in
                                Text(area.name ?? "" )
                           }
                       }.onChange(of: signupVM.selectedArea) { _ in
                           signupVM.selectPlaceHolder.area = signupVM.selectedArea.name ?? "amr"
                       }
            }
            .frame(minWidth: 0,maxWidth: .infinity,alignment: .leading)
                .padding()
                .background(appColors.textBGGrayColor)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(appColors.greenColor, lineWidth: 0.5)
                )
                .foregroundColor(appColors.greenColor)
        }
    }
}

extension SignUpView {
    var signUpBtn : some View{
        Button(action: {
            signupVM.signUp()
        }, label: {
            Text("تسجيل حساب")
                .modifier(buttonCustomFont())

            .frame(minWidth: 0, maxWidth: .infinity, alignment: .top)
            .padding()
            .foregroundColor(Color.white)
            .background(Color("greenColor"))
            
            
            .cornerRadius(10)

        }).fullScreenCover(isPresented: $signupVM.showHome) {
            tabView()
        }
    }
}
struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
            .environmentObject(userSetting())
    }
}
