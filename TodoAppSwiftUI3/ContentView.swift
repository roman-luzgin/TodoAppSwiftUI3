//
//  ContentView.swift
//  TodoAppSwiftUI3
//
//  Created by Roman Luzgin on 28.06.21.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        TabView {
            Menu()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            ToDoList()
                .tabItem {
                    Image(systemName: "list.bullet.circle.fill")
                    Text("Todos")
                }
        }
        .accentColor(Color.indigo)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
