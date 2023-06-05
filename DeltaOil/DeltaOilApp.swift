//
//  DeltaOilApp.swift
//  DeltaOil
//
//  Created by Mac on 16/01/2023.
//

import SwiftUI

@main
struct DeltaOilApp: App {
    let persistenceController = PersistenceController.shared

   @State private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            SplashScreen()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(userSetting())
                .environmentObject(packageEnviromentObject())
                .environmentObject(orderDetailEnviroment())
        }
    }
}
