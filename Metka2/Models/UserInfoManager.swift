//
//  UserInfoManager.swift
//  Metka2
//
//  Created by Vladislav Andreev on 23.11.2024.
//

import Foundation
import Combine

class UserInfoManager: ObservableObject {
    
    static let shared = UserInfoManager()
    
    var clientID: Int?
    
    var avatar: String?
    
    var email: String?
    
    var position: String?
    
    var grade: String?
    
    var cabinetID: Int?
    
    var fio: String?
    
    var officeID: Int?
    
    var flag_isAdmin: Int?
}
