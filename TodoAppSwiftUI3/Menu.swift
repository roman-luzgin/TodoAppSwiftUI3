//
//  Menu.swift
//  TodoAppSwiftUI3
//
//  Created by Roman Luzgin on 27.06.21.
//

import SwiftUI

struct Menu: View {
    @State private var menuOpen = false
    
    var body: some View {
        ZStack {
            
            if menuOpen {
                ZStack {
                    Image("menuWallpaper")
                        .resizable()
                        .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight)
                    
                    VStack {
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.ultraThinMaterial)
                    .onTapGesture(count: 1, perform: { withAnimation {
                        menuOpen = false
                    }})
                    
                    HStack {
                        VStack {
                            Label("Menu Item 1", systemImage: "circle")
                                .font(.title)
                            Label("Menu Item 2", systemImage: "triangle")
                                .font(.title)
                            Label("Menu Item 3", systemImage: "square")
                                .font(.title)
                        }
                        Spacer()
                    }
                    .padding(10)
                }
            }
            
            MainScreen(menuOpen: $menuOpen)
                .scaleEffect(menuOpen ? 0.5 : 1)
                .offset(x: menuOpen ? 160 : 0)
            
        }
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
