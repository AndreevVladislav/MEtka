//
//  NewProfileView.swift
//  Metka2
//
//  Created by Vladislav Andreev on 24.11.2024.
//

import Foundation
import SwiftUI

struct NewProfileView: View {
    
    private enum E_Field: Hashable {
        
        case clientID
        
        case avatar
        
        case email
        
        case position
        
        case grade
        
        case fio
        
        case password
    }
    
    @State private var string_clientID: String = ""
    
    @State private var string_avatar: String = ""
    
    @State private var string_email: String = ""
    
    @State private var string_position: String = ""
    
    @State private var string_grade: String = ""
    
    @State private var string_fio: String = ""
    
    @State private var string_password: String = ""
    
    @State private var flag_isAdmin: Bool = false
    
    /// Активное поле ввода
    @FocusState private var focusState: E_Field?
    
    private let apiUtils = ApiUtils()
    
    var body: some View {
        ScrollView {
            VStack {
                VStack(spacing: 20) {
                    
                    Toggle(isOn: $flag_isAdmin) {
                        Text("Администатор")
                    }
                    .toggleStyle(.switch)
                    TextField("", text: self.$string_clientID)
                        .padding(15)
                        .disableAutocorrection(true)
                        .focused(self.$focusState, equals: .clientID)
                        .font(Font.custom(Consts.Fonts.Regular, size: 14))
                        .foregroundColor(Consts.Colors.black)
                        .placeholder(when: self.string_clientID.isEmpty) {
                            ZStack {
                                Text(verbatim: " ClientID ")
                                    .padding(15)
                                    .font(Font.custom(Consts.Fonts.Regular, size: 14))
                                    .foregroundColor(Consts.Colors.Gray_17)
                            }
                        }
                        .background(
                            ZStack {
                                Rectangle()
                                    .fill(Consts.Colors.Gray_C9)
                                    .cornerRadius(20)
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Consts.Colors.black, lineWidth: 1)
                            }
                            
                            
                        )
                        .onTapGesture {
                            self.focusState = .clientID
                        }
                    
                    TextField("", text: self.$string_avatar)
                        .padding(15)
                        .disableAutocorrection(true)
                        .focused(self.$focusState, equals: .avatar)
                        .font(Font.custom(Consts.Fonts.Regular, size: 14))
                        .foregroundColor(Consts.Colors.black)
                        .placeholder(when: self.string_avatar.isEmpty) {
                            ZStack {
                                Text(verbatim: " avatar ")
                                    .padding(15)
                                    .font(Font.custom(Consts.Fonts.Regular, size: 14))
                                    .foregroundColor(Consts.Colors.Gray_17)
                            }
                        }
                        .background(
                            ZStack {
                                Rectangle()
                                    .fill(Consts.Colors.Gray_C9)
                                    .cornerRadius(20)
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Consts.Colors.black, lineWidth: 1)
                            }
                            
                            
                        )
                        .onTapGesture {
                            self.focusState = .avatar
                        }
                    
                    TextField("", text: self.$string_email)
                        .padding(15)
                        .disableAutocorrection(true)
                        .focused(self.$focusState, equals: .email)
                        .font(Font.custom(Consts.Fonts.Regular, size: 14))
                        .foregroundColor(Consts.Colors.black)
                        .placeholder(when: self.string_email.isEmpty) {
                            ZStack {
                                Text(verbatim: " email ")
                                    .padding(15)
                                    .font(Font.custom(Consts.Fonts.Regular, size: 14))
                                    .foregroundColor(Consts.Colors.Gray_17)
                            }
                        }
                        .background(
                            ZStack {
                                Rectangle()
                                    .fill(Consts.Colors.Gray_C9)
                                    .cornerRadius(20)
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Consts.Colors.black, lineWidth: 1)
                            }
                            
                            
                        )
                        .onTapGesture {
                            self.focusState = .email
                        }
                    
                    TextField("", text: self.$string_position)
                        .padding(15)
                        .disableAutocorrection(true)
                        .focused(self.$focusState, equals: .position)
                        .font(Font.custom(Consts.Fonts.Regular, size: 14))
                        .foregroundColor(Consts.Colors.black)
                        .placeholder(when: self.string_position.isEmpty) {
                            ZStack {
                                Text(verbatim: " position ")
                                    .padding(15)
                                    .font(Font.custom(Consts.Fonts.Regular, size: 14))
                                    .foregroundColor(Consts.Colors.Gray_17)
                            }
                        }
                        .background(
                            ZStack {
                                Rectangle()
                                    .fill(Consts.Colors.Gray_C9)
                                    .cornerRadius(20)
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Consts.Colors.black, lineWidth: 1)
                            }
                            
                            
                        )
                        .onTapGesture {
                            self.focusState = .position
                        }
                    
                    TextField("", text: self.$string_grade)
                        .padding(15)
                        .disableAutocorrection(true)
                        .focused(self.$focusState, equals: .grade)
                        .font(Font.custom(Consts.Fonts.Regular, size: 14))
                        .foregroundColor(Consts.Colors.black)
                        .placeholder(when: self.string_grade.isEmpty) {
                            ZStack {
                                Text(verbatim: " grade ")
                                    .padding(15)
                                    .font(Font.custom(Consts.Fonts.Regular, size: 14))
                                    .foregroundColor(Consts.Colors.Gray_17)
                            }
                        }
                        .background(
                            ZStack {
                                Rectangle()
                                    .fill(Consts.Colors.Gray_C9)
                                    .cornerRadius(20)
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Consts.Colors.black, lineWidth: 1)
                            }
                            
                            
                        )
                        .onTapGesture {
                            self.focusState = .grade
                        }
                    
                    TextField("", text: self.$string_fio)
                        .padding(15)
                        .disableAutocorrection(true)
                        .focused(self.$focusState, equals: .fio)
                        .font(Font.custom(Consts.Fonts.Regular, size: 14))
                        .foregroundColor(Consts.Colors.black)
                        .placeholder(when: self.string_fio.isEmpty) {
                            ZStack {
                                Text(verbatim: " fio ")
                                    .padding(15)
                                    .font(Font.custom(Consts.Fonts.Regular, size: 14))
                                    .foregroundColor(Consts.Colors.Gray_17)
                            }
                        }
                        .background(
                            ZStack {
                                Rectangle()
                                    .fill(Consts.Colors.Gray_C9)
                                    .cornerRadius(20)
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Consts.Colors.black, lineWidth: 1)
                            }
                            
                            
                        )
                        .onTapGesture {
                            self.focusState = .fio
                        }
                    
                    TextField("", text: self.$string_password)
                        .padding(15)
                        .disableAutocorrection(true)
                        .focused(self.$focusState, equals: .password)
                        .font(Font.custom(Consts.Fonts.Regular, size: 14))
                        .foregroundColor(Consts.Colors.black)
                        .placeholder(when: self.string_password.isEmpty) {
                            ZStack {
                                Text(verbatim: " password ")
                                    .padding(15)
                                    .font(Font.custom(Consts.Fonts.Regular, size: 14))
                                    .foregroundColor(Consts.Colors.Gray_17)
                            }
                        }
                        .background(
                            ZStack {
                                Rectangle()
                                    .fill(Consts.Colors.Gray_C9)
                                    .cornerRadius(20)
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Consts.Colors.black, lineWidth: 1)
                            }
                            
                            
                        )
                        .onTapGesture {
                            self.focusState = .password
                        }
                    
                    Button(action: {
                        createUser() 
                    }) {
                        Text("Сохранить")
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
                        let nfcWriter = NFCWriter()
                        nfcWriter.startSession(withText: String(string_clientID))
                    }) {
                        Text("записать на NFC")
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
                .padding(.top, 30)
            }
        }
    }
    
    private func createUser() {
        var isAdmin = 0
        if flag_isAdmin {
            isAdmin = 1
        } else {
            isAdmin = 0
        }
        let userModel = UserModel(
            clientID: Int(string_clientID) ?? 0,
            avatar: "https://example.com/avatar.png",
            email: string_email,
            position: string_position,
            grade: string_grade,
            cabinetID: 0,
            fio: string_fio,
            officeID: 0,
            flag_isAdmin: isAdmin
        )
        
        self.apiUtils.registerUser(email: userModel.email, password: string_password, userModel: userModel) { result in
            switch result {
            case .success:
                print("Пользователь успешно зарегистрирован и сохранен в Firestore")
            case .failure(let error):
                print("Ошибка при регистрации пользователя: \(error.localizedDescription)")
            }
        }
    }
}
