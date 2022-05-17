//
//  TableClientCell.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 17/05/2022.
//

import UIKit

class TableClientCell: UITableViewCell {
    // MARK: - Prop
    var client: Client?{
        didSet{
            //вставляем с помощью extension фото аватарки
            profileImageView.loadImage(with: client?.profileImageClientUrl ?? "")
            guard let clientname = client?.nameClient else {return}
            guard let fullname = client?.fullName else {return}
            guard let textclient = client?.textAboutClient else {return}
            textLabel?.text = clientname.capitalized + (" ") + fullname.capitalized
            detailTextLabel?.text = textclient
            
        }
    }
    let  profileImageView = CustomUIimageView(frame: .zero)
    let circleView: UIImageView = {
        let circl = UIImageView()
        circl.backgroundColor = .white
        circl.layer.borderWidth = 2
        circl.layer.borderColor = UIColor.rgb(red: 31, green: 152, blue: 233) .cgColor
         return circl
     }()
    let lineView: UIImageView = {
        let line = UIImageView()
        line.backgroundColor = .lightGray
         return line
     }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        addSubview(lineView)
        
        lineView.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: nil,pading: .init(top: -5, left: 26, bottom: 0, right: 0),size: .init(width: 1, height: 76))
        
        addSubview(circleView)
        
        circleView.anchor(top: nil , leading: lineView.leadingAnchor, bottom: nil, trailing: nil,pading: .init(top: 0, left: -5.5, bottom: 0, right: 0),size: .init(width: 11, height: 11))
        circleView.layer.cornerRadius = 11/2
        circleView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        
        addSubview(profileImageView)
        
        profileImageView.anchor(top: nil, leading: lineView.leadingAnchor, bottom: nil, trailing: nil,pading: .init(top: 0, left: 20, bottom: 0, right: 0),size: .init(width: 60, height: 60))
        profileImageView.layer.cornerRadius = 60/2
        profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        textLabel?.text = ""
        detailTextLabel?.text = ""
        
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textLabel?.frame = CGRect(x: 117, y: textLabel!.frame.origin.y - 2, width: (textLabel?.frame.width)!, height: (textLabel?.frame.height)!)
        detailTextLabel?.frame = CGRect(x: 117, y: textLabel!.frame.origin.y + 20, width: frame.width - 200, height: (detailTextLabel?.frame.height)!)
        textLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        detailTextLabel?.font = UIFont.systemFont(ofSize: 12)
        detailTextLabel?.textColor = .systemGray2
    }
    
    required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }

}
