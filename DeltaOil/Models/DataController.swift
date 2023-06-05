//
//  DataController.swift
//  DeltaOil
//
//  Created by Mac on 30/01/2023.
//

import Foundation
import CoreData

class DataController:ObservableObject {
    let container = NSPersistentContainer(name: "DeltaOil")
    init (){
        container.loadPersistentStores { description, error in
            guard let error = error else {
                print("Core data not initalized \(error?.localizedDescription)")
                return
            }
            
            
        }
    }
}
