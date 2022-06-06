//
//  EmptyCalendarCell.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 19/01/2022.
//

import UIKit

class EmptyCalendarCell: UICollectionViewCell,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        backgroundColor = UIColor.appColor(.blueAssistantFon)
        setupViews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        self.boxViewFonWhite.layer.borderColor = UIColor.appColor(.whiteAndPinkDetailsAssistant)?.cgColor
    }
    
    let textLebel: UILabel = {
        let Label = UILabel()
        Label.textAlignment = .center
        Label.text = "There are no expected customers yet"
        Label.font = UIFont.systemFont(ofSize:20)
        Label.textColor = UIColor.appColor(.whiteAndPinkDetailsAssistant)
        Label.numberOfLines = 0
        return Label
    }()

    let boxViewBlue: UIImageView = {
        let line = UIImageView()
        line.backgroundColor = UIColor.appColor(.blueAssistantFon)
        return line
     }()
    
    let boxViewFonWhite: UIImageView = {
        let line = UIImageView()
        line.backgroundColor = UIColor.appColor(.blueAssistantFon)
        line.layer.borderColor = UIColor.appColor(.whiteAndPinkDetailsAssistant)?.cgColor
        line.layer.borderWidth = 2
        return line
     }()
    
    func setupViews(){
        addSubview(boxViewBlue)
        boxViewBlue.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, pading: .init(top: 0, left: 0, bottom: 0, right: 0),size: .init(width: frame.width, height: 20))
        centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        addSubview(boxViewFonWhite)
        boxViewFonWhite.anchor(top: boxViewBlue.bottomAnchor , leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor ,pading: .init(top: -20, left: 0, bottom: 40, right: 0),size: .init(width: 0, height: 0))
        boxViewFonWhite.layer.cornerRadius = 20
    
        addSubview(textLebel)
        textLebel.anchor(top: boxViewFonWhite.topAnchor , leading: boxViewFonWhite.leadingAnchor, bottom: boxViewFonWhite.bottomAnchor, trailing: boxViewFonWhite.trailingAnchor ,pading: .init(top:  boxViewFonWhite.frame.height/2, left: 10, bottom: 0, right: 10),size: .init(width: 0, height: 0))
        textLebel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        textLebel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

    }
}
