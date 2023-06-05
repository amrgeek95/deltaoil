//
//  newRequestModel.swift
//  DeltaOil
//
//  Created by Mac on 29/01/2023.
//

import Foundation

struct newRequestModel:Codable {
    var oil_amount :String
    var packages:[requestPackage]
    var notes : String
}
struct requestPackage:Codable, Hashable {
    let id :String
    let size:Int
    var quantiy:Int
}

