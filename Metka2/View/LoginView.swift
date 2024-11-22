//
//  LoginView.swift
//  Metka2
//
//  Created by Vladislav Andreev on 22.11.2024.
//

import Foundation
import SwiftUI

struct LoginView: View {
    
    /// Поля ввода
    private enum E_Field: Hashable {
        
        /// Номер телефона
        case Password;
        
        /// Email
        case Email;
    }
    
    /// Активное поле ввода
    @FocusState private var focusState: E_Field?;
    
    /// Значение поля ввода "Password"
    @State private var string_Password: String = "";
    
    /// Ошибка поля ввода "Password"
    @State private var flag_PasswordError: Bool = false;
    
    /// Значение поля ввода "Email"
    @State private var string_Email: String = "";
    
    /// Ошибка поля ввода "Email"
    @State private var flag_EmailError: Bool = false;
    
    var body: some View {
        ZStack {
            // Фон экрана
            Consts.Colors.Green_11
                .ignoresSafeArea()

            VStack {
                VStack {
                    Consts.Images.Logo
                        .resizable()
                        .scaledToFit()
                }
                .padding(.top, 40)
                .padding(.bottom, 20)
                
                // Белый блок
                VStack(alignment: .center) {
                    // Содержимое белого блока
                    Text("Авторизация")
                        .foregroundColor(.black)
                        .font(Font.custom(Consts.Fonts.Regular, size: 32))
                        .padding(.top, 60)
                        .padding(.bottom, 25)
                    
                
                    Text("Войдите в свою учетную запись")
                        .foregroundColor(.black)
                        .font(Font.custom(Consts.Fonts.UltraLight, size: 20))
                        .multilineTextAlignment(.center)
                    
                    VStack {
                        TextField("", text: self.$string_Email)
                            .padding(15)
                            .disableAutocorrection(true)
                            .focused(self.$focusState, equals: .Email)
                            .font(Font.custom(Consts.Fonts.Regular, size: 14))
                            .foregroundColor(self.flag_EmailError ? Consts.Colors.error : Consts.Colors.black)
                            .placeholder(when: self.string_Email.isEmpty) {
                                ZStack {
                                    Text(verbatim: " Email ")
                                        .padding(15)
                                        .font(Font.custom(Consts.Fonts.Regular, size: 14))
                                        .foregroundColor(self.flag_EmailError ? Consts.Colors.error : Consts.Colors.black)
                                }
                            }
                            .onChange(of: self.string_Email) { newValue in
                                self.flag_EmailError = false;
                            }
                        
                            .background(
                                ZStack {
                                    Rectangle()
                                        .fill(Consts.Colors.Gray_C9)
                                        .cornerRadius(8)
                                    if (self.flag_EmailError) {
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Consts.Colors.error, lineWidth: 1)
                                    } else {
                                        if (self.focusState == .Email) {
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(Consts.Colors.Green_11, lineWidth: 1)
                                        } else {
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(Consts.Colors.black, lineWidth: 1)
                                        }
                                    }
                                }
                            )
                            .onTapGesture {
                                self.focusState = .Email;
                            }
                    }
                    .padding()
                    
                    VStack {
                        TextField("", text: self.$string_Password)
                            .padding(15)
                            .disableAutocorrection(true)
                            .focused(self.$focusState, equals: .Password)
                            .font(Font.custom(Consts.Fonts.Regular, size: 14))
                            .foregroundColor(self.flag_PasswordError ? Consts.Colors.error : Consts.Colors.black)
                            .placeholder(when: self.string_Password.isEmpty) {
                                ZStack {
                                    Text(verbatim: " Email ")
                                        .padding(15)
                                        .font(Font.custom(Consts.Fonts.Regular, size: 14))
                                        .foregroundColor(self.flag_EmailError ? Consts.Colors.error : Consts.Colors.black)
                                }
                            }
                            .onChange(of: self.string_Email) { newValue in
                                self.flag_EmailError = false;
                            }
                        
                            .background(
                                ZStack {
                                    Rectangle()
                                        .fill(Consts.Colors.Gray_C9)
                                        .cornerRadius(20)
                                    if (self.flag_EmailError) {
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Consts.Colors.error, lineWidth: 1)
                                    } else {
                                        if (self.focusState == .Email) {
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(Consts.Colors.Green_11, lineWidth: 1)
                                        } else {
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(Consts.Colors.black, lineWidth: 1)
                                        }
                                    }
                                }
                            )
                            .onTapGesture {
                                self.focusState = .Email;
                            }
                    }
                    .padding()
                        
                    
                }
//                .frame(height: 556) // Высота 556
                .frame(maxWidth: .infinity, maxHeight: .infinity) // Растягиваем по ширине
                .background(Consts.Colors.Gray_C9) // Цвет фона белый
                .cornerRadius(22) // Закругление углов
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            .ignoresSafeArea()
        }
    }
}

