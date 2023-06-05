//
//  orderModel.swift
//  DeltaOil
//
//  Created by Mac on 12/02/2023.
//

import Foundation

struct orderResponseModel:Codable,Hashable {
    let data:[orderDetailModel]
    let status:Bool
}
struct orderDetailModel:Codable,Hashable {
        var name,deliveryID ,areaID,areaName,cityID,cityName :String?
        var id, customerID: String
        var notes, address: String
            var oilAmount, status,statusMessage, datePurshased, created: String
        var package: [orderPackageModel]?

    enum CodingKeys: String, CodingKey {
        case id, name
        case customerID = "customer_id"
        case deliveryID = "delivery_id"
        case notes, address
        case cityID = "city_id"
        case areaID = "area_id"
        case areaName = "area_name"
        case cityName = "city_name"
        case oilAmount = "oil_amount"
        case status
        case statusMessage = "status_message"
        case datePurshased = "date_purshased"
        case created, package
    }
    init(id: String = "", name: String? = "", customerID: String = "", deliveryID: String = "", notes: String = "", address: String = "", cityID: String = "",
         cityName: String = "", areaID: String = "", areaName: String = "", oilAmount: String = "",
         status: String = "", statusMessage: String = "", datePurshased: String = "", created: String = "", package: [orderPackageModel] = []) {
        
        self.id = id
        self.name = name
        self.customerID = customerID
        self.deliveryID = deliveryID
        self.notes = notes
        self.address = address
        self.cityID = cityID
        self.cityName = cityName
        self.areaID = areaID
        self.areaName = areaName
        self.oilAmount = oilAmount
        self.status = status
        self.statusMessage = statusMessage
        self.datePurshased = datePurshased
        self.created = created
        self.package = package
    }
    
}

struct orderPackageModel :Codable , Hashable{
    
    var id:String
    var name:String
    var package_size:String
    var description:String
    var quantity:String

}
