//
//  ButtonExtension.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 14/01/2022.
//

import Foundation
import UIKit

extension UIButton{
    class func setupButton(title: String, color: UIColor, activation: Bool, invisibility: Bool, laeyerRadius: Double, alpha: Double, textcolor: UIColor  ) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(textcolor, for: .normal)
        button.backgroundColor = color.withAlphaComponent(alpha)
        button.layer.cornerRadius = laeyerRadius //30/2  // скругляем кнопку
        button.isEnabled = activation   //диактивация кнопки изначально кнопка не активна (активна после заполнения всех полей)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.isHidden = invisibility
       
        return button
    }
    class func setupButtonImage(color: UIColor, activation: Bool, invisibility: Bool, laeyerRadius: Double, alpha: Double, resourseNa: String ) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = color.withAlphaComponent(alpha)
        button.layer.cornerRadius = laeyerRadius //30/2  // скругляем кнопку
        button.isEnabled = activation   //диактивация кнопки изначально кнопка не активна (активна после заполнения всех полей)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.isHidden = invisibility
        button.setImage(#imageLiteral(resourceName: resourseNa), for: .normal)
        button.tintColor = UIColor(white: 1, alpha: 1)
        return button
    }
}

