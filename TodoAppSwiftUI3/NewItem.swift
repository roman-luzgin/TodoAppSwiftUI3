//
//  NewItem.swift
//  TodoAppSwiftUI3
//
//  Created by Roman Luzgin on 28.06.21.
//

import SwiftUI
import Combine

struct NewItem: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var category = "Business"
    @State private var dueDate = Date()
    @State private var toDoText = ""
    
    @Binding var newItemOpen: Bool
    
    let toDoTextLimit = 70
    
    var body: some View {
        Form {
            Section("Category") {
                Picker(selection: $category,
                       label:
                        Text("\(category)")
                        .foregroundColor(.black)
                        .animation(.none)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        //.frame(height: 50)
                        .background(Color.white)
                ) {
                    ForEach(categories, id: \.self) {
                        Text($0.category)
                            .tag($0.category)
                        
                    }
                }
                .pickerStyle(MenuPickerStyle())
                
            }
            
            Section("Due date") {
                DatePicker("Due date", selection: $dueDate, displayedComponents: .date)
                    .accentColor(Color.indigo)
            }
            
            Section("Text") {
                ZStack(alignment: .leading) {
                    if toDoText.isEmpty {
                        VStack {
                            Text("Enter your todo item")
                                .font(Font.body)
                                .foregroundColor(Color.gray.opacity(0.6))
                            Spacer()
                        }
                        .padding(.vertical,8)
                        .padding(.horizontal, 4)
                    }
                    
                    TextEditor(text: $toDoText)
                        .frame(height: 200, alignment: .leading)
                        .onReceive(Just(toDoText)) { toDoText in
                            textChanged(upper: toDoTextLimit, text: &self.toDoText)
                    }
                }
            }
            
            Button(role: .none, action: {
                ViewContextMethods.addItem(context: viewContext, dueDate: dueDate, toDoText: toDoText, category: category)
                newItemOpen = false
            }, label: {
                HStack {
                    Text("New task ")
                    Image(systemName: "circle")
                }
                .frame(maxWidth: .infinity)
            })
            .buttonStyle(BorderedButtonStyle(shape: .roundedRectangle))
            .tint(.indigo)
            .controlProminence(.increased)
            .controlSize(.large)
            
        }
    }
    
    func textChanged(upper: Int, text: inout String) {
        if text.count > upper {
            text = String(text.prefix(upper))
        }
    }
    
}

struct NewItem_Previews: PreviewProvider {
    static var previews: some View {
        NewItem(newItemOpen: .constant(false))
    }
}
