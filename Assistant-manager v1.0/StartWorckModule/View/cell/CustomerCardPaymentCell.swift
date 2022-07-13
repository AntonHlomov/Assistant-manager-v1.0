//
//  CustomerCardPaymentCell.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 07/07/2022.
//

import UIKit

class CustomerCardPaymentCell: UICollectionViewCell {
    // MARK: - Prop
    var customerRecord: CustomerRecord?{
        didSet{
            imageView.loadImage(with: customerRecord?.profileImageClient ?? "")
            guard let nameClient = customerRecord?.nameClient else {return}
            guard let surnameClient = customerRecord?.fullNameClient else {return}
            guard let commentTex = customerRecord?.commit else {return}
            guard let dateTimeStartService = customerRecord?.dateTimeStartService else {return}
            nameLebel.text = nameClient.capitalized + "\n" + surnameClient.capitalized
            commentTexCell.text = String(commentTex)
            timeStartServiceCell.text = String(dateTimeStartService.dropFirst(11))
            
        }
    }
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    lazy var calendarImageView = UIImageView(image: #imageLiteral(resourceName: "icons8-календарь-24").withRenderingMode(.alwaysOriginal))
    
    let timeStartServiceCellText: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Visit at"
        label.font = UIFont.boldSystemFont(ofSize: 16)
     // label.numberOfLines = 0
        label.textColor = UIColor.appColor(.whiteAssistant)
         return label
     }()
    let timeStartServiceCell: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "time"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor =  UIColor.appColor(.whiteAssistant)
         return label
     }()
    

    let  imageView = CustomUIimageView(frame: .zero)

    let nameLebel: UILabel = {
        let Label = UILabel()
        Label.textAlignment = .center
        Label.text = "Name client"
        Label.font = UIFont.boldSystemFont(ofSize: 14)
        Label.numberOfLines = 0
        return Label
    }()

    let boxViewBlue: UIImageView = {
        let line = UIImageView()
        line.backgroundColor = .clear //UIColor.appColor(.blueAssistantFon)
        return line
     }()
    
    let boxViewFonWhite: UIImageView = {
        let line = UIImageView()
        line.backgroundColor = UIColor.appColor(.whiteAssistantFon)
        return line
     }()
    let serviesArey: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "servies"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
       // label.lineBreakMode = .byWordWrapping
        label.textColor = UIColor.appColor(.whiteForDarkDarkForWhiteText)
         return label
     }()
     let priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "nil"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textColor = UIColor.appColor(.whiteForDarkDarkForWhiteText)
         return label
     }()
    let lineHorizontForTaxView: UIImageView = {
        let line = UIImageView()
        line.backgroundColor = UIColor.appColor(.whiteForDarkDarkForWhiteText)
         return line
     }()
    let priceCosText: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Total:"
        label.font = UIFont.systemFont(ofSize: 19)
        label.textColor = UIColor.appColor(.whiteForDarkDarkForWhiteText)
         return label
     }()
    let priceCos: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.text = "0"
        label.font = UIFont.systemFont(ofSize: 19)
        label.textColor = UIColor.appColor(.whiteForDarkDarkForWhiteText)
         return label
     }()

    let commentTexCell: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "commentTex"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = UIColor.appColor(.whiteForDarkDarkForWhiteText)?.withAlphaComponent(0.5)
        label.numberOfLines = 0
         return label
     }()
    lazy var closeXButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "closeX").withRenderingMode(.alwaysOriginal), for: .normal)
        button.layer.cornerRadius = 20/2
        return button
    }()

    func setupViews(){
        backgroundColor = UIColor.appColor(.blueAssistantFon)
   
        addSubview(boxViewBlue)
        boxViewBlue.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, pading: .init(top: 0, left: 0, bottom: 0, right: 0),size: .init(width: frame.width, height: 80))
        centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        addSubview(boxViewFonWhite)
        boxViewFonWhite.anchor(top: boxViewBlue.bottomAnchor , leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor ,pading: .init(top: 0, left: 0, bottom: 0, right: 0),size: .init(width: 0, height: 0))
        boxViewFonWhite.layer.cornerRadius = 20
    
        addSubview(imageView)
        imageView.anchor(top: boxViewFonWhite.topAnchor , leading: leadingAnchor, bottom: nil, trailing: nil,pading: .init(top: 10, left: 20, bottom: 0, right: 0),size: .init(width: 70, height: 70))
        imageView.layer.cornerRadius = 70/2

        addSubview(nameLebel)
        nameLebel.anchor(top: imageView.bottomAnchor , leading: imageView.leadingAnchor, bottom: nil, trailing: imageView.trailingAnchor,pading: .init(top: 5, left: -3, bottom: 0, right: -3),size: .init(width: 0, height: 0))
       
        addSubview(calendarImageView)
        calendarImageView.anchor(top: nil, leading: leadingAnchor, bottom: boxViewFonWhite.topAnchor, trailing: nil,pading: .init(top: 12, left: 0, bottom: 12, right: 0),  size: .init(width: 25, height: 25))
        
        addSubview(timeStartServiceCellText)
        timeStartServiceCellText.anchor(top: nil, leading: calendarImageView.trailingAnchor, bottom: calendarImageView.bottomAnchor, trailing: nil,pading: .init(top: 0, left: 7, bottom: 0, right: 0),size: .init(width: 0, height: 20))
        
        addSubview(timeStartServiceCell)
        timeStartServiceCell.anchor(top: nil, leading: timeStartServiceCellText.trailingAnchor, bottom: calendarImageView.bottomAnchor, trailing: nil,pading: .init(top: 0, left: 7, bottom: 0, right: 0),size: .init(width: 0, height: 20))
        

        addSubview(closeXButton)
        closeXButton.anchor(top: nil, leading: nil, bottom: boxViewFonWhite.topAnchor, trailing: trailingAnchor,pading: .init(top: 0, left: 0, bottom: 10, right: 23),size: .init(width: 20, height: 20))
        closeXButton.layer.cornerRadius = 20/2

        addSubview(serviesArey)
        serviesArey.anchor(top: imageView.topAnchor, leading: imageView.trailingAnchor, bottom: nil, trailing: nil,pading: .init(top: 0, left: 25, bottom: 0, right: 0),size: .init(width: 0, height: 130))
        
        addSubview(priceLabel)
        priceLabel.anchor(top: serviesArey.topAnchor, leading: serviesArey.trailingAnchor, bottom: serviesArey.bottomAnchor, trailing: trailingAnchor,pading: .init(top: 0, left: 10, bottom: 0, right: 25),size: .init(width: 0, height: 0))

        addSubview(lineHorizontForTaxView)
        lineHorizontForTaxView.anchor(top: serviesArey.bottomAnchor , leading: imageView.leadingAnchor, bottom: nil, trailing: priceLabel.trailingAnchor,pading: .init(top: 20, left: 0, bottom: 0, right: 0),size: .init(width: 0, height: 1))

        addSubview(priceCosText)
        priceCosText.anchor(top: lineHorizontForTaxView.bottomAnchor , leading: lineHorizontForTaxView.leadingAnchor, bottom: nil, trailing: nil,pading: .init(top: 9, left: 0, bottom: 0, right: 0),size: .init(width: 0, height: 15))
        
        addSubview(priceCos)
        priceCos.anchor(top: lineHorizontForTaxView.bottomAnchor , leading: priceCosText.trailingAnchor, bottom: nil, trailing: trailingAnchor,pading: .init(top: 9, left: 5, bottom: 0, right: 25),size: .init(width: 0, height: 0))

        addSubview(commentTexCell)
        commentTexCell.anchor(top: priceCosText.bottomAnchor , leading: lineHorizontForTaxView.leadingAnchor, bottom: bottomAnchor, trailing: lineHorizontForTaxView.trailingAnchor,pading: .init(top: 10, left: 0, bottom: 10, right: 0),size: .init(width: 0, height: 0))
    }

}
