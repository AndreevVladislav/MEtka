//
//  MyTechnique.swift
//  Metka2
//
//  Created by Vladislav Andreev on 23.11.2024.
//

import Foundation
import SwiftUI

struct MyTechnique: View {
    @EnvironmentObject var env_Nav: Env_Nav
    
    private let apiUtils = ApiUtils()
    
    @ObservedObject var tecniqueManager = TecniqueManager.shared
    
    @State private var list_tech = [ModelTechniqueSave]()
    
    var body: some View {
        ZStack {
            Consts.Colors.Gray_C9
                .ignoresSafeArea()
            VStack {
                ZStack {
                    HStack {
                        Text("Мое оборудование")
                            .font(Font.custom(Consts.Fonts.Regular, size: 32))
                            .foregroundStyle(Consts.Colors.black)
                    }
                    
                    HStack {
                        Button(action: {
                            self.env_Nav.Tab_Selection = 0
                        }) {
                            Consts.Images.ic_buttonBack
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                        }
                        Spacer()
                    }
                    .padding(.leading, 10)
                }
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        // Используем list_Tecnique напрямую
                        ForEach(self.list_tech) { tech in
                            UC_TechniqueItem(tech: tech)
                        }
                    }
                    .padding(.horizontal)
                }
                Spacer()
            }
        }
        .onAppear {
           
            self.apiUtils.fetchAllTechniques { result in
                switch result {
                case .success(let techniques):
                    var list_t: [ModelTechniqueSave] = []
                    for technique in techniques {
                        print("Техника ID: \(technique.techID), Название: \(technique.name), Тип: \(technique.type), ОС: \(technique.os)")
                        list_t.append(ModelTechniqueSave(
                            id: UUID(),
                            techID: technique.techID,
                            name: technique.name,
                            type: technique.type,
                            os: technique.os,
                            made: technique.made,
                            status: technique.status,
                            officeID: technique.officeID,
                            cabinetID: technique.cabinetID))
                    }
                    self.list_tech = list_t
                case .failure(let error):
                    // Если произошла ошибка, выводим её в консоль
                    print("Ошибка при получении техник: \(error.localizedDescription)")
                }
            }
        }
    }
}

#Preview {
    MyTechnique()
}
