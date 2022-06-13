//
//  MasterCollectionViewCell.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 12/06/2022.
//

import UIKit

class MasterCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupViews()
    }
                  
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let  imageView = CustomUIimageView(frame: .zero)

    let nameShurname: UILabel = {
        let Label = UILabel()
        Label.text = "Name Shurname"
        Label.textAlignment = .left
        Label.textColor = UIColor.appColor(.whiteForDarkDarkForWhiteText)
        Label.font = UIFont.systemFont(ofSize: 13)
        Label.numberOfLines = 1
        return Label
    }()
    let profession: UILabel = {
        let Label = UILabel()
        Label.text = "Hair staylist"
        Label.textAlignment = .left
        Label.textColor = UIColor.appColor(.whiteForDarkDarkForWhiteText)
        Label.font = UIFont.boldSystemFont(ofSize: 18)
        Label.numberOfLines = 1
        return Label
    }()
    let status: UILabel = {
        let Label = UILabel()
        Label.text = "Master"
        Label.textAlignment = .left
        Label.textColor = UIColor.appColor(.whiteForDarkDarkForWhiteText)
        Label.font = UIFont.systemFont(ofSize: 14)
        Label.numberOfLines = 1
        Label.adjustsFontSizeToFitWidth = true
        return Label
    }()
   
    lazy var stackNameCityContry = UIStackView(arrangedSubviews: [status])
        
        
    func setupViews(){

    //  imageView.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: 80)
    addSubview(imageView)
        imageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, pading: .init(top: 8, left: 8, bottom: 0, right: 0), size: .init(width: 25, height: 25))
        imageView.layer.cornerRadius = 25/2
   // imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
  
    addSubview(nameShurname)
        nameShurname.anchor(top: topAnchor, leading: imageView.trailingAnchor, bottom: nil, trailing: nil, pading: .init( top: 7, left: 10, bottom: 0, right: 5), size: .init(width: frame.width-30, height: 0))
   // nameLebel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
    addSubview(profession)
        profession.anchor(top: topAnchor, leading: imageView.trailingAnchor, bottom: nil, trailing: nil, pading: .init( top: 33, left: 10, bottom: 0, right: 0), size: .init(width: 0, height: 0))
        profession.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        //nameCurentPlace.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        stackNameCityContry.axis = .horizontal
        stackNameCityContry.spacing = 0
        stackNameCityContry.distribution = .fillEqually  // для корректного отображения
        
     addSubview(stackNameCityContry)
        stackNameCityContry.anchor(top: profession.bottomAnchor, leading: profession.leadingAnchor, bottom: nil, trailing: profession.trailingAnchor, pading: .init( top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 0))
        stackNameCityContry.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
      
    }
}
