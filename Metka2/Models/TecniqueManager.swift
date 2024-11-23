//
//  TecniqueManager.swift
//  Metka2
//
//  Created by Vladislav Andreev on 23.11.2024.
//

import Foundation
import Combine

class TecniqueManager: ObservableObject {
    
    static let shared = UserInfoManager()
    
    @Published var list_Tecnique: [ModelTechniqueSave] = []
}
