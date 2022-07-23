//
//  CurrencyExtension.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 17/07/2022.
//

import Foundation
import UIKit



//let locale = Locale.current
//let currencySymbol = locale.currencySymbol!
//let currencyCode = locale.currencyCode!


enum CurrencyName {
    case eur
    case usd
    case rub
    case symbolSistem
}

extension String {
    static func appCurrency(_ name: CurrencyName) -> String{
        switch name {
        case .eur: return "€"
        case .usd: return "$"
        case .rub: return "₽"
        case .symbolSistem:
            let locale = Locale.current
            let currencySymbol = locale.currencySymbol!
            return currencySymbol
            
        }
        
    }
}
