//
//  TecniqueManager.swift
//  Metka2
//
//  Created by Vladislav Andreev on 23.11.2024.
//

import Foundation
import Combine

class TecniqueManager: ObservableObject {
    
    static let shared = TecniqueManager()
    
    @Published var list_Tecnique: [ModelTechniqueSave] = []
    
    @Published var flag_openTech = false
    
    @Published var selectTech = ModelTechniqueSave()
    
    @Published var fake_email = ""
}
