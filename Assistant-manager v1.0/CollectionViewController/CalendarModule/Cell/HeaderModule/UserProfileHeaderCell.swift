//
//  UserProfileHeaderCell.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 19/01/2022.
//

import UIKit

class UserProfileHeaderCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var user: User? {
        //  didSet означает что эти пораметры класса можно транслировать по  приложениею
        didSet {
            let fullname =  user?.name
            nameLabel.text = fullname
            //вставляем с помощью extension фото аватарки
            profileImageView.loadImage(with: user?.profileImage ?? "")
        }
    }
    //MARK: - Propertis
    lazy var zigzagContainerView = SketchBorderView()

    let fonBlue: UIImageView = {
        let line = UIImageView()
        line.backgroundColor = UIColor.appColor(.blueAssistantFon)
        return line
     }()
    
    let boxViewBlue: UIImageView = {
        let line = UIImageView()
        line.backgroundColor = UIColor.appColor(.blueAssistantFon)
        return line
     }()
    
    lazy var circlForAvaViewBlue: UIImageView = {
        let line = UIImageView()
        line.backgroundColor = UIColor.appColor(.blueAssistantFon)
        line.layer.cornerRadius = 140
        line.layer.borderColor = UIColor.appColor(.whiteAndPinkDetailsAssistant)?.cgColor
        line.layer.borderWidth = 3
        
        return line
     }()
   
    lazy var profitCLL: UILabel = {
           let label = UILabel()
          // label.numberOfLines = 0
           label.textAlignment = .center
           let attributedText = NSMutableAttributedString(string: "345345", attributes: [.font: UIFont.systemFont(ofSize: 19)])
           label.textColor = .white
           label.attributedText = attributedText
               
           return label
       }()
    
       
    lazy var profitText: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        let attributedText = (NSAttributedString(string: "прибыль",  attributes: [.font: UIFont.systemFont(ofSize:18),NSAttributedString.Key.foregroundColor: UIColor.rgb(red: 255, green: 255, blue: 255)]))
        label.attributedText = attributedText
        
        return label
    }()
    lazy var stackProfit = UIStackView(arrangedSubviews: [profitCLL,profitText])
    
    lazy var revenueCell: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        let attributedText = NSMutableAttributedString(string: "34534345", attributes: [.font: UIFont.systemFont(ofSize: 19)])
        label.textColor = .white
        label.attributedText = attributedText
            
        return label
    }()
    
    lazy var revenueText: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        let attributedText = (NSAttributedString(string: "выручка",  attributes: [.font: UIFont.systemFont(ofSize:18),NSAttributedString.Key.foregroundColor: UIColor.rgb(red: 255, green: 255, blue: 255)]))
        label.attributedText = attributedText
        
        return label
    }()
    
    lazy var stackRevenue = UIStackView(arrangedSubviews: [revenueCell,revenueText])
    
    lazy var expensesCell: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        let attributedText = NSMutableAttributedString(string: "4534", attributes: [.font: UIFont.systemFont(ofSize: 19)])
        label.textColor = .white
        label.attributedText = attributedText
        
        return label
    }()
    
    lazy var expensesText: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        let attributedText = (NSAttributedString(string: "расходы",  attributes: [.font: UIFont.systemFont(ofSize:18),NSAttributedString.Key.foregroundColor: UIColor.rgb(red: 255, green: 255, blue: 255)]))
        label.attributedText = attributedText
        
        return label
    }()
    lazy var stackExpenses = UIStackView(arrangedSubviews: [expensesCell,expensesText])
    
    
    lazy var stackMony = UIStackView(arrangedSubviews: [stackProfit,stackRevenue,stackExpenses])
    
    lazy var clientButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "client"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.tintColor = UIColor(white: 1, alpha: 1)
        return button
    }()
    
    lazy var optionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "option"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.tintColor = UIColor(white: 1, alpha: 1)
        return button
    }()
    
    let profileImageView = CustomUIimageView(frame: .zero )
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "User"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
         return label
     }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.appColor(.blueAssistantFon)
        configureUI()
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        self.circlForAvaViewBlue.layer.borderColor = UIColor.appColor(.whiteAndPinkDetailsAssistant)?.cgColor
    }
    
    fileprivate func configureUI() {
   
        addSubview(fonBlue)
        fonBlue.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, pading: .init(top: -450, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 720))
        fonBlue.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
       
        addSubview(boxViewBlue)
        boxViewBlue.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, pading: .init(top: -15, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 330))
        boxViewBlue.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        zigzagContainerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(zigzagContainerView)
        zigzagContainerView.anchor(top: boxViewBlue.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, pading: .init(top: -10, left: -10, bottom: 0, right: -10))
    
        addSubview(circlForAvaViewBlue)
        circlForAvaViewBlue.anchor(top: boxViewBlue.topAnchor, leading: nil, bottom: nil, trailing: nil,pading: .init(top: 15, left: 0, bottom: 0, right: 0),  size: .init(width: 140, height: 140))
         
        circlForAvaViewBlue.layer.cornerRadius = 140 / 2
        circlForAvaViewBlue.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true //выстовляет по середине экрана
        
        addSubview(profileImageView)
        profileImageView.anchor(top: circlForAvaViewBlue.topAnchor, leading: nil, bottom: nil, trailing: nil,pading: .init(top: 10, left: 0, bottom: 0, right: 0),  size: .init(width: 120, height: 120))
         
        profileImageView.layer.cornerRadius = 120 / 2
        profileImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true //выстовляет по середине экрана
    
        addSubview(optionButton)
        optionButton.anchor(top: profileImageView.topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,pading: .init(top: 2.5, left: 20, bottom: 0, right: 0),  size: .init(width: 25, height: 25))
        optionButton.layer.cornerRadius = 25 / 2
        
        addSubview(clientButton)
        clientButton.anchor(top: profileImageView.topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor,pading: .init(top: 2.5, left: 0, bottom: 0, right: 20),  size: .init(width: 16, height: 25))
        
        addSubview(nameLabel)
        nameLabel.anchor(top: profileImageView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,  pading: .init(top: 20, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 20))
        nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true //выстовляет по середине экрана
        
      
        
        
        stackProfit.axis = .vertical
        stackProfit.spacing = 4
        stackProfit.distribution = .fillEqually
        
        
        stackExpenses.axis = .vertical
        stackExpenses.spacing = 4
        stackExpenses.distribution = .fillEqually
        
        
        stackRevenue.axis = .vertical
        stackRevenue.spacing = 4
        stackRevenue.distribution = .fillEqually
        
        stackMony.axis = .horizontal
        stackMony.spacing = 25
        stackMony.distribution = .fillEqually  // для корректного отображения
        addSubview(stackMony)
        stackMony.anchor(top: nameLabel.bottomAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: safeAreaLayoutGuide.trailingAnchor,  pading: .init(top: 70, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 0))
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

