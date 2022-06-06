//
//  HeaderOptinesTableViewCell.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 06/06/2022.
//

import UIKit

class HeaderOptinesTableViewCell: UITableViewCell {
    var user: User? {
        didSet {
            profileImageView.loadImage(with: user?.profileImage ?? "")
            guard let name = user?.name else {return}
            guard let fullname = user?.fullName else {return}
            nameLabel.text = name.capitalized + (" ") + fullname.capitalized
        }
    }
    
    lazy var circlForAvaViewBlue: UIImageView = {
        let line = UIImageView()
        line.backgroundColor = UIColor.appColor(.blueAssistantFon)
        line.layer.cornerRadius = 140
        line.layer.borderColor = UIColor.appColor(.whiteAndPinkDetailsAssistant)?.cgColor
        line.layer.borderWidth = 3
        return line
     }()
    let profileImageView = CustomUIimageView(frame: .zero )
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.text = "Name Shurname"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.appColor(.whiteAssistant)
         return label
     }()
    let commit: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Мake changes"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor.appColor(.whiteAssistant)!.withAlphaComponent(0.6)
         return label
     }()
    //Check color
    let lineView: UIImageView = {
         let line = UIImageView()
        line.backgroundColor = UIColor.appColor(.whiteAndPinkDetailsAssistant)
         return line
      }()
    var addBuferButton: UIButton = {
       let button = UIButton(type: .system)
       button.setImage(#imageLiteral(resourceName: "269").withRenderingMode(.alwaysOriginal), for: .normal)
       button.contentHorizontalAlignment = .left
       return button
   }()
    lazy var stackView = UIStackView(arrangedSubviews: [commit])
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
    
        addSubview(lineView)
        lineView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil,pading: .init(top: 0, left: 35, bottom: 0, right: 0),size: .init(width: 1, height: 0))
        
        addSubview(circlForAvaViewBlue)
        circlForAvaViewBlue.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil,pading: .init(top: 0, left: 0, bottom: 60, right: 0),  size: .init(width: 70, height: 70))
        circlForAvaViewBlue.layer.cornerRadius = 70 / 2
        
        addSubview(profileImageView)
        profileImageView.anchor(top: circlForAvaViewBlue.topAnchor, leading: circlForAvaViewBlue.leadingAnchor, bottom: nil, trailing: nil,pading: .init(top: 10, left: 10, bottom: 0, right: 0),  size: .init(width: 50, height: 50))
        profileImageView.layer.cornerRadius = 50 / 2
     
        addSubview(nameLabel)
        nameLabel.anchor(top: circlForAvaViewBlue.topAnchor, leading: circlForAvaViewBlue.trailingAnchor, bottom: nil, trailing: nil,  pading: .init(top: 12, left: 20, bottom: 0, right: 0), size: .init(width: 0, height: 0))
    
        addBuferButton.anchor(top: nil, leading: nil, bottom: nil, trailing: nil,  pading: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 10, height: 15))
    
        stackView.axis = .horizontal
        stackView.spacing = 1

        addSubview(stackView)
        stackView.anchor(top: nameLabel.bottomAnchor, leading:nameLabel.leadingAnchor, bottom: nil, trailing: trailingAnchor,  pading: .init(top: 3, left: 0, bottom: 0, right: 20), size: .init(width: 0, height: 0))

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
