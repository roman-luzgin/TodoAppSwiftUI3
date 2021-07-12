//
//  GestureRecognizer.swift
//  TodoAppSwiftUI3
//
//  Created by Roman Luzgin on 12.07.21.
//

import Foundation
import UIKit

//hide keyboard on press outside
extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
