//
//  NewTecniqueView.swift
//  Metka2
//
//  Created by Vladislav Andreev on 24.11.2024.
//

import Foundation
import SwiftUI

struct NewTecniqueView: View {
    
    private enum E_Field: Hashable {
        
        case techID
        
        case name
        
        case type
        
        case os
        
        case made
        
        case status
        
    }
    
    @State private var string_techID: String = ""
    
    @State private var string_name: String = ""
    
    @State private var string_type: String = ""
    
    @State private var string_os: String = ""
    
    @State private var string_made: String = ""
    
    @State private var string_status: String = ""
    
    /// Активное поле ввода
    @FocusState private var focusState: E_Field?
    
    private let apiUtils = ApiUtils()
    
    var body: some View {
        ScrollView {
            VStack {
                VStack(spacing: 20) {
                    
                    
                    TextField("", text: self.$string_techID)
                        .padding(15)
                        .disableAutocorrection(true)
                        .focused(self.$focusState, equals: .techID)
                        .font(Font.custom(Consts.Fonts.Regular, size: 14))
                        .foregroundColor(Consts.Colors.black)
                        .placeholder(when: self.string_techID.isEmpty) {
                            ZStack {
                                Text(verbatim: " techID ")
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
                            self.focusState = .techID
                        }
                    
                    TextField("", text: self.$string_name)
                        .padding(15)
                        .disableAutocorrection(true)
                        .focused(self.$focusState, equals: .name)
                        .font(Font.custom(Consts.Fonts.Regular, size: 14))
                        .foregroundColor(Consts.Colors.black)
                        .placeholder(when: self.string_name.isEmpty) {
                            ZStack {
                                Text(verbatim: " name ")
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
                            self.focusState = .name
                        }
                    
                    TextField("", text: self.$string_type)
                        .padding(15)
                        .disableAutocorrection(true)
                        .focused(self.$focusState, equals: .type)
                        .font(Font.custom(Consts.Fonts.Regular, size: 14))
                        .foregroundColor(Consts.Colors.black)
                        .placeholder(when: self.string_type.isEmpty) {
                            ZStack {
                                Text(verbatim: " type ")
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
                            self.focusState = .type
                        }
                    
                    TextField("", text: self.$string_os)
                        .padding(15)
                        .disableAutocorrection(true)
                        .focused(self.$focusState, equals: .os)
                        .font(Font.custom(Consts.Fonts.Regular, size: 14))
                        .foregroundColor(Consts.Colors.black)
                        .placeholder(when: self.string_os.isEmpty) {
                            ZStack {
                                Text(verbatim: " os ")
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
                            self.focusState = .os
                        }
                    
                    TextField("", text: self.$string_status)
                        .padding(15)
                        .disableAutocorrection(true)
                        .focused(self.$focusState, equals: .status)
                        .font(Font.custom(Consts.Fonts.Regular, size: 14))
                        .foregroundColor(Consts.Colors.black)
                        .placeholder(when: self.string_status.isEmpty) {
                            ZStack {
                                Text(verbatim: " status ")
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
                            self.focusState = .status
                        }
                    
                    TextField("", text: self.$string_made)
                        .padding(15)
                        .disableAutocorrection(true)
                        .focused(self.$focusState, equals: .made)
                        .font(Font.custom(Consts.Fonts.Regular, size: 14))
                        .foregroundColor(Consts.Colors.black)
                        .placeholder(when: self.string_made.isEmpty) {
                            ZStack {
                                Text(verbatim: " made ")
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
                            self.focusState = .made
                        }
                    
                    
                    
                    Button(action: {
                        createTech()
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
                }
                .padding(.horizontal)
                .padding(.top, 30)
            }
        }
    }
    
    private func createTech() {
        let technique = ModelTechnique(
            id: nil,
            techID: Int(string_techID) ?? 0,
            name: string_name,
            type: string_type,
            os: string_os,
            made: string_made,
            status: string_status,
            officeID: 0,
            cabinetID: 0
        )
        
        self.apiUtils.saveTechniqueToFirestore(technique: technique) { result in
            switch result {
            case .success:
                print("Technique успешно сохранена в Firestore")
            case .failure(let error):
                print("Ошибка при сохранении техники в Firestore: \(error.localizedDescription)")
            }
        }
    }
}
