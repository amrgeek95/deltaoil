//
//  validation.swift
//  DeltaOil
//
//  Created by Mac on 30/01/2023.
//

import Foundation
import Combine
func validate (inputText:String)->String {
    let filtered = inputText.filter{"0123456789".contains($0) }
    
    if filtered != inputText {
        return filtered
    }else{
        return inputText
    }
}
