//
//  AnchoredConstraintsExtension.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 14/01/2022.
//
import Foundation
import UIKit
//  структура констрейнов отступов и зависимостей(верх, лево, низ, право, ширина, высота)
struct AnchoredConstraints {
    var top, leading, bottom, trailing, width, height: NSLayoutConstraint?
}
extension UIView{
    @discardableResult
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?,pading: UIEdgeInsets = .zero, size: CGSize = .zero) -> AnchoredConstraints {
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()
        if let top = top {
                   anchoredConstraints.top = topAnchor.constraint(equalTo: top, constant: pading.top)
               }
        if let leading = leading {
            anchoredConstraints.leading = leadingAnchor.constraint(equalTo: leading, constant: pading.left)
        }
        if let bottom = bottom {
                   anchoredConstraints.bottom = bottomAnchor.constraint(equalTo: bottom, constant: -pading.bottom)
               }
        if let trailing = trailing{
                   anchoredConstraints.trailing = trailingAnchor.constraint(equalTo: trailing, constant: -pading.right)
               }
        if size.width != 0 {
            anchoredConstraints.width = widthAnchor.constraint(equalToConstant: size.width)
            
        }
        if size.height != 0 {
            anchoredConstraints.height = heightAnchor.constraint(equalToConstant: size.height)
        }
        [anchoredConstraints.top, anchoredConstraints.leading, anchoredConstraints.bottom, anchoredConstraints.trailing, anchoredConstraints.width, anchoredConstraints.height].forEach{
            $0?.isActive = true}
        return anchoredConstraints
        }

    func fillSuperview(pading: UIEdgeInsets = .zero)  {
    translatesAutoresizingMaskIntoConstraints = false
        if let superviewTopAnchor = superview?.topAnchor{
            topAnchor.constraint(equalTo: superviewTopAnchor, constant: pading.top).isActive = true
        }
        if let superviewBottomAnchor = superview?.bottomAnchor{
            topAnchor.constraint(equalTo: superviewBottomAnchor, constant: pading.bottom).isActive = true
        }
        if let superviewLeadingAnchor = superview?.leadingAnchor{
            leadingAnchor.constraint(equalTo: superviewLeadingAnchor, constant: pading.left ).isActive = true
        }
        if let superviewTrailingAnchor = superview?.trailingAnchor{
            trailingAnchor.constraint(equalTo: superviewTrailingAnchor, constant: pading.right).isActive = true
        }
    }
    func centerInSuperview(size: CGSize = .zero)  {
    translatesAutoresizingMaskIntoConstraints = false
        if let superviwCenterXAnchor = superview? .centerXAnchor{
            centerXAnchor.constraint(equalTo: superviwCenterXAnchor).isActive = true
        }
        if let superviwCenterYAnchor = superview? .centerYAnchor{
            centerYAnchor.constraint(equalTo: superviwCenterYAnchor).isActive = true
        }
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.width).isActive = true
        }
    }
}
