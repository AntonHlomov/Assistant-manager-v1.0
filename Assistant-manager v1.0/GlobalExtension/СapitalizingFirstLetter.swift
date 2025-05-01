//
//  СapitalizingFirstLetter.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 30/04/2025.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
