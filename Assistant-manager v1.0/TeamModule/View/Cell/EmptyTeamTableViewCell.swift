//
//  EmptyTeamTableViewCell.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 06/11/2022.
//
import UIKit

class EmptyTeamTableViewCell: UITableViewCell {
    
    let textLebel: UILabel = {
        let Label = UILabel()
        Label.textAlignment = .center
        Label.text = "You can create a team of like-minded people."+"\n\n"+" With general control of all functions. When you create a team, you automatically get the maximum access right Boss. For a team member, you can choose two options: Administrator or Master. To add members, click the + button. And add the ID number you received from the future team member. After that, he needs to confirm your request."+"\n\n"+"Click to create a team."
        Label.font = UIFont.systemFont(ofSize:18)
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
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = UIColor.appColor(.blueAssistantFon)
        setupViews()
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        self.boxViewFonWhite.layer.borderColor = UIColor.appColor(.whiteAndPinkDetailsAssistant)?.cgColor
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    func setupViews(){
        addSubview(boxViewBlue)
        boxViewBlue.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, pading: .init(top: 0, left: 0, bottom: 0, right: 0),size: .init(width: frame.width, height: 20))
        boxViewBlue.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        addSubview(boxViewFonWhite)
        boxViewFonWhite.anchor(top: boxViewBlue.bottomAnchor , leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor ,pading: .init(top: -20, left: 20, bottom: 40, right: 20),size: .init(width: frame.width - 40, height: 0))
        boxViewFonWhite.layer.cornerRadius = 20
        boxViewFonWhite.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        boxViewFonWhite.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        addSubview(textLebel)
        textLebel.anchor(top: boxViewFonWhite.topAnchor , leading: boxViewFonWhite.leadingAnchor, bottom: boxViewFonWhite.bottomAnchor, trailing: boxViewFonWhite.trailingAnchor ,pading: .init(top:  boxViewFonWhite.frame.height/2, left: 10, bottom: 0, right: 10),size: .init(width: 0, height: 0))
        textLebel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        textLebel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
}
