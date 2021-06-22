//
//  MainScreen.swift
//  TodoAppSwiftUI3
//
//  Created by Roman Luzgin on 22.06.21.
//

import SwiftUI
import CoreData

struct MainScreen: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    private var todaysItems: [Item] {
        items.filter {
            Calendar.current.isDate($0.dueDate ?? Date(), equalTo: Date(), toGranularity: .day)
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 20) {
                    ForEach(categories) {category in
                        CategoryCards(category: category.category,
                                      color: category.color,
                                      numberOfTasks: 40,
                                      tasksDone: 20)
                            
                    }
                    
                }
                .padding(.leading, 20)
            }
            .frame(height: 300)
            
            LazyVStack {
                ForEach(todaysItems) {
                    Text("\($0.toDoText ?? "")")
                }
            }
            
        }
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
