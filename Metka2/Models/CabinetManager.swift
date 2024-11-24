//
//  CabinetManager.swift
//  Metka2
//
//  Created by Vladislav Andreev on 24.11.2024.
//

import Foundation
import Combine

class CabinetManager: ObservableObject {
    
    static let shared = CabinetManager()
    
    @Published var flag_openCabinet = false
    
    @Published var selectTech = ModelCabinetSave()
}
