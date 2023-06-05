//
//  Validation.swift
//  DeltaOil
//
//  Created by Mac on 23/01/2023.
//

import Foundation

struct loginValidation {
    var mobileError : Bool
    var passwordError : Bool
    var mobileErrorText : String
    var passwordErrorText : String
    var buttonEnabled:Bool
}
struct inputValidation {
    var mobileError : Bool
    var mobileErrorText : String

    var passwordError : Bool
    var passwordErrorText : String
    
}
struct responseSave:Codable {
    let message:String
    let status:Bool
}
