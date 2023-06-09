//
//  contactUsView.swift
//  DeltaOil
//
//  Created by Mac on 25/01/2023.
//

import SwiftUI
import Combine
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
    @Published var messageTextField:String = ""
    var userSession :userSetting!
    @Published var showAlert = false
    @Published var loadingChecker = false
    @Published var loadingMessage = "إرسال"
    @Published var errorMessage = ""

    func setup( session: userSetting) {
         self.userSession = session
        self.nameTextField = self.userSession.userInfo?.name ?? ""
        self.mobileTextField = self.userSession.userInfo?.mobile ?? "" 
     }
    
    func saveData(){
        let Network = NetworkLayer()
        guard let urlComponent = NSURLComponents(string: EndPoint.send_feedback) else {
            return
        }
        if messageTextField.isEmpty {
            errorMessage = "برجاء كتابة محتوي الرسالة"
         return
        }
        if nameTextField.isEmpty {
            errorMessage = "برجاء كتابة الاسم"
            return
        }
        if mobileTextField.count < 10 {
            errorMessage = "برجاء كتابة رقم الجوال"
            return
        }
        loadingChecker = true
        loadingMessage = "برجاء الانتظار"

        if let user = userSession.userInfo {
            
            urlComponent.queryItems = [
                URLQueryItem(name: "user_id", value: user.id),
                URLQueryItem(name: "message", value: messageTextField),
                URLQueryItem(name: "name", value: nameTextField),
                URLQueryItem(name: "mobile", value: mobileTextField),
            ]
            var urlRequest = URLRequest(url: urlComponent.url!)
            urlRequest.httpMethod = "GET"
            
            Network.saveData(type: responseSave.self, urlRequest: urlRequest) { [weak self] result in
                self?.loadingChecker = false
                self?.loadingMessage = "إرسال"

                guard let self = self else { return  }
                switch result {
                case .success(let response):
                    
                    print(response)
                    self.showAlert = true
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
            
            
            
        }
    
        
        
    }
    
    
}
struct contactUsView: View {
    @StateObject var contactVM = contactViewModel()
    @EnvironmentObject var userObject:userSetting
@State var showMorePage = false
    var body: some View {
        VStack{
            customNavBar(title: "شاركنا تجربتك")
                .frame(minHeight: 130.0,maxHeight: 130.0)
            VStack{
                Image("customer-support-executive")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: UIScreen.main.bounds.size.width / 2.0)
                Text(contactVM.errorMessage)
                    .modifier(subLabelCustomFont())
                    .foregroundColor(.red)
                    .padding(.vertical,20)
                inputSection
                Button(action: {
                    contactVM.saveData()
                }, label: {
                    Text(contactVM.loadingMessage)
                        .modifier(buttonCustomFont())
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .top)
                    .padding()
                    .foregroundColor(Color.white)
                    .background(Color("greenColor"))
                    .cornerRadius(10)

                })
                .disabled(contactVM.loadingChecker)
                Spacer()
            }
            .padding(.horizontal,20.0)
            Spacer()
        }
        .alert("تم استقابل رسالتك بنجاح", isPresented: $contactVM.showAlert, actions: {
            Button(action: {
                showMorePage = true
            }, label: {
                Text("حسنا")
            })
            
        })
        .fullScreenCover(isPresented: $showMorePage) {
            tabView(tabSelection: 3)
        }
        .onAppear{
            contactVM.setup(session: userObject)

        }
        .onTapGesture {
                  self.hideKeyboard()
                }
        
        Spacer()
    }
}

private extension contactUsView {
    var inputSection : some View {
        Section{
            VStack(alignment: .trailing,spacing: 10){
                inputGenerator(input: $contactVM.nameTextField,
                               placeHolder: " الاسم",
                               isSecure: false,
                               label: "الاسم",
                               contentType: .givenName,keyBoardType: .namePhonePad
                               ,prompt: "")
                
                // Mobile
                inputGenerator(input: $contactVM.mobileTextField,
                               placeHolder: "الموبايل",
                               isSecure: false,
                               label: " رقم الموبايل",
                               contentType: .telephoneNumber,keyBoardType: .asciiCapableNumberPad
                               ,prompt: "")
                // message
                inputGenerator(input: $contactVM.messageTextField,
                               placeHolder: " اكتب رسالتك هنا",
                               isSecure: false,
                               label: "الاسم",
                               contentType: .addressCity,keyBoardType: .default
                               ,prompt: "")
                
            }
            
            
            
        }
        .multilineTextAlignment(.trailing)
    }
}
struct contactUsView_Previews: PreviewProvider {
    static var previews: some View {
        contactUsView()
            .environmentObject(userSetting())

    }
}
