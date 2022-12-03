//
//  TeamTableViewCell.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 22/10/2022.
//
import UIKit

class TeamTableViewCell: UITableViewCell {
    // MARK: - Prop
    var team: Team?{
        didSet{
            profileImageView.loadImage(with: team?.profileImageURLTeamMember ?? "")
            guard let clientname = team?.nameTeamMember else {return}
            guard let fullname = team?.fullnameTeamMember else {return}
            guard let textclient = team?.categoryTeamMember else {return}
            textLabel?.text = clientname.capitalized + (" ") + fullname.capitalized
            detailTextLabel?.text = textclient
        }
    }
    let  profileImageView = CustomUIimageView(frame: .zero)
    lazy var  circleView: UIImageView = {
        let circl = UIImageView()
        circl.backgroundColor = UIColor.appColor(.blueAssistantFon)
        circl.layer.cornerRadius = 70
        circl.layer.borderWidth = 2.5
        circl.layer.borderColor = UIColor.appColor(.whiteAndPinkDetailsAssistant)?.cgColor
         return circl
     }()
   
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        self.circleView.layer.borderColor = UIColor.appColor(.whiteAndPinkDetailsAssistant)?.cgColor
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        addSubview(circleView)
        circleView.anchor(top: nil , leading: safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: nil,pading: .init(top: 0, left: 10, bottom: 0, right: 0),size: .init(width: 70, height: 70) )
        circleView.layer.cornerRadius = 70/2
        circleView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        addSubview(profileImageView)
        profileImageView.anchor(top: circleView.topAnchor, leading: circleView.leadingAnchor, bottom: nil, trailing: nil,pading: .init(top: 5, left: 5, bottom: 0, right: 0),size: .init(width: 60, height: 60))
        profileImageView.layer.cornerRadius = 60/2
        profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        textLabel?.text = ""
        detailTextLabel?.text = ""
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        textLabel?.frame = CGRect(x: 110, y: textLabel!.frame.origin.y - 2, width: (textLabel?.frame.width)!, height: (textLabel?.frame.height)!)
        detailTextLabel?.frame = CGRect(x: 110, y: textLabel!.frame.origin.y + 20, width: frame.width - 200, height: (detailTextLabel?.frame.height)!)
        textLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        textLabel?.textColor = UIColor.appColor(.whiteAssistant)!
        detailTextLabel?.font = UIFont.systemFont(ofSize: 12)
        detailTextLabel?.textColor = UIColor.appColor(.whiteAssistantwithAlpha)!
     }    
    required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
}
