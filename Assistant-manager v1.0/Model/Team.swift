//
//  Team.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 14/01/2022.
//
import Foundation


class Team {
    
    var id: String!
    var categoryTeamMember: String!
    var idTeamMember: String!
    var nameTeamMember: String!
    var surnameTeamMember: String!
    var telefonTeamMember: String!
    var profileImageURLTeamMember: String!
    
    init(dictionary: [String: Any]) {
        
        self.id = dictionary["id"] as? String ?? ""
        self.categoryTeamMember = dictionary["categoryTeamMember"] as? String ?? ""
        self.idTeamMember = dictionary["idTeamMember"] as? String ?? ""
        self.nameTeamMember = dictionary["nameTeamMember"] as? String ?? ""
        self.surnameTeamMember = dictionary["surnameTeamMember"] as? String ?? ""
        self.telefonTeamMember = dictionary["telefonTeamMember"] as? String ?? ""
        self.profileImageURLTeamMember = dictionary["profileImageURLTeamMember"] as? String ?? ""
    }
}
