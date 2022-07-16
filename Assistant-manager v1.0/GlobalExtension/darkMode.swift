//
//  darkMode.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 15/06/2022.
//

import Foundation

import Foundation
import UIKit

enum Theme: String {
    case light, dark, system
    // Utility var to pass directly to window.overrideUserInterfaceStyle
    var uiInterfaceStyle: UIUserInterfaceStyle {
        switch self {
        case .light:
            return .light
        case .dark:
            return .dark
        case .system:
            return .unspecified
        }
    }
}
