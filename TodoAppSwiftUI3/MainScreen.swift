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
    
    @State var searchOpen = false
    @State var notificationsOpen = false
    @State var menuOpen = false
    
    @AppStorage("userName") var userName = "username"
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    VStack {
                        HStack {
                            Text("Categories")
                                .font(.body.smallCaps())
                                .foregroundColor(.secondary)
                            Spacer()
                        }
                        .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 20) {
                                ForEach(categories) {category in
                                    CategoryCards(category: category.category,
                                                  color: category.color,
                                                  numberOfTasks: 40,
                                                  tasksDone: 20)
                                }
                                .padding(.bottom, 30)
                                
                            }
                            .padding(.leading, 20)
                        }
                        .frame(height: 190)
                    }
                    .padding(.top, 30)
                    
                    VStack {
                        HStack {
                            Text("Today's tasks")
                                .font(.body.smallCaps())
                                .foregroundColor(.secondary)
                            Spacer()
                        }
                        .padding(.horizontal)
                        
                        if todaysItems.count > 0 {
                            LazyVStack {
                                ForEach(todaysItems) {
                                    ToDoCard(toDoItem: $0)
                                }
                            }
                        } else {
                            VStack{
                                Text("No tasks for today")
                                    .foregroundColor(.secondary)
                            }
                            .frame(height: 200)
                        }
                    }
                }
                
                VStack{
                    Spacer()
                    
                    HStack{
                        Spacer()
                        
                        Button(action: {
                            
                            ViewContextMethods.addItem(
                                context: viewContext,
                                dueDate: Date(),
                                toDoText: "Do this",
                                category: "Business"
                            )
                            
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .frame(width: 70, height: 70)
                                .foregroundColor(.indigo)
                                .shadow(color: .indigo.opacity(0.3), radius: 10, x: 0, y: 10)
                                .padding()
                        }
                        
                    }
                }
                
                
            }
            .navigationTitle("What's up, \(userName)!")
            
            // Navigation bar buttons to open different menus
            .navigationBarItems(leading:
                                    Button(action: {
                                        menuOpen.toggle()
                                        Haptics.giveSmallHaptic()
                                    }) {
                                        Image(systemName: "rectangle.portrait.leftthird.inset.filled")
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                    ,
                                trailing: HStack {
                                    Button(action: {
                                        searchOpen.toggle()
                                        Haptics.giveSmallHaptic()
                                    }) {
                                        Image(systemName: "magnifyingglass")
                                    }
                                    .padding(.horizontal)
                                    .buttonStyle(PlainButtonStyle())
                                           
                                    Button(action: {
                                        notificationsOpen.toggle()
                                        Haptics.giveSmallHaptic()
                                    }) {
                                        Image(systemName: "bell")
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                               
            })
        }
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}

struct ToDoCard: View {
    
    var toDoItem: Item
    
    var body: some View {
        Text("\(toDoItem.toDoText ?? "")")
    }
}
