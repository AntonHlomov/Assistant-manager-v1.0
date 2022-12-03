//
//  BlurEfectExtensionView.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 16/06/2022.
//
import Foundation
import UIKit

extension UIView
{
    func addBlurEffect(style: UIBlurEffect.Style){
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds

        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        self.addSubview(blurEffectView)
    }
}
