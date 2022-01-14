//
//  ButtonExtension.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 14/01/2022.
//

import Foundation
import UIKit

extension UIButton{
    class func setupButton(title: String, color: UIColor, activation: Bool ) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = color
        button.layer.cornerRadius = 22  // скругляем кнопку
        button.isEnabled = activation   //диактивация кнопки изначально кнопка не активна (активна после заполнения всех полей)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        return button
    }
}

