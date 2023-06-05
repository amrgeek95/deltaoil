//
//  contactUsView.swift
//  DeltaOil
//
//  Created by Mac on 25/01/2023.
//

import SwiftUI

struct contactFormValidation {
    var mobileErrorText : String = ""
    var nameErrorText : String = ""
    var emailErrorText : String = ""
    var messageErrorText : String = ""
    var mobileError : Bool = false
    var nameError : Bool = false
    var emailError : Bool = false
    var messageError : Bool = false
    
}

class contactViewModel :ObservableObject {
    @Published var contactFormValidate = contactFormValidation()
    @Published var nameTextField:String = ""
    @Published var mobileTextField:String = ""
    @Published var emailTextField:String = ""
    @Published var messageTextField:String = ""
    
    
    
}
struct contactUsView: View {
    @StateObject var contactVM = contactViewModel()
    var body: some View {
        VStack{
            customNavBar(title: "خدمة العملاء")
                .frame(minHeight: 130.0,maxHeight: 130.0)
            VStack{
                Image("customer-support-executive")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: UIScreen.main.bounds.size.width / 2.0)
                inputSection
                Button(action: {
                    
                }, label: {
                    Text("إرسال")
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .top)
                    .padding()
                    .foregroundColor(Color.white)
                    .background(Color("greenColor"))
                    
                    
                    .cornerRadius(10)

                })
                Spacer()
            }
            .padding(.horizontal,20.0)
            Spacer()
        }
        Spacer()
    }
}

private extension contactUsView {
    var inputSection : some View {
        Section{
            VStack(alignment: .trailing,spacing: 10){
                
                labelDefaultView(labelTitle: " الاسم")
                TextField(text: $contactVM.nameTextField,
                          label: {
                    Text("الاسم")
                })
                .textContentType(.givenName)
                .keyboardType(.namePhonePad)
                .padding()
                .background(Color("textBackgroundGrayColor"))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("greenColor"), lineWidth: 0.5)
                )
                
                // Mobile
                labelDefaultView(labelTitle: " رقم الموبايل")
                TextField(text: $contactVM.mobileTextField,
                          label: {
                    Text("0123456789")
                })
                .textContentType(.telephoneNumber)
                .keyboardType(.asciiCapableNumberPad)
                .padding()
                .background(Color("textBackgroundGrayColor"))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("greenColor"), lineWidth: 0.5)
                )
                
                // Mobile
                labelDefaultView(labelTitle: " البريد الالكتروني ")
                TextField(text: $contactVM.emailTextField,
                          label: {
                    Text("برجاء كتابة بريدك الالتروني بشكل صحيح")
                })
                .textContentType(.emailAddress)
                .keyboardType(.emailAddress)
                .padding()
                .background(Color("textBackgroundGrayColor"))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("greenColor"), lineWidth: 0.5)
                )
                // Mobile
                labelDefaultView(labelTitle: " الرسالة ")
                if #available(iOS 16.0, *) {
                    TextField("", text: $contactVM.messageTextField, axis: .vertical)
                        .textContentType(.telephoneNumber)
                        .keyboardType(.asciiCapableNumberPad)
                        .padding()
                        .background(Color("textBackgroundGrayColor"))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("greenColor"), lineWidth: 0.5)
                        )
                } else {
                    TextField("", text: $contactVM.messageTextField)
                        .lineLimit(10)
                        .textContentType(.telephoneNumber)
                        .keyboardType(.asciiCapableNumberPad)
                        .padding()
                        .background(Color("textBackgroundGrayColor"))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("greenColor"), lineWidth: 0.5)
                        )
                }
            }
            
            
            
        }
        .multilineTextAlignment(.trailing)
    }
}
struct contactUsView_Previews: PreviewProvider {
    static var previews: some View {
        contactUsView()
    }
}
