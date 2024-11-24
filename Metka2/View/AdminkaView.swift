//
//  AdminkaView.swift
//  Metka2
//
//  Created by Vladislav Andreev on 23.11.2024.
//

import Foundation
import SwiftUI

struct AdminkaView: View {
    
    @EnvironmentObject var env_Nav: Env_Nav
    
    var body: some View {
        ZStack {
            // Фон экрана
            Consts.Colors.Green_11
                .ignoresSafeArea()
            
            VStack {
                Consts.Images.Logo
                    .resizable()
                    .scaledToFit()
                Spacer()
            }
            .padding(.top, 30)
            
            VStack {
               
                Spacer()
                // Белый блок
                VStack(alignment: .center) {
                    
                    ZStack {
                        VStack(spacing: 50) {
                            Button(action: {
                                
                            }) {
                                Text("Офисы")
                                    .font(Font.custom(Consts.Fonts.Regular, size: 24))
                                    .foregroundColor(Consts.Colors.black)
                                    .multilineTextAlignment(.center)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .frame(height: 58)
                                    .background(Consts.Colors.Gray_C9)
                                    .cornerRadius(20)
                            }
                            .background(
                                ZStack {
                                    Rectangle()
                                        .fill(Consts.Colors.Gray_C9)
                                        .cornerRadius(58)
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Consts.Colors.black, lineWidth: 2)
                                    
                                    
                                }
                            )
                            
                            Button(action: {
                                self.env_Nav.Tab_Selection = 8
                            }) {
                                Text("Сотрудники")
                                    .font(Font.custom(Consts.Fonts.Regular, size: 24))
                                    .foregroundColor(Consts.Colors.black)
                                    .multilineTextAlignment(.center)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .frame(height: 58)
                                    .background(Consts.Colors.Gray_C9)
                                    .cornerRadius(20)
                            }
                            .background(
                                ZStack {
                                    Rectangle()
                                        .fill(Consts.Colors.Gray_C9)
                                        .cornerRadius(58)
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Consts.Colors.black, lineWidth: 2)
                                    
                                    
                                }
                            )
                            
                            Button(action: {
                                self.env_Nav.Tab_Selection = 9
                            }) {
                                Text("Оборудование")
                                    .font(Font.custom(Consts.Fonts.Regular, size: 24))
                                    .foregroundColor(Consts.Colors.black)
                                    .multilineTextAlignment(.center)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .frame(height: 58)
                                    .background(Consts.Colors.Gray_C9)
                                    .cornerRadius(20)
                            }
                            .background(
                                ZStack {
                                    Rectangle()
                                        .fill(Consts.Colors.Gray_C9)
                                        .cornerRadius(58)
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Consts.Colors.black, lineWidth: 2)
                                    
                                    
                                }
                            )
                            
                        }
                        .padding(.horizontal)
                        
                    }
                    
                }
                .frame(maxWidth: .infinity) // Растягиваем по ширине
                .frame(minHeight: 556) // Минимальная высота блока
                .background(Consts.Colors.Gray_C9) // Цвет фона белый
                .cornerRadius(22) // Закругление углов
                .ignoresSafeArea()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .ignoresSafeArea()
    }
    
}



