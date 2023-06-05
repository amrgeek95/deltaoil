//
//  SignUpModel.swift
//  DeltaOil
//
//  Created by Mac on 02/02/2023.
//

import Foundation
import Combine
struct signupresponse : Codable {
    let status:Bool
    let message:String?
    let data:UserModel?
}

struct UserModel :Codable{
    let id :String
    let name :String
    let email :String
    let mobile :String
    let address :String
    let city_id :String
    let area_id :String
    let longitude :String
    let latitude :String
    let image :String
    let status :String
    let token :String
    let cityname :String
    let areaname :String
    
}
