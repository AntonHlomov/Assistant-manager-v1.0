//
//  TeamCircleCollectionViewCell.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 24/11/2022.
//
import UIKit

class TeamCircleCollectionViewCell: UICollectionViewCell {
    var team: Team?{
        didSet{
            imageView.loadImage(with: team?.profileImageURLTeamMember ?? "")
            guard let teamName = team?.nameTeamMember else {return}
            guard let teamFullname = team?.fullnameTeamMember else {return}
            nameLebel.text = teamName.capitalized + "\n" + teamFullname.capitalized
            }
    }
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupViews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var signChek = ""
    lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "avaUser6")
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 60.0/2.0
        iv.layer.masksToBounds = true
        return iv
    }()
    lazy var reminderSign: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = UIColor(white: 0, alpha: 0.8)
        return button
    }()
    lazy var nameLebel: UILabel = {
        let Label = UILabel()
        Label.text = "Имя"+"\n"+"Клиента"
        Label.textAlignment = .center
        Label.textColor = .darkGray
        Label.font = UIFont.boldSystemFont(ofSize: 12)
        Label.numberOfLines = 2
        return Label
    }()
    func setupViews(){
            addSubview(imageView)
            imageView.anchor(top: topAnchor, leading: nil, bottom: nil,trailing: nil, pading: .init(top: 0, left: 0, bottom: 0,right: 0), size: .init(width: 60, height: 60))
            imageView.centerXAnchor.constraint(equalTo:centerXAnchor).isActive = true
            addSubview(reminderSign)
            reminderSign.anchor(top: imageView.topAnchor, leading: nil,bottom: nil, trailing: imageView.trailingAnchor, pading:.init(top: -8, left: -8, bottom: 0, right: 0), size:.init(width: 22, height: 22))
            addSubview(nameLebel)
            nameLebel.anchor(top: imageView.bottomAnchor, leading: nil,bottom: nil, trailing: nil, pading: .init(top: 3, left: 0,bottom: 0, right: 0), size: .init(width: frame.size.width + 5,height: 0))
            nameLebel.centerXAnchor.constraint(equalTo:centerXAnchor).isActive = true
        }
}
