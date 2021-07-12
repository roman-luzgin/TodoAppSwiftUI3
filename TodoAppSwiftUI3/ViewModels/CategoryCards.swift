//
//  CategoryCards.swift
//  TodoAppSwiftUI3
//
//  Created by Roman Luzgin on 21.06.21.
//

import SwiftUI

struct CategoryCards: View {
    var category: String
    var color: Color
    var numberOfTasks: Int
    var tasksDone: Int
    
    let maxProgress = 180.0
    
    var progress: Double {
        maxProgress*(Double(tasksDone)/Double(numberOfTasks))
    }
    
    var body: some View {
        VStack(alignment: .leading){
            Text("\(numberOfTasks) tasks")
                .font(.callout)
                .foregroundColor(.secondary)
            Text(category)
                .font(.title.bold())
            
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .frame(maxWidth: maxProgress)
                    .frame(height: 5)
                    .foregroundColor(.gray.opacity(0.5))
                
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .frame(maxWidth: maxProgress)
                    .frame(width: numberOfTasks > 0 ? progress : 0, height: 5)
                    .foregroundColor(color.opacity(0.9))
            }
            
            
            
        }
        .padding(10)
        .frame(width: 200, height: 120, alignment: .leading)
        .background(
            ZStack {
            
            LinearGradient(colors: [color.opacity(0.95), color.opacity(0.3)],
                           startPoint: .topLeading, endPoint: .bottomTrailing)
            
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(20)
            
            VStack {
                // empty VStack for the blur
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.thinMaterial)
        },
            alignment: .leading
        )
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: .black.opacity(0.1), radius: 20, x: 5, y: 10)
        .shadow(color: .black.opacity(0.1), radius: 1, x: 1, y: 1)
        .shadow(color: .white.opacity(1), radius: 5, x: -1, y: -1)
    }
}

struct CategoryCards_Previews: PreviewProvider {
    static var previews: some View {
        CategoryCards(category: "Business",
                      color: Color.cyan,
                      numberOfTasks: 40,
                      tasksDone: 20)
    }
}
