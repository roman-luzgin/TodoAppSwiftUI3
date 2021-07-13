//
//  ContentView.swift
//  TodoAppSwiftUI3
//
//  Created by Roman Luzgin on 21.06.21.
//

import SwiftUI
import CoreData

struct ToDoList: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.dueDate, ascending: false)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    @State private var searchQuery: String = ""
    @State private var notDoneOnly = false
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    HStack {
                        
                        Toggle(isOn: $notDoneOnly) {
                            Text(notDoneOnly ? "Show all items" : "Show not done only")
                                .frame(maxWidth: .infinity)
                        }
                        .toggleStyle(.button)
                        .tint(.indigo)
                        .clipShape(Capsule())
                        .animation(.easeInOut, value: notDoneOnly)
                    
                    }
                        
                }
                Section {
                    ForEach(searchResults, id: \.self) { item in
                        HStack {
                            
                            Image(systemName: item.isDone ? "circle.fill" : "circle")
                                .resizable()
                                .foregroundColor(getCategoryColor(toDoItem: item))
                                .frame(width: 30, height: 30)
                                .onTapGesture {
                                    withAnimation {
                                        ViewContextMethods.isDone(item: item, context: viewContext)
                                    }
                                }
                                
                                .padding(.trailing, 10)
                            
                            VStack {
                                HStack {
                                    Text("\(item.toDoText ?? "")")
                                        .fixedSize(horizontal: false, vertical: true)
                                    Spacer()
                                }
                                .padding(.bottom, 5)
                                
                                HStack{
                                    Text("Due: \(item.dueDate!, formatter: itemFormatter)")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                    Spacer()
                                    Text(item.category ?? "Unknown")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }
                            .padding(.leading, 5)
                        
                        }
                        .frame(maxHeight: 130)
                        .listRowSeparator(.hidden)
                    }
                    .onDelete(perform: deleteItems)
                }
            }
            .listStyle(InsetGroupedListStyle())
            .refreshable {
                //await store.loadStats()
                print("refreshed")
            }
            .searchable("Search in history", text: $searchQuery, placement: .automatic)
            .navigationTitle("All todo items")
            
        }
    }
    
    var searchResults: [Item] {
        if searchQuery.isEmpty{
            // getting all items
            switch notDoneOnly {
            case true:
                return items.filter {
                    !$0.toDoText!.isEmpty && $0.isDone == false
                }
            default:
                return items.filter {
                    !$0.toDoText!.isEmpty
                }
            }
            
        } else {
            // getting only searched items
            switch notDoneOnly {
            case true:
                return items.filter {
                    $0.toDoText!.lowercased().contains(searchQuery.lowercased()) && $0.isDone == false
                }
            default:
                return items.filter {
                    $0.toDoText!.lowercased().contains(searchQuery.lowercased())
                }
            }
            
        }
    }
    
    private func getCategoryColor(toDoItem: Item) -> Color {
        var category: [ItemCategory] {
            categories.filter {
                $0.category == toDoItem.category
            }
        }
        return category[0].color
    }
    
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    //formatter.timeStyle = .medium
    return formatter
}()

struct ToDoList_Previews: PreviewProvider {
    static var previews: some View {
        ToDoList().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
