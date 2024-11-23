//
//  AdminkaView.swift
//  Metka2
//
//  Created by Vladislav Andreev on 23.11.2024.
//

import Foundation
import SwiftUI

struct AdminkaView: View {
    
    private enum E_Field: Hashable {
        case clientID
        case avatar
        case email
        case position
        case grade
        case cabinetID
        case fio
        case officeID
    }
    
    @FocusState private var focusState: E_Field?
    
    @State private var string_clientID: String = ""
    @State private var string_avatar: String = ""
    @State private var string_email: String = ""
    @State private var string_position: String = ""
    @State private var string_grade: String = ""
    @State private var string_cabinetID: String = ""
    @State private var string_fio: String = ""
    @State private var string_officeID: String = ""
    
    var body: some View {
        VStack {
            VStack {
                TextField("", text: self.$string_clientID)
                    .padding(15)
                    .disableAutocorrection(true)
                    .focused(self.$focusState, equals: .clientID)
                    .font(Font.custom(Consts.Fonts.Regular, size: 14))
                    .foregroundColor(Consts.Colors.black)
                    .placeholder(when: self.string_clientID.isEmpty) {
                        ZStack {
                            Text(verbatim: " id ")
                                .padding(15)
                                .font(Font.custom(Consts.Fonts.Regular, size: 14))
                                .foregroundColor(Consts.Colors.black)
                        }
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
                                .foregroundColor(Consts.Colors.black)
                        }
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
                                .foregroundColor(Consts.Colors.black)
                        }
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
                                .foregroundColor(Consts.Colors.black)
                        }
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
                                .foregroundColor(Consts.Colors.black)
                        }
                    }
                
                TextField("", text: self.$string_cabinetID)
                    .padding(15)
                    .disableAutocorrection(true)
                    .focused(self.$focusState, equals: .cabinetID)
                    .font(Font.custom(Consts.Fonts.Regular, size: 14))
                    .foregroundColor(Consts.Colors.black)
                    .placeholder(when: self.string_cabinetID.isEmpty) {
                        ZStack {
                            Text(verbatim: " cabinetID ")
                                .padding(15)
                                .font(Font.custom(Consts.Fonts.Regular, size: 14))
                                .foregroundColor(Consts.Colors.black)
                        }
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
                                .foregroundColor(Consts.Colors.black)
                        }
                    }
                
                TextField("", text: self.$string_officeID)
                    .padding(15)
                    .disableAutocorrection(true)
                    .focused(self.$focusState, equals: .officeID)
                    .font(Font.custom(Consts.Fonts.Regular, size: 14))
                    .foregroundColor(Consts.Colors.black)
                    .placeholder(when: self.string_officeID.isEmpty) {
                        ZStack {
                            Text(verbatim: " officeID ")
                                .padding(15)
                                .font(Font.custom(Consts.Fonts.Regular, size: 14))
                                .foregroundColor(Consts.Colors.black)
                        }
                    }
                
                Button(action: {
                    
                }) {
                    Text("Создать")
                        .font(Font.custom(Consts.Fonts.Regular, size: 24))
                        .foregroundColor(Consts.Colors.black)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .frame(height: 48)
                }
            }
            
        }
        .padding()
    }
}
