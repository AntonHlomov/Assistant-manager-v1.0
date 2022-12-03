//
//  ExpensesCell.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 28/11/2022.
//
import UIKit
class ExpensesCell: UICollectionViewCell,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
   
    var expenses: Expense?{
        didSet{
            imageView.loadImage(with: expenses?.profileImageUser ?? "")
            guard let userName = expenses?.nameUser else {return}
            guard let userFullname = expenses?.fullNameUser else {return}
            guard let nameExpense = expenses?.nameExpense else {return}
            guard let priceExpense = expenses?.priceExpense else {return}
            guard let date = expenses?.dateExpenseFormatDDMMYYYY else {return}
            guard let placeExpense = expenses?.placeExpense else {return}
            guard let categoryExpense = expenses?.categoryExpense else {return}
            nameLebel.text = userName.capitalized + "\n" + userFullname.capitalized
            priceLabel.text = String(priceExpense)
            nameServise.text = nameExpense
            dateServise.text = date
            place.text = placeExpense
            category.text = categoryExpense
            }
    }
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupViews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let lineViewUp: UIImageView = {
        let line = UIImageView()
        line.backgroundColor = UIColor.appColor(.whiteAndPinkDetailsAssistant)
         return line
     }()
    lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "avaUser6")
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 48.0/2.0
        iv.layer.masksToBounds = true
        return iv
    }()
    lazy var nameLebel: UILabel = {
        let Label = UILabel()
        Label.text = "Name"+"\n"+"User"
        Label.textAlignment = .center
        Label.textColor = UIColor.appColor(.whiteAssistant)!
        Label.font = UIFont.boldSystemFont(ofSize: 8)
        Label.numberOfLines = 2
        return Label
    }()
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "0"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor.appColor(.whiteAssistant)!
         return label
     }()
    lazy var priceNameCurrencyLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = String.appCurrency(.symbolSistem)
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor.appColor(.whiteAssistant)!
         return label
     }()
    lazy var nameServise: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Name servise"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor.appColor(.whiteAssistant)!
         return label
     }()
    lazy var dateServise: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "00.00.0000"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = UIColor.appColor(.whiteAssistantwithAlpha)!
         return label
     }()
    lazy var place: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Place"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = UIColor.appColor(.whiteAssistantwithAlpha)!
         return label
     }()
    lazy var category: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Category"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = UIColor.appColor(.whiteAssistantwithAlpha)!
         return label
     }()
    func setupViews(){        
            addSubview(lineViewUp)
        lineViewUp.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil,pading: .init(top: 3, left: frame.width/3, bottom: frame.height/2, right: 0),size: .init(width: 1, height: 0))
            addSubview(imageView)
        imageView.anchor(top: topAnchor, leading: lineViewUp.trailingAnchor, bottom: nil,trailing: nil, pading: .init(top: (frame.height - imageView.frame.height)/2, left: -24, bottom: 0,right: 0), size: .init(width: 48, height: 48))
            addSubview(nameLebel)
            nameLebel.anchor(top: imageView.bottomAnchor, leading: nil,bottom: nil, trailing: nil, pading: .init(top: 3, left: 0,bottom: 0, right: 0), size: .init(width: frame.size.width + 5,height: 0))
        nameLebel.centerXAnchor.constraint(equalTo:imageView.centerXAnchor).isActive = true
        addSubview(priceNameCurrencyLabel)
              priceNameCurrencyLabel.anchor(top: nil , leading: nil, bottom: nil, trailing: imageView.leadingAnchor,pading: .init(top: 0, left: 0,  bottom: 0, right: 15),size: .init(width: 0, height: 11))
        priceNameCurrencyLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
        addSubview(priceLabel)
        priceLabel.anchor(top: nil , leading: nil, bottom: nil, trailing: priceNameCurrencyLabel.leadingAnchor,pading: .init(top: 0, left: 0, bottom: 0,  right: 3),size: .init(width: 0, height: 11))
        priceLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
        addSubview(nameServise)
        nameServise.anchor(top: imageView.topAnchor , leading: imageView.trailingAnchor , bottom: nil, trailing: nil ,pading: .init(top: 0, left: 15, bottom: 0,  right: 0),size: .init(width: 0, height: 0))
        addSubview(place)
        place.anchor(top: nameServise.bottomAnchor , leading: nameServise.leadingAnchor, bottom: nil, trailing: nil ,pading: .init(top: 5, left: 0, bottom: 0,  right: 0),size: .init(width: 0, height: 0))
        addSubview(category)
        category.anchor(top: place.bottomAnchor , leading: nameServise.leadingAnchor, bottom: nil, trailing: nil,pading: .init(top: 0, left: 0, bottom: 0,  right: 0),size: .init(width: 0, height: 0))
        addSubview(dateServise)
        dateServise.anchor(top: category.bottomAnchor , leading: nameServise.leadingAnchor, bottom: nil, trailing: nil,pading: .init(top: 5, left: 0, bottom: 0,  right: 0),size: .init(width: 0, height: 0)) 
    }
}
