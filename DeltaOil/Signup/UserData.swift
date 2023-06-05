//
//  UserData.swift
//  DeltaOil
//
//  Created by Mac on 03/02/2023.
//

import Foundation
import SwiftUI



class userSetting:ObservableObject {
    @AppStorage("userData") var userData = Data()
    @Published var isLogged:Bool = false {
        didSet {
            @AppStorage("isLogged") var logged = isLogged
        }
    }
    @Published var userInfo:UserModel? {
        didSet {
            @AppStorage("userData") var appUserData = Data()
            if let appData = try? JSONEncoder().encode(userInfo) {
                userData = appData
            }
        }
        
    }
    
    init() {
        print("hello")
        if let decodeData = try? JSONDecoder().decode(UserModel.self, from: userData) {
            print(decodeData)
            self.isLogged = true
            self.userInfo = decodeData
        }
        else{
            self.isLogged = false
        }
    }
    func saveSession(data:Data){
        
    }
    func getSaveObject(){
        
    }
    
}
