//
//  ProfileView.swift
//  Metka2
//
//  Created by Vladislav Andreev on 22.11.2024.
//

import Foundation
import SwiftUI

struct ProfileView: View {
    
    var body: some View {
        ZStack {
            // Фон экрана
            Consts.Colors.Green_11
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Consts.Colors.Gray_C9
                    .frame(height: 300)
                    .frame(maxWidth: .infinity)
            }
            .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack {
                    // Логотип
                    VStack {
                        Consts.Images.Logo
                            .resizable()
                            .scaledToFit()
                    }
                    .padding(.top, 40)
                    .padding(.bottom, 20)
                    
                    // Белый блок
                    VStack(alignment: .center) {
                                                
                        Spacer() // Добавляем Spacer, чтобы белый блок растянулся
                    }
                    .frame(maxWidth: .infinity) // Растягиваем по ширине
                    .frame(minHeight: 556) // Минимальная высота блока
                    .background(Consts.Colors.Gray_C9) // Цвет фона белый
                    .cornerRadius(22) // Закругление углов
                    .ignoresSafeArea()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
