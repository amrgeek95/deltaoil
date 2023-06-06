//
//  sliderModel.swift
//  DeltaOil
//
//  Created by Mac on 06/06/2023.
//

import Foundation
struct sliderResponseModel :Codable {
    let data:[sliderModel]
}
struct sliderModel : Codable {
    let image : String
}
