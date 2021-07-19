//
//  Settings.swift
//  TodoAppSwiftUI3
//
//  Created by Roman Luzgin on 12.07.21.
//

import SwiftUI

struct Settings: View {
    
    @FocusState private var userNameIsFocused: Bool
    @Environment(\.dismiss) private var dismiss
    @AppStorage("userName") var username = ""
    
    var body: some View {
        
        NavigationView {
            Form {
                TextField("Username", text: $username)
                    .focused($userNameIsFocused)
                    .submitLabel(.done)
            }
            .navigationBarItems(trailing: Button("Done") {
                dismiss()
            }
            .accentColor(.indigo))
            .onSubmit {
                userNameIsFocused = false
                dismiss() // we can use dismiss on submit if needed, especially if there is only one settings field
            }
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
