//
//  ModelCabinet.swift
//  Metka2
//
//  Created by Vladislav Andreev on 24.11.2024.
//

import Foundation
import FirebaseFirestore

struct ModelCabinet: Codable, Identifiable {
    @DocumentID var id: String?
    var cabinetID: Int
    var name: String
    var type: String
    var peoples: [UserInfo]
    var techniques: [ModelTechnique]
}

struct ModelCabinetSave: Codable, Identifiable {
    
    var id: UUID = UUID()
    var cabinetID: Int?
    var name: String?
    var type: String?
    var peoples: [UserInfo]?
    var techniques: [ModelTechnique]?
}
