//
//  ColorExtension.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 14/01/2022.
//
import Foundation
import UIKit

extension UIColor{
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

enum AssetsColor {
    
    case blueAssistantFon
    case whiteAssistantFon
    case whiteAndPinkDetailsAssistant
    case darkAssistant
    case whiteAssistant
    case whiteAssistantwithAlpha
    case redAssistant
    case grenAssistant
    case whiteAndBlueAssistantFon
    case pinkAssistant
    case blueAssistant
    case geryAssistant
    case blueAndPink
    case whiteForDarkDarkForWhiteText
    case whiteForDarkBlueForWhite
    case blueAndWhite
}

extension UIColor {

    static func appColor(_ name: AssetsColor) -> UIColor? {
        switch name {
        case .blueAndWhite:
            return UIColor { traitCollection in
                switch traitCollection.userInterfaceStyle {
                    case .dark:
                    return UIColor.rgb(red: 255, green: 255, blue: 255)
                default:
                    return UIColor.rgb(red: 31, green: 152, blue: 233)
                    }
                }
            
        case .blueAndPink:
            return UIColor { traitCollection in
                switch traitCollection.userInterfaceStyle {
                    case .dark:
                    return UIColor.rgb(red: 190, green: 140, blue: 196)
                default:
                    return UIColor.rgb(red: 31, green: 152, blue: 233)
                    }
                }
  
        case .blueAssistantFon:
            return UIColor { traitCollection in
                switch traitCollection.userInterfaceStyle {
                    case .dark:
                    //return UIColor.rgb(red: 21, green: 22, blue: 27)
                    return UIColor.rgb(red: 20, green: 21, blue: 37)
                default:
                    return UIColor.rgb(red: 31, green: 152, blue: 233)
                    }
                  }
        case .whiteAssistantFon:
            return UIColor { traitCollection in
                switch traitCollection.userInterfaceStyle {
                    case .dark:
                    //return UIColor.rgb(red: 41, green: 42, blue: 47)
                    return UIColor.rgb(red: 38, green: 39, blue: 58)
                default:
                    return UIColor.rgb(red: 255, green: 255, blue: 255)
                    }
                  }
        case .whiteForDarkDarkForWhiteText:
            return UIColor { traitCollection in
                switch traitCollection.userInterfaceStyle {
                    case .dark:
                    return UIColor.rgb(red: 255, green: 255, blue: 255).withAlphaComponent(0.9)
                default:
                    return UIColor.rgb(red: 41, green: 42, blue: 47).withAlphaComponent(0.8)
                    }
                  }
        case .whiteForDarkBlueForWhite:
            return UIColor { traitCollection in
                switch traitCollection.userInterfaceStyle {
                    case .dark:
                    return UIColor.rgb(red: 255, green: 255, blue: 255)
                default:
                    return UIColor.rgb(red: 31, green: 152, blue: 233)
                    }
                  }

        case .whiteAndBlueAssistantFon:
            return UIColor { traitCollection in
                switch traitCollection.userInterfaceStyle {
                    case .dark:
                    return UIColor.rgb(red: 31, green: 152, blue: 233)
                default:
                    return UIColor.rgb(red: 255, green: 255, blue: 255)
                    }
                  }
            
        case .whiteAndPinkDetailsAssistant:
            return UIColor { traitCollection in
                switch traitCollection.userInterfaceStyle {
                    case .dark:
                    return UIColor.rgb(red: 190, green: 140, blue: 196)
                default:
                    return UIColor.rgb(red: 255, green: 255, blue: 255)
                    }
                  }
            
        case .darkAssistant:
           // return  UIColor.rgb(red: 38, green: 38, blue: 38)
            return UIColor.rgb(red: 38, green: 39, blue: 58)
            
        case .whiteAssistant:
            return  UIColor.rgb(red: 255, green: 255, blue: 255).withAlphaComponent(0.9)
        case .whiteAssistantwithAlpha:
            return  UIColor.rgb(red: 255, green: 255, blue: 255).withAlphaComponent(0.6)
        case .redAssistant:
            return  UIColor.rgb(red: 190, green: 140, blue: 196)
        case .grenAssistant:
            return  UIColor.rgb(red: 140, green: 190, blue: 166)
        case .pinkAssistant:
            return  UIColor.rgb(red: 190, green: 140, blue: 196)
        case .blueAssistant:
            return  UIColor.rgb(red: 31, green: 152, blue: 233)
        case .geryAssistant:
            return  UIColor.gray
   
        }
    }
}
//как использовать
//userNameTextField.textColor = UIColor.appColor(.blueAssistant)
