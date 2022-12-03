//
//  Client.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 14/01/2022.
//
import Foundation

class Client {
    var idClient: String!
    var idUserWhoWrote: String!
    var nameClient: String!
    var fullName: String!
    var dateAddClient: String!
    var telefonClient: String!
    var profileImageClientUrl: String!
    var genderClient:String!
    var ageClient:Int!
    var countVisits:Int!
    var textAboutClient: String!
    var sumTotal:Double!
    var remoteClient: Bool!

    init(dictionary: [String: Any]) {

        self.dateAddClient = dictionary["dateAddClient"] as? String ?? ""
        self.fullName = dictionary["fullName"] as? String ?? ""
        self.idClient = dictionary["idClient"] as? String ?? ""
        self.idUserWhoWrote = dictionary["idUserWhoWrote"] as? String ?? ""
        self.nameClient = dictionary["nameClient"] as? String ?? ""
        self.profileImageClientUrl = dictionary["profileImageClientUrl"] as? String ?? ""
        self.telefonClient = dictionary["telefonClient"] as? String ?? ""
        self.textAboutClient = dictionary["textAboutClient"] as? String ?? ""
        self.genderClient = dictionary["genderClient"] as? String ?? ""
        self.ageClient = dictionary["ageClient"] as? Int ?? nil
        self.countVisits = dictionary["countVisits"] as? Int ?? nil
        self.sumTotal = dictionary["sumTotal"] as? Double ?? nil
        self.remoteClient = dictionary["remoteClient"] as? Bool ?? nil
    }
}
