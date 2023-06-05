//
//  loginViewModel.swift
//  DeltaOil
//
//  Created by Mac on 23/01/2023.
//

import Foundation
import Combine
class loginViewModel : ObservableObject {
    
    @Published var mobileNumberTextField : String = ""
    @Published var passwordTextField : String = ""
    var cancellable = Set<AnyCancellable>()
    
    @Published var loginValidate: loginValidation = loginValidation(mobileError: false, passwordError: false, mobileErrorText: "", passwordErrorText: "",buttonEnabled: false)
    
    
    init(){
        
    }
    
    func validateMobileInput(){
        $mobileNumberTextField
            .debounce(for: .seconds(0.3), scheduler: RunLoop.main)
            .sink(receiveValue: { [weak self] (field) in
                if field.count == 11 {
                    self?.loginValidate.mobileError = false
                    self?.loginValidate.mobileErrorText = ""
                }else{
                    self?.loginValidate.mobileError = true
                    self?.loginValidate.mobileErrorText = "رقم الجوال يجب ان يكون ١١ رقم "
                }
                self?.enableButton()
            })
            .store(in: &cancellable)
    }
    
    func validatePasswordInput(){
        $passwordTextField
            .debounce(for: .seconds(0.3), scheduler: RunLoop.main)
            .sink(receiveValue: { [weak self] (field) in
                if field.count >= 6 {
                    self?.loginValidate.passwordError = false
                    self?.loginValidate.passwordErrorText = ""

                }else{
                    self?.loginValidate.passwordError = true
                    self?.loginValidate.passwordErrorText = "كلمة المرور يجب ان تكون اكثر من ٦ احرف"
                }
                self?.enableButton()

            })
            .store(in: &cancellable)
    }
    func enableButton(){
        if self.loginValidate.passwordError == true || self.loginValidate.mobileError == true {
            self.loginValidate.buttonEnabled = false
        }else{
            self.loginValidate.buttonEnabled = true
        }
        
    }
    
    
    
    
}
