//
//  AppModels.swift
//  DeltaOil
//
//  Created by Mac on 31/01/2023.
//

import Foundation
import Combine
struct responseCityModel:Codable {
    let cities:[CitiesModel]
    let status:Bool
}
struct responseAreaModel:Codable {
    let areas:[AreasModel]?
    let status:Bool?
}
struct CitiesModel:Codable,Hashable,Identifiable {
    var id:String
    var name:String
}
struct AreasModel:Codable,Hashable,Identifiable {
    var id:String?
    var name:String?
    var city_id:String?
}


