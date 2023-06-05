//
//  newRequestViewModel.swift
//  DeltaOil
//
//  Created by Mac on 29/01/2023.
//

import Foundation
import Combine
import SwiftUI

class newRequestViewModel:ObservableObject {
    @Published var newRequestObject = newRequestModel(oil_amount: "3", packages: [], notes: "")
    @Published var errorMessages = requestErrorMessages(oilAmountError: "", notesError: "", packageError: "")
    @Published var oilError = ""
    @Published var maxOilCount = 0
    @Published var currentOilCount = 0
    @Published var loadingChecker = false
    @Published var showAlert = false
    @Published var alertErrorMessage = ""
    @Published var packageobject :packageEnviromentObject!
    var userSession :userSetting!

    func setup(package:packageEnviromentObject, session: userSetting) {
        self.packageobject = package
         self.userSession = session

         if let oilamount = Int(newRequestObject.oil_amount)  {
             self.maxOilCount = oilamount
         }
     }
    
    func validateOilInput(newvalue:String){

        let filtered = newvalue.filter{"0123456789".contains($0) }
        
        if filtered != newvalue {
            newRequestObject.oil_amount = filtered
        }
        guard let oilamount = Int(newvalue) else {
        return
        }
        packageobject.currentPackages.removeAll()

        if oilamount < 3 {
            maxOilCount = 0
            currentOilCount = 0
            errorMessages.oilAmountError = "لا يمكن اختيار اقل من ٣ كيلو زيت"
            return
        }else{
            errorMessages.oilAmountError = ""
            maxOilCount = oilamount
        }
    }
    func submitAction(){
        guard let oilamount = Int(newRequestObject.oil_amount) else {
            return
        }
        if oilamount < 3 {
            errorMessages.oilAmountError = "لا يمكن اختيار اقل من ٣ كيلو زيت"
            return
        }
        print("final setting \(packageobject.currentPackages)")
        
        var total_size = 0
        for item in packageobject.currentPackages {
            total_size += (item.quantiy * item.size)
        }
        if total_size != oilamount {
            errorMessages.packageError = "برجاء التأكد من ان كمية الزيت الخاصه بك مساويه لعدد الباكجدات المطلوبة"
            return
        }
        saveData()

    }
    func saveData(){
        let Network = NetworkLayer()
        guard let urlComponent = NSURLComponents(string: orderEndPoint.newRequest) else {
            return
        }
        if let user = userSession.userInfo {
            
            urlComponent.queryItems = [
                URLQueryItem(name: "customer_id", value: user.id),
                URLQueryItem(name: "address", value: user.address),
                URLQueryItem(name: "longitude", value: user.longitude),
                URLQueryItem(name: "latitude", value: user.latitude),
                URLQueryItem(name: "oil_amount", value: newRequestObject.oil_amount),
                
                URLQueryItem(name: "notes", value: newRequestObject.notes),
                URLQueryItem(name: "city_id", value: user.city_id),
                URLQueryItem(name: "area_id", value: user.area_id)
            ]
            
            for (index , (pck)) in packageobject.currentPackages.enumerated() {
                urlComponent.queryItems?.append(URLQueryItem(name: "packages[\(index)]", value: pck.id))
                urlComponent.queryItems?.append(URLQueryItem(name: "quantity[\(index)]", value: "\(pck.quantiy)"))
            }
            
            var urlRequest = URLRequest(url: urlComponent.url!)
            urlRequest.httpMethod = "GET"
            loadingChecker = true
            
            Network.saveData(type: responseSave.self, urlRequest: urlRequest) { [weak self] result in
                guard let self = self else { return  }
                switch result {
                case .success(let response):
                    print(response)
                    self.loadingChecker = false
                    self.showAlert = true
                    self.alertErrorMessage = response
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
            
            
            
        }
    
        
        
    }
}
