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
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    
    private var items: FetchedResults<Item>
    
    @State private var searchQuery: String = ""
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(searchResults, id: \.self) { item in
                        HStack {
                            
                            if item.isDone {
                                
                                Image(systemName: "checkmark.seal.fill")
                                    .resizable()
                                    .foregroundColor(.green)
                                    .frame(width: 30, height: 30)
                                    .onTapGesture {
                                        isDone(item: item)
                                    }
                                
                            } else {
                                Image(systemName: "circle")
                                    .resizable()
                                    .foregroundColor(.red)
                                    .frame(width: 30, height: 30)
                                    .onTapGesture {
                                        isDone(item: item)
                                    }
                            }
                            
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
                        
                        }
                        .frame(height: 80)
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
            return items.filter {
                !$0.toDoText!.isEmpty
            }
        } else {
            // getting only searched items
            return items.filter {
                $0.toDoText!.lowercased().contains(searchQuery.lowercased())
            }
        }
    }
    
    
    
    private func isDone(item: Item) {
        withAnimation{
            item.isDone.toggle()
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoList().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
