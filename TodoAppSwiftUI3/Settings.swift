//
//  Settings.swift
//  TodoAppSwiftUI3
//
//  Created by Roman Luzgin on 12.07.21.
//

import SwiftUI

struct Settings: View {
    
    @Environment(\.dismiss) private var dismiss
    @AppStorage("userName") var username = ""
    
    var body: some View {
        
        NavigationView {
            Form {
                TextField("Username", text: $username)
            }
            .navigationBarItems(trailing: Button("Done") {
                dismiss()
            }
            .accentColor(.indigo))
        }
    }
    
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
