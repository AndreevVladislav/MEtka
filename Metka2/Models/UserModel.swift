//
//  UserModel.swift
//  Metka2
//
//  Created by Vladislav Andreev on 23.11.2024.
//

import Foundation
import FirebaseFirestore

struct UserModel: Codable, Identifiable {
    @DocumentID var id: String?
    var clientID: Int
    var avatar: String
    var email: String
    var position: String
    var grade: String
    var cabinetID: Int
    var fio: String
    var officeID: Int
    var flag_isAdmin: Int
}

struct UserInfo: Codable, Identifiable {
    
    var id: UUID = UUID()
    var clientID: Int
    var avatar: String
    var email: String
    var position: String
    var grade: String
    var cabinetID: Int
    var fio: String
    var officeID: Int
    var flag_isAdmin: Int
}
