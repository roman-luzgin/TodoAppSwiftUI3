//
//  TodoAppSwiftUI3App.swift
//  TodoAppSwiftUI3
//
//  Created by Roman Luzgin on 21.06.21.
//

import SwiftUI

@main
struct TodoAppSwiftUI3App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                
        }
    }
}
