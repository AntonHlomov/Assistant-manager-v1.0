//
//  SliderReminderClientsCell.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 19/01/2022.
//

import UIKit

class SliderReminderClientsCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UINavigationControllerDelegate {
    
    private let cellId = "apCellId"
    private let cellButton = "apCellButtonId"
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupViews()
    }
  
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - оформление ячейки слайдера

    
    let zigzag180ContainerView = SketchBorderView()
    
    let boxViewBlue: UIImageView = {
        let line = UIImageView()
        line.backgroundColor = UIColor.rgb(red: 31, green: 152, blue: 233)
        return line
     }()
    
    let appsCollectionView: UICollectionView = {
        
    let layout = UICollectionViewFlowLayout()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 115)
        layout.sectionInset = UIEdgeInsets(top: 30, left: 2, bottom: 5, right: 0)
        
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
        appsCollectionView.register(AppCellСlReminder.self, forCellWithReuseIdentifier: cellId)
        
        appsCollectionView.register(ButtonCell.self, forCellWithReuseIdentifier: cellButton)
        appsCollectionView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, pading: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 125))
        
    
         addSubview(boxViewBlue)
         boxViewBlue.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor,  trailing: trailingAnchor, pading: .init(top: 0, left: 0, bottom: -2,  right: 0),size: .init(width: frame.width, height: 20))
         centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    
         addSubview(zigzag180ContainerView)
        zigzag180ContainerView.anchor(top: appsCollectionView.bottomAnchor, leading: leadingAnchor, bottom:  bottomAnchor, trailing: trailingAnchor, pading: .init(top: 10,  left: -10, bottom: -10, right: -10),size: .init(width: 0 , height: 0))
        
    }
    // MARK: - Ячейки
         func numberOfSections(in collectionView: UICollectionView) -> Int {
              // #warning Incomplete implementation, return the number of sections
              return 2
          }
    // убераем разрыв между вью по горизонтали
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
       
        return 5
    }
   
    
         func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
             switch indexPath.section {
             case 0:
                 let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellButton, for: indexPath) as! ButtonCell
                
                 
                 return cell
             case 1:
                 let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppCellСlReminder
                
                 return cell
    
             default:
                 let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppCellСlReminder
                 
                 return cell
             }
             
         }
    
         func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
             switch section {
             case 0: return 1
             case 1:  return 10
             default: return 0
             }
         }
    
     
    
          // нажатие на ячейки напоминания
          func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          }
    
    
    // MARK: - class AppCellСlReminder
    
class AppCellСlReminder: UICollectionViewCell {
    
    var client: Client?{
        didSet{
            
            imageView.loadImage(with: client?.profileImageClientUrl ?? "")
            guard let clientname = client?.nameClient else {return}
            guard let fullname = client?.fullName else {return}
            nameLebel.text = clientname.capitalized + "\n" + fullname.capitalized

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
        iv.layer.cornerRadius = 80.0/2.0
        iv.layer.masksToBounds = true

        return iv
    }()
        
    lazy var reminderSign: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = UIColor(white: 0, alpha: 0.8)
        return button
    }()

    let nameLebel: UILabel = {
        let Label = UILabel()
        Label.text = "Имя Клиента"
        Label.textAlignment = .center
        Label.textColor = .darkGray
        Label.font = UIFont.boldSystemFont(ofSize: 14)
        Label.numberOfLines = 2
        return Label
    }()
  
    func setupViews(){
            
            addSubview(imageView)
            imageView.anchor(top: topAnchor, leading: nil, bottom: nil,trailing: nil, pading: .init(top: 0, left: 0, bottom: 0,right: 0), size: .init(width: 80, height: 80))
            imageView.centerXAnchor.constraint(equalTo:centerXAnchor).isActive = true
            
            addSubview(reminderSign)
            reminderSign.anchor(top: imageView.topAnchor, leading: nil,bottom: nil, trailing: imageView.trailingAnchor, pading:.init(top: -8, left: -8, bottom: 0, right: 0), size:.init(width: 22, height: 22))
            
            addSubview(nameLebel)
            nameLebel.anchor(top: imageView.bottomAnchor, leading: nil,bottom: nil, trailing: nil, pading: .init(top: 3, left: 0,bottom: 0, right: 0), size: .init(width: frame.size.width + 5,height: 0))
            nameLebel.centerXAnchor.constraint(equalTo:centerXAnchor).isActive = true
        }
    }
    class ButtonCell: UICollectionViewCell {
        
    
        override init(frame: CGRect) {
            super .init(frame: frame)
            setupViews()
        }
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        lazy var clientButton: UIButton = {
            let button = UIButton(type: .system)
            button.setImage(#imageLiteral(resourceName: "buttonAddCL").withRenderingMode(.alwaysOriginal), for: .normal)
            return button
        }()
            
        let nameLebelCB: UILabel = {
            let Label = UILabel()
            Label.text = "Add"
            Label.textAlignment = .center
            Label.textColor = UIColor.rgb(red: 31, green: 152, blue: 233)
            Label.font = UIFont.boldSystemFont(ofSize: 14)
            Label.numberOfLines = 1
            return Label
        }()
      
        func setupViews(){
            
            addSubview(clientButton)
            clientButton.anchor(top: topAnchor, leading: nil, bottom: nil,trailing: nil, pading: .init(top: 0, left: 0, bottom: 0,right: 0), size: .init(width: 80, height: 80))
            clientButton.centerXAnchor.constraint(equalTo:centerXAnchor).isActive = true
           
            addSubview(nameLebelCB)
            nameLebelCB.anchor(top: clientButton.bottomAnchor, leading: nil,bottom: nil, trailing: nil, pading: .init(top: 3, left: 0,bottom: 0, right: 0), size: .init(width: frame.size.width + 5,height: 0))
            nameLebelCB.centerXAnchor.constraint(equalTo:centerXAnchor).isActive = true
                
            }
        }
    
    
    
          
    
    
    
    
    
    
    
    
    
    
}
