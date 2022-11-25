//
//  CustomUIimageView.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 20/01/2022.
//

import UIKit

class CustomUIimageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    private func configure(){
       contentMode = .scaleAspectFill
      // backgroundColor = .lightGray
      // image =  #imageLiteral(resourceName: "Icon_512x512").withRenderingMode(.alwaysOriginal)
       clipsToBounds = true
    }
  
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

