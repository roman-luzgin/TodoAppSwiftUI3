//
//  ViewContextMethods.swift
//  TodoAppSwiftUI3
//
//  Created by Roman Luzgin on 22.06.21.
//

import Foundation
import CoreData
import SwiftUI

struct contextMethods {

    static func addItem(context: NSManagedObjectContext) {
        withAnimation {
            let newItem = Item(context: context)
            newItem.timestamp = Date()
            
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
}
