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
    
    var namespace: Namespace.ID
    
    @State private var category = "Business"
    @State private var dueDate = Date()
    @State private var toDoText = ""
    
    @Binding var newItemOpen: Bool
    
    let toDoTextLimit = 70
    
    var body: some View {
        
        ZStack {
            
            ScrollView {
                VStack {
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
                            .padding()
                            
                        
                        
                        
                        DatePicker("Due date", selection: $dueDate, displayedComponents: .date)
                            .accentColor(Color.indigo)
                            .padding()
                        
                        
                        
                            ZStack(alignment: .leading) {
                                
                                TextEditor(text: $toDoText)
                                    .frame(height: 200, alignment: .leading)
                                    .frame(maxWidth: .infinity)
                                    .lineSpacing(5)
                                    .onReceive(Just(toDoText)) { toDoText in
                                        textChanged(upper: toDoTextLimit, text: &self.toDoText)
                                    }
                                
                                
                                if toDoText.isEmpty {
                                    VStack(alignment: .leading) {
                                        Text("Enter your todo item")
                                            .font(Font.body)
                                            .foregroundColor(Color.gray.opacity(0.6))
                                        Spacer()
                                    }
                                    .padding(.vertical, 12)
                                    .padding(.horizontal, 4)
                                }
                                
                            }
                            .frame(height: 200, alignment: .leading)
                            .frame(maxWidth: .infinity)
                            
                            .padding()
                        
                        
                        Button(role: .none, action: {
                            ViewContextMethods.addItem(context: viewContext, dueDate: dueDate, toDoText: toDoText, category: category)
                            withAnimation {
                                newItemOpen = false
                            }
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
                        .padding()
                        
                }
                .padding(.top, 100)
            }
            
            VStack{
                HStack{
                    Spacer()
                    Button(action: {
                        withAnimation {
                            newItemOpen = false
                        }
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.indigo)
                            .shadow(color: .indigo.opacity(0.3), radius: 10, x: 0, y: 10)
                            .padding()
                    }
                }
                .matchedGeometryEffect(id: "button", in: namespace)
                
                Spacer()
            }
        }
        
    }
    
    func textChanged(upper: Int, text: inout String) {
        if text.count > upper {
            text = String(text.prefix(upper))
        }
    }
    
}

struct NewItem_Previews: PreviewProvider {
    
    @Namespace static var namespace
    
    static var previews: some View {
        NewItem(namespace: namespace,
                newItemOpen: .constant(false)
                )
    }
}
