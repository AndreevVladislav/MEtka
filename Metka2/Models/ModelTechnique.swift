//
//  ModelTechnique.swift
//  Metka2
//
//  Created by Vladislav Andreev on 23.11.2024.
//

import Foundation
import FirebaseFirestore

struct ModelTechnique: Codable, Identifiable {
    @DocumentID var id: String?
    var techID: Int
    var name: String
    var type: String
    var os: String
    var made: String
    var status: String
    var officeID: Int
    var cabinetID: Int
}

struct ModelTechniqueSave: Codable, Identifiable {
    
    var id: UUID = UUID()
    var techID: Int?
    var name: String?
    var type: String?
    var os: String?
    var made: String?
    var status: String?
    var officeID: Int?
    var cabinetID: Int?
}
