//
//  loginViewModel.swift
//  DeltaOil
//
//  Created by Mac on 23/01/2023.
//

import Foundation
import Combine
import SwiftUI

class loginViewModel : ObservableObject {
    
    @AppStorage("userData") var userData = Data()
     var userSession :userSetting!

    @Published var showHome:Bool = false

    @Published var mobileTextField : String = ""
    @Published var passwordTextField : String = ""
    @Published var inlineErrors = (password:"",mobile:"")

    var cancellable = Set<AnyCancellable>()
    
    @Published var loginValidate: loginValidation = loginValidation(mobileError: false, passwordError: false, mobileErrorText: "", passwordErrorText: "",buttonEnabled: false)
    
    @Published var isFormValid:Bool = false

    init(){
        allInputValid
            .assign(to: \.isFormValid, on: self)
            .store(in: &cancellable)

    }
    
    
    var mobileValid:AnyPublisher<inputValidationError,Never>{
        $mobileTextField
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .removeDuplicates()
        
            .map{
                if $0.count == 11 {
                    self.inlineErrors.mobile = ""
                    
                    return  inputValidationError.valid
                }else{
                    self.inlineErrors.mobile = ($0.isEmpty) ? "" :inputValidationError.mobile.errorDescription
                    
                    return   inputValidationError.mobile
                }
            }
            .eraseToAnyPublisher()
    }
    var passwordValid:AnyPublisher<inputValidationError,Never>{
        $passwordTextField
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map{
                if $0.count > 5 {
                    self.inlineErrors.password = ""
                    return  inputValidationError.valid
                }else{
                    self.inlineErrors.password = ($0.isEmpty) ? "" : inputValidationError.password.errorDescription
                    return   inputValidationError.password
                }
            }
            .eraseToAnyPublisher()
    }
    
    private var allInputValid :AnyPublisher<Bool,Never>{
        let validate1 =  Publishers.CombineLatest( mobileValid, passwordValid)
            .map{  mobile  , password in
                if mobile.inputStatus == true &&  password.inputStatus == true {
                    return true
                }
                return false
            }
            .eraseToAnyPublisher()
        return validate1
        
       
        
        
    }
    
    func enableButton(){
        if self.loginValidate.passwordError == true || self.loginValidate.mobileError == true {
            self.loginValidate.buttonEnabled = false
        }else{
            self.loginValidate.buttonEnabled = true
        }
        
    }
    @Published var hasError :Bool = false
    @Published var error: SignupError?

    func loginAction(){
        
        if !isFormValid {
            self.hasError = true
            self.error = SignupError.customMessage(error: "برجاء ادخال البيانات اولا")
            return
        }
        guard let urlComponent = NSURLComponents(string: EndPoint.loginUrl) else {
            return
        }
        urlComponent.queryItems = [
            URLQueryItem(name: "mobile", value: mobileTextField),
            URLQueryItem(name: "password", value: passwordTextField),
        ]
        let _ = print(urlComponent.queryItems)
        
        var urlRequest = URLRequest(url: urlComponent.url!)
        urlRequest.httpMethod = "GET"
        URLSession.shared
            .dataTaskPublisher(for: urlRequest)
            .receive(on: DispatchQueue.main)
            .map(\.data)
            .decode(type: signupresponse.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] status in
                switch status {
                case .failure(let error):
                    self?.hasError = true
                    self?.error = SignupError.custom(error: error)
                default:break
                }
                
            }){ [weak self] data  in
                if data.status ==  true {
                    do {
                        self?.userSession.isLogged = true
                        self?.userSession.userInfo = data.data
                        self?.showHome.toggle()
                    }
                    catch{
                        
                    }
                }else{
                    self?.hasError = true
                    self?.error = SignupError.customMessage(error: data.message ?? "")
                }
            }
            .store(in: &cancellable)
        
        
    }
    
    
    
    
}
