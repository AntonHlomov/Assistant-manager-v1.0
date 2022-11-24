//
//  SliderTeamStartWorckCell.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 07/07/2022.
//

import UIKit

class SliderTeamStartWorckCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UINavigationControllerDelegate {
    
    // замыкание предаем инфу для открытие клиентской страницы
    var checkMaster: ((SliderTeamStartWorckCell) -> Void)?
    //передаю в контролер выбронного клиента из раздела напоминаний
    var master: (Team?)
    
    var team: [Team]?
   
    
    private let cellId = "apCellId"
    
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupViews()
        
    }
  
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - оформление ячейки слайдера

    let textEmpty: UILabel = {
        let Label = UILabel()
        Label.textAlignment = .center
        Label.text = ""
        Label.font = UIFont.systemFont(ofSize:18)
        Label.textColor = UIColor.rgb(red: 31, green: 152, blue: 233)
        Label.numberOfLines = 0
        return Label
    }()
    
    
    let boxViewBlue: UIImageView = {
        let line = UIImageView()
        line.backgroundColor = UIColor.rgb(red: 31, green: 152, blue: 233)
        return line
     }()
    
    let appsCollectionView: UICollectionView = {
        
    let layout = UICollectionViewFlowLayout()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 200, height: 90)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
      
    
    return collectionView
    }()
    
    //MARK: - setupViews
    
    func setupViews(){
        
        backgroundColor = UIColor.clear
        addSubview(appsCollectionView)
        appsCollectionView.delegate = self
        appsCollectionView.dataSource = self
        appsCollectionView.register(TeamStartWorckCell.self, forCellWithReuseIdentifier: cellId)
        appsCollectionView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, pading: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 90))
       
        
    
       //  addSubview(boxViewBlue)
       //  boxViewBlue.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor,  trailing: trailingAnchor, pading: .init(top: 0, left: 0, bottom: 0,  right: //0),size: .init(width: frame.width, height: 90))
       //  centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    
        
    }
    // MARK: - Ячейки
    func numberOfSections(in collectionView: UICollectionView) -> Int {
             
              return 1
          }
    // убераем разрыв между вью по горизонтали
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
       
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return   team?.count ?? 0 // count
    }
   
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TeamStartWorckCell
             cell.backgroundColor = UIColor.appColor(.whiteAssistantFon)
             cell.layer.cornerRadius = 20
             cell.team = team?[indexPath.row]
           
             return cell
         }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
             print("нажал\(indexPath.row)")
             let cell = collectionView.cellForItem(at: indexPath)
             cell?.layer.borderWidth = 2
             cell?.layer.borderColor = UIColor.appColor(.pinkAssistant)?.cgColor
             master = team?[indexPath.row]
             checkMaster?(self)
    
            // presenter.pressedMastersChoice(indexPath: indexPath)
         }
      
    public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
             print("отжал\(indexPath.row)")
             let cell = collectionView.cellForItem(at: indexPath)
             cell?.layer.borderWidth = 0
            
         }
      
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
          let customCell = cell as! TeamStartWorckCell
              if customCell.isSelected {
                  cell.layer.borderColor = UIColor.appColor(.pinkAssistant)?.cgColor
                  cell.layer.borderWidth = 2
              } else {
                  cell.layer.borderWidth = 0
              }
         }
    
    

class TeamStartWorckCell: UICollectionViewCell {
    var team: Team?{
        didSet{
           
            imageView.loadImage(with: team?.profileImageURLTeamMember ?? "")
            guard let teamName = team?.nameTeamMember else {return}
            guard let teamFullname = team?.fullnameTeamMember else {return}
            guard let teamProfessionName = team?.professionName else {return}
            guard let categoryTeamMember = team?.categoryTeamMember else {return}
            
            nameShurname.text = teamName.capitalized + (" ") + teamFullname.capitalized
            profession.text = teamProfessionName.capitalized
            status.text = categoryTeamMember.capitalized
        }
    }
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupViews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let  imageView = CustomUIimageView(frame: .zero)
    
    let nameShurname: UILabel = {
        let Label = UILabel()
        Label.text = "Name Shurname"
        Label.textAlignment = .left
        Label.textColor = UIColor.appColor(.whiteForDarkDarkForWhiteText)
        Label.font = UIFont.systemFont(ofSize: 13)
        Label.numberOfLines = 1
        return Label
    }()
    let profession: UILabel = {
        let Label = UILabel()
        Label.text = "Hair staylist"
        Label.textAlignment = .left
        Label.textColor = UIColor.appColor(.whiteForDarkDarkForWhiteText)
        Label.font = UIFont.boldSystemFont(ofSize: 18)
        Label.numberOfLines = 1
        return Label
    }()
    let status: UILabel = {
        let Label = UILabel()
        Label.text = "Master"
        Label.textAlignment = .left
        Label.textColor = UIColor.appColor(.whiteForDarkDarkForWhiteText)
        Label.font = UIFont.systemFont(ofSize: 14)
        Label.numberOfLines = 1
        Label.adjustsFontSizeToFitWidth = true
        return Label
    }()
    lazy var stackNameCityContry = UIStackView(arrangedSubviews: [status])
        
    func setupViews(){

    addSubview(imageView)
        imageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, pading: .init(top: 8, left: 8, bottom: 0, right: 0), size: .init(width: 25, height: 25))
        imageView.layer.cornerRadius = 25/2
   
    addSubview(nameShurname)
        nameShurname.anchor(top: topAnchor, leading: imageView.trailingAnchor, bottom: nil, trailing: nil, pading: .init( top: 7, left: 10, bottom: 0, right: 5), size: .init(width: frame.width-30, height: 0))
   
    addSubview(profession)
        profession.anchor(top: topAnchor, leading: imageView.trailingAnchor, bottom: nil, trailing: nil, pading: .init( top: 33, left: 10, bottom: 0, right: 0), size: .init(width: 0, height: 0))
        profession.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
       
        stackNameCityContry.axis = .horizontal
        stackNameCityContry.spacing = 0
        stackNameCityContry.distribution = .fillEqually  // для корректного отображения
     addSubview(stackNameCityContry)
        stackNameCityContry.anchor(top: profession.bottomAnchor, leading: profession.leadingAnchor, bottom: nil, trailing: profession.trailingAnchor, pading: .init( top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 0))
        stackNameCityContry.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
  }
}
