//
//  MastersScheduleTableViewCell.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 12/06/2022.
//
import UIKit
class MastersScheduleTableViewCell: UITableViewCell {
    var customerRecord: CustomerRecord?{
        didSet{
            imageClient.loadImage(with: customerRecord?.profileImageClient ?? "")
            guard let clientname = customerRecord?.nameClient else {return}
            guard let fullname = customerRecord?.fullNameClient else {return}
            guard let timeStart = customerRecord?.dateTimeStartService else {return}
            guard let timeEnd = customerRecord?.dateTimeEndService else {return}
            nameLabelClient.text = clientname.capitalized + (" ") + fullname.capitalized
            timeStartLabel.text = String(timeStart.dropFirst(11))
            timeEndLabel.text = String(timeEnd.dropFirst(11))
        }
    }
    let circleView: UIImageView = {
        let circl = UIImageView()
        circl.backgroundColor = UIColor.appColor(.whiteAssistantFon)
        circl.layer.borderWidth = 2
        circl.layer.borderColor = UIColor.appColor(.whiteForDarkDarkForWhiteText)?.cgColor
         return circl
     }()
    let imageClient = CustomUIimageView(frame: .zero)
    
    let lineView: UIImageView = {
        let line = UIImageView()
        line.backgroundColor = UIColor.appColor(.whiteForDarkDarkForWhiteText)
         return line
     }()
    let timeStartLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "10:00"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor.appColor(.whiteForDarkDarkForWhiteText)
         return label
     }()
    let lineTimeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "-"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor.appColor(.whiteForDarkDarkForWhiteText)
         return label
     }()
    let timeEndLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "12:00"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor.appColor(.whiteForDarkDarkForWhiteText)
         return label
     }()
    let nameLabelClient: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Ivan Ivancov"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor.appColor(.whiteForDarkDarkForWhiteText)
        label.numberOfLines = 0
         return label
     }()
    let serviesLabelClient: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.appColor(.whiteForDarkDarkForWhiteText)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
         return label
     }()
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
       // selectionStyle = .blue
        addSubview(lineView)
        lineView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil,pading: .init(top: -5, left: 150, bottom: 0, right: 50),size: .init(width: 1, height: 0))
        addSubview(circleView)
        circleView.anchor(top: topAnchor , leading: lineView.leadingAnchor, bottom: nil, trailing: nil,pading: .init(top: 17, left: -10, bottom: 0, right: 0),size: .init(width: 20, height: 20))
        circleView.layer.cornerRadius = 20/2
        addSubview(imageClient)
        imageClient.anchor(top: circleView.topAnchor , leading: circleView.leadingAnchor, bottom: nil, trailing: nil,pading: .init(top: 2, left: 2, bottom: 0, right: 0),size: .init(width: 16, height: 16))
        imageClient.layer.cornerRadius = 16/2
        addSubview(timeEndLabel)
        timeEndLabel.anchor(top:circleView.topAnchor , leading: nil, bottom: nil, trailing: circleView.leadingAnchor,pading: .init(top: 0, left: 0, bottom: 0, right: 20),size: .init(width: 0, height: 0))
        addSubview(lineTimeLabel)
        lineTimeLabel.anchor(top: circleView.topAnchor  , leading: nil, bottom: nil, trailing: timeEndLabel.leadingAnchor,pading: .init(top: 0, left: 0, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        addSubview(timeStartLabel)
        timeStartLabel.anchor(top: circleView.topAnchor  , leading: nil, bottom: nil, trailing: lineTimeLabel.leadingAnchor,pading: .init(top: 0, left: 0, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        addSubview(nameLabelClient)
        nameLabelClient.anchor(top: topAnchor , leading:lineView.trailingAnchor, bottom: nil, trailing: nil,pading: .init(top: 15, left: 20, bottom: 0, right: 0),size: .init(width: 0, height: 0))
        addSubview(serviesLabelClient)
        serviesLabelClient.anchor(top: nameLabelClient.bottomAnchor , leading:lineView.trailingAnchor, bottom: bottomAnchor, trailing: nil,pading: .init(top: 5, left: 23, bottom: 0, right: 0),size: .init(width: 0, height: 0))
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        self.circleView.layer.borderColor = UIColor.appColor(.whiteForDarkDarkForWhiteText)?.cgColor
    }
    override func layoutSubviews() {
        super.layoutSubviews()
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
