//
//  PaymentPriceTableViewCell.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 17/07/2022.
//
import UIKit

class PaymentPriceTableViewCell: UITableViewCell {
   var price: Price?{
       didSet{
           guard let nameServiseAp = price?.nameServise else {return}
           guard let priceServiesAp = price?.priceServies else {return}
           priceLabel.text = String(priceServiesAp).capitalized
           nameService.text = nameServiseAp.capitalized
       }
   }
  var nameService: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Servise"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor.appColor(.whiteAssistant)!
         return label
     }()
    var priceNameCurrencyLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = String.appCurrency(.symbolSistem)
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor.appColor(.whiteAssistant)!
         return label
     }()
    
    var priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "56457570"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor.appColor(.whiteAssistant)!
         return label
     }()
    lazy var stackTotal = UIStackView(arrangedSubviews: [priceLabel, priceNameCurrencyLabel])
    lazy var stackPrice = UIStackView(arrangedSubviews: [nameService, stackTotal])
    override func awakeFromNib() {
        super.awakeFromNib()        
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configureCell(){
        stackTotal.axis = .horizontal
        stackTotal.spacing = 3
        stackTotal.distribution = .fillProportionally
        stackPrice.axis = .horizontal
        stackPrice.distribution = .equalCentering
        addSubview(stackPrice)
        stackPrice.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, pading: .init(top: 5, left: 15, bottom: 0, right: 10), size: .init(width: 0, height: 0))
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
