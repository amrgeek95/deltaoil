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

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
