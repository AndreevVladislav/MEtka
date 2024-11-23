//
//  LoginView.swift
//  Metka2
//
//  Created by Vladislav Andreev on 22.11.2024.
//

import Foundation
import SwiftUI
import Lottie

struct LoginView: View {
    /// Поля ввода
    private enum E_Field: Hashable {
        case Password
        case Email
    }
    
    /// Активное поле ввода
    @FocusState private var focusState: E_Field?
    
    /// Значение поля ввода "Password"
    @State private var string_Password: String = "securePassword123"
    
    /// Ошибка поля ввода "Password"
    @State private var flag_PasswordError: Bool = false
    
    /// Значение поля ввода "Email"
    @State private var string_Email: String = "test@example.com"
    
    /// Ошибка поля ввода "Email"
    @State private var flag_EmailError: Bool = false
    
    @Environment(\.dismiss) private var dismiss
    
    private let apiUtils = ApiUtils()
    
    @State private var flag_showMain = false
    
    @State private var flag_Loading = false
    
    var body: some View {
        ZStack {
            // Фон экрана
            Consts.Colors.Green_11
                .ignoresSafeArea()
            
//            VStack {
//                Spacer()
//                Consts.Colors.Gray_C9
//                    .frame(height: 300)
//                    .frame(maxWidth: .infinity)
//            }
//            .ignoresSafeArea()
            
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
                        // Заголовки
                        Text("Авторизация")
                            .foregroundColor(.black)
                            .font(Font.custom(Consts.Fonts.Regular, size: 32))
                            .padding(.top, 60)
                            .padding(.bottom, 25)
                        
                        Text("Войдите в свою учетную запись")
                            .foregroundColor(.black)
                            .font(Font.custom(Consts.Fonts.UltraLight, size: 20))
                            .multilineTextAlignment(.center)
                        
                        // Поля ввода
                        VStack(spacing: 25) {
                            // Email
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
                                .onChange(of: self.string_Email) { _ in
                                    self.flag_EmailError = false
                                }
                                .background(
                                    ZStack {
                                        Rectangle()
                                            .fill(Consts.Colors.Gray_C9)
                                            .cornerRadius(20)
                                        if self.flag_EmailError {
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(Consts.Colors.error, lineWidth: 1)
                                        } else {
                                            if self.focusState == .Email {
                                                RoundedRectangle(cornerRadius: 20)
                                                    .stroke(Consts.Colors.Green_51, lineWidth: 1)
                                            } else {
                                                RoundedRectangle(cornerRadius: 20)
                                                    .stroke(Consts.Colors.black, lineWidth: 1)
                                            }
                                        }
                                    }
                                )
                                .onTapGesture {
                                    self.focusState = .Email
                                }
                            
                            // Пароль
                            SecureField("", text: self.$string_Password)
                                .padding(15)
                                .disableAutocorrection(true)
                                .focused(self.$focusState, equals: .Password)
                                .font(Font.custom(Consts.Fonts.Regular, size: 14))
                                .foregroundColor(self.flag_PasswordError ? Consts.Colors.error : Consts.Colors.black)
                                .placeholder(when: self.string_Password.isEmpty) {
                                    ZStack {
                                        Text(verbatim: " Пароль ")
                                            .padding(15)
                                            .font(Font.custom(Consts.Fonts.Regular, size: 14))
                                            .foregroundColor(self.flag_PasswordError ? Consts.Colors.error : Consts.Colors.black)
                                    }
                                }
                                .onChange(of: self.string_Password) { _ in
                                    self.flag_PasswordError = false
                                }
                                .background(
                                    ZStack {
                                        Rectangle()
                                            .fill(Consts.Colors.Gray_C9)
                                            .cornerRadius(20)
                                        if self.flag_PasswordError {
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(Consts.Colors.error, lineWidth: 1)
                                        } else {
                                            if self.focusState == .Password {
                                                RoundedRectangle(cornerRadius: 20)
                                                    .stroke(Consts.Colors.Green_51, lineWidth: 1)
                                            } else {
                                                RoundedRectangle(cornerRadius: 20)
                                                    .stroke(Consts.Colors.black, lineWidth: 1)
                                            }
                                        }
                                    }
                                )
                                .onTapGesture {
                                    self.focusState = .Password
                                }
                            
                            Button(action: {
                                self.flag_Loading = true
                                self.apiUtils.loginUserAndFetchData(email: self.string_Email, password: self.string_Password) { result in
                                    switch result {
                                    case .success(let userModel):
                                        print("Пользователь успешно авторизован и данные получены:")
                                        self.apiUtils.saveUserIDToUserDefaults(UserInfo: UserInfo(
                                            id: UUID(),
                                            clientID: userModel.clientID,
                                            avatar: userModel.avatar,
                                            email: userModel.email,
                                            position: userModel.position,
                                            grade: userModel.grade,
                                            cabinetID: userModel.cabinetID,
                                            fio: userModel.fio,
                                            officeID: userModel.officeID,
                                            flag_isAdmin: userModel.flag_isAdmin),
                                                                               key: "UserInfo")
                                        
                                        UserInfoManager.shared.clientID = userModel.clientID
                                        UserInfoManager.shared.avatar = userModel.avatar
                                        UserInfoManager.shared.email = userModel.email
                                        UserInfoManager.shared.position = userModel.position
                                        UserInfoManager.shared.grade = userModel.grade
                                        UserInfoManager.shared.cabinetID = userModel.cabinetID
                                        UserInfoManager.shared.fio = userModel.fio
                                        UserInfoManager.shared.officeID = userModel.officeID
                                        UserInfoManager.shared.flag_isAdmin = userModel.flag_isAdmin
                                        flag_showMain = true
                                        
                                    case .failure(let error):
                                        print("Ошибка при авторизации или получении данных: \(error.localizedDescription)")
                                        self.flag_Loading = false
                                    }
                                }
                            }) {
                                Text("Войти")
                                    .font(Font.custom(Consts.Fonts.Regular, size: 24))
                                    .foregroundColor(Consts.Colors.black)
                                    .multilineTextAlignment(.center)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .frame(height: 48)
                                    .background((!self.string_Email.isEmpty && self.string_Password.count > 5) ? Consts.Colors.Green_51.opacity(0.5) : Consts.Colors.Gray_C9)
                                    .cornerRadius(20)
                            }
                            .disabled(!(!self.string_Email.isEmpty && self.string_Password.count > 5))
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
                        .padding(.horizontal)
                        .padding(.top, 40)
                        
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
            .blur(radius: flag_Loading ? 5 : 0)
            .animation(.easeInOut, value: flag_Loading)
            if flag_Loading {
                ZStack {
                    Consts.Colors.Gray_C9.opacity(0.5)
                        .ignoresSafeArea()
                    LottieView(animation: .named("AnimationLoading"))
                        .playbackMode(.playing(.toProgress(1, loopMode: .loop)))
                }
                .ignoresSafeArea()
                .animation(.easeInOut, value: flag_Loading)
            }
        }
        .fullScreenCover(isPresented: $flag_showMain) {
            MainView()
        }
    }
        
}

