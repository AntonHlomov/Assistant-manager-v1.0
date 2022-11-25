//
//  User.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 14/01/2022.
//


import Foundation

class User {
    
    var uid: String!
    var name: String!
    var fullName: String!
    var profileImage: String!
    var email: String!

    var lastСheckNumber: Int!
    
    var statusBoss: Bool!
    var statusAdministrator: Bool!
    var statusMaster: Bool!
    
    var clientsCount: Int!
    var priceCount: Int!
    var checkCount: Int!
    var teamCount: Int!
    
  //  var whoIsBossId: String!
   // var whoIsAdministrator: String!
    
    var statusInGroup: String! // Boss / Administrator / Master / Individual
    var hiddenStatus: String! // Any / Individual
    var idGroup: String!
    
    // пременные для запроса на добавления в группу
    var markerRequest: Bool!
    var idGroupRequest: String!
    var idUserRequest: String!
    var profileImageUserRequest: String!
    var nameRequest: String!
    var fullNameRequest: String!
    var statusInGroupRequest: String!
    
    

    

    init(dictionary: [String: Any]) {
        
        self.lastСheckNumber = dictionary["lastСheckNumber"] as? Int ?? nil
        self.name = dictionary["name"] as? String ?? ""
        self.profileImage = dictionary["profileImageUrl"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.fullName = dictionary["fullName"] as? String ?? ""
     
       // self.statusBoss = dictionary["statusBoss"] as? Bool ?? nil
       // self.statusAdministrator = dictionary["statusAdministrator"] as? Bool ?? nil
       // self.statusMaster = dictionary["statusMaster"] as? Bool ?? nil
        self.clientsCount = dictionary["clientsCount"] as? Int ?? nil
        self.priceCount = dictionary["priceCount"] as? Int ?? nil
        self.checkCount = dictionary["checkCount"] as? Int ?? nil
        self.teamCount = dictionary["teamCount"] as? Int ?? nil
        
      //  self.whoIsBossId = dictionary["whoIsBossId"] as? String ?? ""
      //  self.whoIsAdministrator = dictionary["whoIsAdministrator"] as? String ?? ""
        
        self.statusInGroup = dictionary["statusInGroup"] as? String ?? ""
        self.idGroup = dictionary["idGroup"] as? String ?? ""
        self.hiddenStatus = dictionary["hiddenStatus"] as? String ?? ""
        
        self.markerRequest = dictionary["markerRequest"] as? Bool ?? nil
        self.idGroupRequest = dictionary["idGroupRequest"] as? String ?? ""
        self.idUserRequest = dictionary["idUserRequest"] as? String ?? ""
        self.profileImageUserRequest = dictionary["profileImageUserRequest"] as? String ?? ""
        self.nameRequest = dictionary["nameRequest"] as? String ?? ""
        self.fullNameRequest = dictionary["fullNameRequest"] as? String ?? ""
        self.statusInGroupRequest = dictionary["statusInGroupRequest"] as? String ?? ""
       
    }
}

