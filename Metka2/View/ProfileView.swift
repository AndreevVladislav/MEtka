//
//  ProfileView.swift
//  Metka2
//
//  Created by Vladislav Andreev on 22.11.2024.
//

import Foundation
import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var env_Nav: Env_Nav
    
    @State private var flag_showAdmin = false
    
    private let apiUtils = ApiUtils()
    
    @ObservedObject var userInfoManager = UserInfoManager.shared
    
    @State private var flag_PresentLogin = false
    
    @State private var position = ""
    
    var body: some View {
        ZStack {
            // Фон экрана
            Consts.Colors.Green_11
                .ignoresSafeArea()
            
            VStack {
                Consts.Images.avatar
                    .resizable()
                    .scaledToFit()
                Spacer()
            }
            
            VStack {
                Spacer()
                // Белый блок
                VStack(alignment: .center) {
                    
                    
                    ZStack {
                        HStack {
                            Button(action: {
                                self.flag_showAdmin = true
                            }) {
                                Text("\(getFirstName(from: self.userInfoManager.fio ?? "error error") ?? "error")")
                                    .foregroundColor(.black)
                                    .font(Font.custom(Consts.Fonts.Regular, size: 32))
                                //                        .padding(.top, -30)
                                    
                            }
                        }
                        
                        HStack {
                            Spacer()
                            Button(action: {
                                let defaults = UserDefaults.standard
                                defaults.removeObject(forKey: "UserInfo")
                                self.flag_PresentLogin = true
                            }) {
                                Consts.Images.ic_logout
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                            }
                        }
                        .padding(.trailing)
                    }
                    .padding(.bottom, 25)
                    
                    Text("\(self.userInfoManager.position ?? "error")")
                        .foregroundColor(.black)
                        .font(Font.custom(Consts.Fonts.UltraLight, size: 20))
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 10)

                    VStack(spacing: 30) {
                        
                        if self.userInfoManager.flag_isAdmin == 1 {
                            Button(action: {
                                self.env_Nav.Tab_Selection = 7
                            }) {
                                Text("Админ-панель")
                                    .font(Font.custom(Consts.Fonts.UltraLight, size: 24))
                                    .foregroundColor(Consts.Colors.Green_51)
                                    .multilineTextAlignment(.center)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .frame(height: 48)
                                    .background(Consts.Colors.Gray_C9)
                                    .cornerRadius(20)
                            }
                            .background(
                                ZStack {
                                    Rectangle()
                                        .fill(Consts.Colors.Gray_C9)
                                        .cornerRadius(20)
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Consts.Colors.Green_51, lineWidth: 2)
                                    
                                    
                                }
                            )
                        }
                        
                        Button(action: {
                            self.env_Nav.Tab_Selection = 3
                        }) {
                            Text("Мое оборудование")
                                .font(Font.custom(Consts.Fonts.UltraLight, size: 24))
                                .foregroundColor(Consts.Colors.black)
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .frame(height: 48)
                                .background(Consts.Colors.Gray_C9)
                                .cornerRadius(20)
                        }
                        .background(
                            ZStack {
                                Rectangle()
                                    .fill(Consts.Colors.Gray_C9)
                                    .cornerRadius(20)
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Consts.Colors.black, lineWidth: 2)
                                
                                
                            }
                        )
                        
                        Button(action: {
                            self.env_Nav.Tab_Selection = 4
                        }) {
                            Text("Мой офис")
                                .font(Font.custom(Consts.Fonts.UltraLight, size: 24))
                                .foregroundColor(Consts.Colors.black)
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .frame(height: 48)
                                .background(Consts.Colors.Gray_C9)
                                .cornerRadius(20)
                        }
                        .background(
                            ZStack {
                                Rectangle()
                                    .fill(Consts.Colors.Gray_C9)
                                    .cornerRadius(20)
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Consts.Colors.black, lineWidth: 2)
                                
                                
                            }
                        )
                        
                        Button(action: {
                            self.env_Nav.Tab_Selection = 5
                        }) {
                            Text("Метка")
                                .font(Font.custom(Consts.Fonts.UltraLight, size: 24))
                                .foregroundColor(Consts.Colors.black)
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .frame(height: 48)
                                .background(Consts.Colors.Gray_C9)
                                .cornerRadius(20)
                        }
                        .background(
                            ZStack {
                                Rectangle()
                                    .fill(Consts.Colors.Gray_C9)
                                    .cornerRadius(20)
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Consts.Colors.black, lineWidth: 2)
                                
                                
                            }
                        )
                        
                        
                        
                    }
                    .padding()
                    .padding(.bottom, 20)

                    
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
        .onAppear {
            if self.userInfoManager.flag_isAdmin == 0 {
                self.flag_showAdmin = false
            } else {
                self.flag_showAdmin = true
            }
            
//            self.apiUtils.fetchUserDataByClientID(clientID: self.userInfoManager.clientID) { user in
//                if let user = user {
//                    
//                } else {
//                    print("Пользователь не найден")
//                }
//            }
           
        }
//        .sheet(isPresented: $flag_showAdmin) {
//            AdminkaView()
//        }
        .fullScreenCover(isPresented: $flag_PresentLogin) {
            LoginView()
        }
    }
      
    private func getFirstName(from fullName: String) -> String? {
        // Разбиваем строку по пробелу
        let components = fullName.split(separator: " ")
        
        // Проверяем, что в строке есть хотя бы два слова (фамилия и имя)
        if components.count >= 2 {
            // Возвращаем имя, которое будет вторым словом в строке
            return String(components[1])
        }
        
        // Если строка не содержит достаточно данных, возвращаем nil
        return nil
    }
}
