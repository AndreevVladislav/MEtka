//
//  UC_TechniqueItem.swift
//  Metka2
//
//  Created by Vladislav Andreev on 23.11.2024.
//

import Foundation
import SwiftUI

struct UC_TechniqueItem: View {
    
    @State public var tech: ModelTechniqueSave;
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                
                HStack {
                    VStack(alignment: .leading, spacing: 8){
                    
                    Text("\(tech.name)")
                            .font(Font.custom(Consts.Fonts.Light, size: 18))
                            .padding(.leading, -15)
                            .multilineTextAlignment(.leading)
                            .frame(alignment: .leading)
                    Text("Тип: \(tech.type)")
                            .font(Font.custom(Consts.Fonts.Light, size: 18))
                    Text("ID: \(tech.techID)")
                            .font(Font.custom(Consts.Fonts.Light, size: 18))
                    Text("Кабинет: \(tech.cabinetID)")
                            .font(Font.custom(Consts.Fonts.Light, size: 18))
                        
                    }
                    Spacer()
                    
                }
                .padding(.leading, 60)
                .frame(maxWidth: .infinity)
            }
            .padding()
            .background(
                ZStack {
                    Rectangle()
                        .fill(Consts.Colors.Gray_C9)
                        .cornerRadius(20)
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Consts.Colors.black, lineWidth: 2)
                    
                    
                }
            )
            .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    UC_TechniqueItem(tech: ModelTechniqueSave(
        techID: 100001,
        name: "название техники",
        type: "тип товара",
        os: "ос товара",
        made: "производитель",
        status: "статус",
        officeID: 1,
        cabinetID: 200001))
}
