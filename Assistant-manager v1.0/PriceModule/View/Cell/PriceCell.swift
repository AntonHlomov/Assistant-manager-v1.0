//
//  PriceCell.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 08/06/2022.
//

import UIKit

class PriceCell: UITableViewCell {
    // MARK: - Prop
    var price: Price?{
        didSet{
            guard let nameServiseAp = price?.nameServise else {return}
            guard let priceServiesAp = price?.priceServies else {return}
            guard let timeAtWorkAp = price?.timeAtWorkMin else {return}
            guard let timeAtReturnWorkAp = price?.timeReturnServiseDays else {return}

            priceLabel.text = String(priceServiesAp).capitalized
            textLabel?.text = nameServiseAp.capitalized
            detailTextLabel?.text = textTimeWork + " " + String(timeAtWorkAp).capitalized + textTimeWorkMin +  "\n"  + textTimeReturnWork + " "  + String(timeAtReturnWorkAp).capitalized + textTimeReturnWorkDays
        }
    }
    var textTimeWork = "Execution time:"
    var textTimeReturnWork = "Repeat after:"
    var textTimeWorkMin = " min"
    var textTimeReturnWorkDays = " days"

    lazy var circleView: UIImageView = {
        let circl = UIImageView()
        circl.backgroundColor = UIColor.appColor(.blueAssistantFon)
        circl.layer.borderWidth = 2
        circl.layer.borderColor = UIColor.appColor(.whiteAndPinkDetailsAssistant)?.cgColor
         return circl
     }()
    
    let lineView: UIImageView = {
        let line = UIImageView()
        line.backgroundColor = UIColor.appColor(.whiteAndPinkDetailsAssistant)
         return line
     }()
    
    var priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "0"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor.appColor(.whiteAssistant)!
         return label
     }()
    
    var priceNameCurrencyLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "$"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor.appColor(.whiteAssistant)!
         return label
     }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .blue
        textLabel?.text = ""
        detailTextLabel?.text = ""
        addSubview(lineView)
        
        lineView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil,pading: .init(top: -5, left: frame.width/3, bottom: 0, right: 50),size: .init(width: 1, height: 85))
   
        addSubview(circleView)
        
        circleView.anchor(top: nil , leading: lineView.leadingAnchor, bottom: nil, trailing: nil,pading: .init(top: 0, left: -5.5, bottom: 0, right: 0),size: .init(width: 11, height: 11))
        circleView.layer.cornerRadius = 11/2
        circleView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(priceNameCurrencyLabel)
              priceNameCurrencyLabel.anchor(top: nil , leading: nil, bottom: nil, trailing: circleView.leadingAnchor,pading: .init(top: 0, left: 0, bottom: 0, right: 15),size: .init(width: 0, height: 11))
              priceNameCurrencyLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        addSubview(priceLabel)
        priceLabel.anchor(top: nil , leading: nil, bottom: nil, trailing: priceNameCurrencyLabel.leadingAnchor,pading: .init(top: 0, left: 0, bottom: 0, right: 3),size: .init(width: 0, height: 11))
        priceLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

    }
 
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textLabel?.frame = CGRect(x: 140, y: textLabel!.frame.origin.y + 10, width: frame.width - 180, height: (textLabel?.frame.height)!)
        detailTextLabel?.frame = CGRect(x: 140, y: textLabel!.frame.origin.y + 17, width: frame.width - 180, height: (detailTextLabel?.frame.height)!)
       
        textLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        textLabel?.textColor = UIColor.appColor(.whiteAssistant)!
        detailTextLabel?.font = UIFont.systemFont(ofSize: 12)
        detailTextLabel?.textColor = UIColor.appColor(.whiteAssistantwithAlpha)!
        detailTextLabel?.numberOfLines = 0
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
