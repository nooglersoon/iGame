//
//  PersistentManager.swift
//  iGame
//
//  Created by Fauzi Achmad B D on 16/08/23.
//

import Foundation
import CoreData

class PersistenceManager {
    
    // Shared initialization to implement singleton pattern
    static let shared = PersistenceManager()
    
    let container: NSPersistentContainer
    
    // Defined as private to prevent PersistenceManager initialization outside this class
    private init() {
        container = NSPersistentContainer(name: "TodoModel")
        container.loadPersistentStores { storeDescription, error in
            guard error == nil else {
                fatalError("Error occured: \(String(describing: error))")
            }
        }
        
        // Help merge the data automatically
        container.viewContext.automaticallyMergesChangesFromParent = true
        
    }
    
}
