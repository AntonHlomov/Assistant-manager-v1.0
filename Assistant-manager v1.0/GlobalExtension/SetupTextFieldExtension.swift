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
    class func setupTextField(title: String, hideText: Bool, enabled: Bool) -> UITextField {
        let tf = CustomTextField(padding: 16)
        tf.placeholder = title
        tf.backgroundColor = UIColor.appColor(.whiteAssistantFon)!.withAlphaComponent(0.7)
        tf.layer.borderWidth = 2
        tf.layer.borderColor = UIColor.appColor(.geryAssistant)!.withAlphaComponent(0.2).cgColor
        tf.layer.cornerRadius = 10
        tf.font = UIFont .systemFont(ofSize: 16)
      //  tf.textColor = .darkText
        tf.isSecureTextEntry = hideText         // скрытие пороля
        tf.isEnabled = enabled
        return tf
    }
}
