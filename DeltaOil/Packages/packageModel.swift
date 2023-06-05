//
//  packageModel.swift
//  DeltaOil
//
//  Created by Mac on 28/01/2023.
//

import Foundation
struct responseData :Codable {
    let data:[packageModel]
}
struct packageModel : Codable {
    let id : String
    let name : String
    let description : String
    let image : String
    let size : String
    private enum CodingKeys : String, CodingKey {
        case id , name,description,image
        case size = "package_size"
    }

}
