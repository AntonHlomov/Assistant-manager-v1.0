//
//  SetupTextFieldExtension.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 14/01/2022.
//

import Foundation
import UIKit

class CustomTextField: UITextField{
    let padding: CGFloat
    init(padding:CGFloat) {
        self.padding = padding
        super.init(frame: .zero)
        
    }
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: 0)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: 0)
    }
    override var intrinsicContentSize: CGSize{
        return .init(width: 0, height: 50)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// функция для поля текст филд
extension UITextField{
    class func setupTextField(title: String, hideText: Bool) -> UITextField {
        let tf = CustomTextField(padding: 16)
        tf.placeholder = title
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.layer.cornerRadius = 5
        tf.font = UIFont .systemFont(ofSize: 18)
        tf.isSecureTextEntry = hideText         // скрытие пороля
        return tf
    }
}
