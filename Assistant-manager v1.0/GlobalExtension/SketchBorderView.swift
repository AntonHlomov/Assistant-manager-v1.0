//
//  SketchBorderView.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 20/01/2022.
//
import Foundation
import UIKit

class SketchBorderView: UIView {
    var observation: NSKeyValueObservation?
   lazy var borderLayer: CAShapeLayer = CAShapeLayer()
    override init(frame: CGRect) {
        super.init(frame: frame)
        // следит когда подниметься клавиатура
        commonInit()
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
      self.borderLayer.fillColor = UIColor.appColor(.blueAssistantFon)?.cgColor
     }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    func commonInit() -> Void {
        borderLayer.fillColor = UIColor.appColor(.blueAssistantFon)?.cgColor
        borderLayer.strokeColor = UIColor.clear.cgColor
        layer.addSublayer(borderLayer)
        backgroundColor = UIColor.clear
    }

    @objc func interfaceModeChanged()  {
        print("переключился")
        switch self.traitCollection.userInterfaceStyle {
            case .dark:commonInit()
            print("Темная")
        default: commonInit()
            print("Светлая")
            }
    }
    override func layoutSubviews() {
        let incrementVals: [CGFloat] = [
                0.15, 0.2, 0.2, 0.27, 0.18,
               ]
        let lineOffsets: [[CGFloat]] = [
            [ 0.0, -10.0],
            [0.0,  10.0],
            [0.0, -10.0],
            [ 0.0,  10.0],
            [ 0.0, -10.0],
        ]
        let pth: UIBezierPath = UIBezierPath()
        // inset bounds by 8-pts so we can draw the "wavy border"
        //  inside our bounds
        let r: CGRect = bounds.insetBy(dx: 0.0, dy: 0.0)
        var ptDest: CGPoint = .zero
        var ptControl: CGPoint = .zero
        // start at top-left
        ptDest = r.origin
        pth.move(to: ptDest)
        // we're at top-left
        for i in 0..<incrementVals.count {
            ptDest.x += r.width * incrementVals[i]
            ptDest.y = r.minY + lineOffsets[i][0]
            ptControl.x = pth.currentPoint.x + ((ptDest.x - pth.currentPoint.x) * 0.5)
            ptControl.y = r.minY + lineOffsets[i][1]
            pth.addQuadCurve(to: ptDest, controlPoint: ptControl)
        }
       // now we're at top-right
       for i in 0..<incrementVals.count {
           ptDest.y += r.height * incrementVals[i]
           ptDest.x = r.maxX + lineOffsets[i][0]
           ptControl.y = pth.currentPoint.y + ((ptDest.y - pth.currentPoint.y) * 0.5)
           ptControl.x = r.maxX + lineOffsets[i][1]
           pth.addQuadCurve(to: ptDest, controlPoint: ptControl)
       }
     // now we're at bottom-right
     for i in 0..<incrementVals.count {
         ptDest.x -= r.width * incrementVals[i]
         ptDest.y = r.maxY + lineOffsets[i][0]
         ptControl.x = pth.currentPoint.x - ((pth.currentPoint.x - ptDest.x) * 0.5)
         ptControl.y = r.maxY + lineOffsets[i][1]
         pth.addQuadCurve(to: ptDest, controlPoint: ptControl)
     }
    // now we're at bottom-left
    for i in 0..<incrementVals.count {
        ptDest.y -= r.height * incrementVals[i]
        ptDest.x = r.minX + lineOffsets[i][0]
        ptControl.y = pth.currentPoint.y - ((pth.currentPoint.y - ptDest.y) * 0.5)
        ptControl.x = r.minX + lineOffsets[i][1]
        pth.addQuadCurve(to: ptDest, controlPoint: ptControl)
    }
        borderLayer.path = pth.cgPath
    }
}
