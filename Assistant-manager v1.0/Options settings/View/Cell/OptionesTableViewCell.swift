//
//  OptionesTableViewCell.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 06/06/2022.
//

import UIKit

class OptionesTableViewCell: UITableViewCell {

   // lazy var optionesImageView = UIImageView(image: #imageLiteral(resourceName: "buttonAddCL").withRenderingMode(.alwaysOriginal))
    lazy var optionesImageView = CustomUIimageView(frame: .zero )

      let circleView: UIImageView = {
          let line = UIImageView()
          line.backgroundColor = UIColor.appColor(.blueAssistantFon)
          line.layer.cornerRadius = 140
          line.layer.borderColor = UIColor.appColor(.whiteAndPinkDetailsAssistant)!.cgColor
          line.layer.borderWidth = 2
          return line
       }()
      
     let lineView: UIImageView = {
          let line = UIImageView()
          line.backgroundColor = UIColor.appColor(.whiteAndPinkDetailsAssistant)
          return line
       }()
  
     override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
       super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
     //selectionStyle = .none
     //  accessoryType = .disclosureIndicator
       
         
       addSubview(lineView)
       lineView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil,pading: .init(top: 0, left: 35, bottom: 0, right: 0),size: .init(width: 1, height: 0))
       
       addSubview(circleView)
       circleView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil,pading: .init(top: 9, left: 17.5, bottom: 9, right: 0),size: .init(width:35, height: 35))
       circleView.layer.cornerRadius = 35/2
       circleView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
       addSubview(optionesImageView)
       optionesImageView.anchor(top: circleView.topAnchor, leading: circleView.leadingAnchor, bottom: nil, trailing: nil,pading: .init(top: 7.5, left: 7.5, bottom: 0, right: 0),size: .init(width: 20, height: 20))
       optionesImageView.layer.cornerRadius = 20/2
       optionesImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
       textLabel?.text = ""
       detailTextLabel?.text = ""
     
     }
    override func layoutSubviews() {
        super.layoutSubviews()
        textLabel?.frame = CGRect(x:70, y: textLabel!.frame.origin.y - 2, width: (textLabel?.frame.width)!, height: (textLabel?.frame.height)!)
     
        detailTextLabel?.frame = CGRect(x: 70, y: textLabel!.frame.origin.y + 20, width: frame.width/2, height: (detailTextLabel?.frame.height)!)
        
        textLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        textLabel?.textColor = UIColor.appColor(.whiteAssistant)!
        detailTextLabel?.font = UIFont.systemFont(ofSize: 12)
        detailTextLabel?.textColor = UIColor.appColor(.whiteAssistantwithAlpha)!
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        self.circleView.layer.borderColor = UIColor.appColor(.whiteAndPinkDetailsAssistant)?.cgColor
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

        // Configure the view for the selected state
    }

}
