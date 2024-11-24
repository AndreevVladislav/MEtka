//
//  ShakeView.swift
//  Metka2
//
//  Created by Vladislav Andreev on 23.11.2024.
//

import Foundation
import SwiftUI
import CoreNFC

struct ShakeView: View {
    
    @StateObject private var nfcReader = NFCReader()
    @ObservedObject var tecniqueManager = TecniqueManager.shared
    @ObservedObject var cabinetManager = CabinetManager.shared
    
    private enum E_Field: Hashable {
        case Email
    }
    
    /// Активное поле ввода
    @FocusState private var focusState: E_Field?
    
    /// Значение поля ввода "Email"
    @State private var string_Email: String = ""
    
    @State private var showAlert = false
    
    @State private var showAlert2 = false
    
    @State private var fake_email = "-"
    
    var body: some View {
        ZStack {
            Consts.Colors.Gray_C9
                .ignoresSafeArea()
            VStack (spacing: 0) {
                if TecniqueManager.shared.flag_openTech {
                    VStack {
                        
                        HStack {
                            if self.tecniqueManager.selectTech.type == "Смартфон" {
                                Consts.Images.ic_mobile
                                    .resizable()
                                    .frame(width: 80, height: 100)
                            } else {
                                Consts.Images.ic_pc
                                    .resizable()
                                    .frame(width: 100, height: 100)
                            }

                        }
                        .padding(40)
                        VStack(spacing: 40) {
                            HStack {
                                Text("Устройство")
                                    .font(Font.custom(Consts.Fonts.Regular, size: 20))
                                    .foregroundStyle(Consts.Colors.black)
                                    .multilineTextAlignment(.leading)
                                    .frame(maxWidth: .infinity)
                                
                                Text(" - ")
                                    .font(Font.custom(Consts.Fonts.Regular, size: 20))
                                    .foregroundStyle(Consts.Colors.black)
                                
                                Text("\(self.tecniqueManager.selectTech.name ?? "error")")
                                    .font(Font.custom(Consts.Fonts.Regular, size: 20))
                                    .foregroundStyle(Consts.Colors.black)
                                    .multilineTextAlignment(.trailing)
                                    .frame(maxWidth: .infinity)
                            }
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity)
                            
                            HStack {
                                Text("Тип устройства")
                                    .font(Font.custom(Consts.Fonts.Regular, size: 20))
                                    .foregroundStyle(Consts.Colors.black)
                                    .multilineTextAlignment(.leading)
                                    .frame(maxWidth: .infinity)
                                
                                Text(" - ")
                                    .font(Font.custom(Consts.Fonts.Regular, size: 20))
                                    .foregroundStyle(Consts.Colors.black)
                                
                                Text("\(self.tecniqueManager.selectTech.type ?? "error")")
                                    .font(Font.custom(Consts.Fonts.Regular, size: 20))
                                    .foregroundStyle(Consts.Colors.black)
                                    .multilineTextAlignment(.trailing)
                                    .frame(maxWidth: .infinity)
                            }
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity)
                            
                            HStack {
                                Text("Операционная система")
                                    .font(Font.custom(Consts.Fonts.Regular, size: 20))
                                    .foregroundStyle(Consts.Colors.black)
                                    .multilineTextAlignment(.leading)
                                    .frame(maxWidth: .infinity)
                                
                                Text(" - ")
                                    .font(Font.custom(Consts.Fonts.Regular, size: 20))
                                    .foregroundStyle(Consts.Colors.black)
                                
                                Text("\(self.tecniqueManager.selectTech.os ?? "error")")
                                    .font(Font.custom(Consts.Fonts.Regular, size: 20))
                                    .foregroundStyle(Consts.Colors.black)
                                    .multilineTextAlignment(.trailing)
                                    .frame(maxWidth: .infinity)
                            }
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity)
                            
                            HStack {
                                Text("Производитель")
                                    .font(Font.custom(Consts.Fonts.Regular, size: 18))
                                    .foregroundStyle(Consts.Colors.black)
                                    .multilineTextAlignment(.leading)
                                    .frame(maxWidth: .infinity)
                                
                                Text(" - ")
                                    .font(Font.custom(Consts.Fonts.Regular, size: 20))
                                    .foregroundStyle(Consts.Colors.black)
                                
                                Text("\(self.tecniqueManager.selectTech.made ?? "error")")
                                    .font(Font.custom(Consts.Fonts.Regular, size: 20))
                                    .foregroundStyle(Consts.Colors.black)
                                    .multilineTextAlignment(.trailing)
                                    .frame(maxWidth: .infinity)
                            }
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity)
                            
                            HStack {
                                Text("Состояние")
                                    .font(Font.custom(Consts.Fonts.Regular, size: 20))
                                    .foregroundStyle(Consts.Colors.black)
                                    .multilineTextAlignment(.leading)
                                    .frame(maxWidth: .infinity)
                                
                                Text(" - ")
                                    .font(Font.custom(Consts.Fonts.Regular, size: 20))
                                    .foregroundStyle(Consts.Colors.black)
                                
                                Text("\(self.tecniqueManager.selectTech.status ?? "error")")
                                    .font(Font.custom(Consts.Fonts.Regular, size: 20))
                                    .foregroundStyle(Consts.Colors.black)
                                    .multilineTextAlignment(.trailing)
                                    .frame(maxWidth: .infinity)
                            }
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity)
                            
                            HStack {
                                Text("Пользователь")
                                    .font(Font.custom(Consts.Fonts.Regular, size: 20))
                                    .foregroundStyle(Consts.Colors.black)
                                    .multilineTextAlignment(.leading)
                                    .frame(maxWidth: .infinity)
                                
                                Text(" - ")
                                    .font(Font.custom(Consts.Fonts.Regular, size: 20))
                                    .foregroundStyle(Consts.Colors.black)
                                
                                Text("\(self.tecniqueManager.fake_email)")
                                    .font(Font.custom(Consts.Fonts.Regular, size: 20))
                                    .foregroundStyle(Consts.Colors.black)
                                    .multilineTextAlignment(.trailing)
                                    .frame(maxWidth: .infinity)
                            }
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity)
                            
                            
                        }
                        Spacer()
                        
                        TextField("\(self.tecniqueManager.fake_email)", text: self.$string_Email)
                            .padding(15)
                            .disableAutocorrection(true)
                            .focused(self.$focusState, equals: .Email)
                            .font(Font.custom(Consts.Fonts.Regular, size: 14))
                            .foregroundColor(Consts.Colors.black)
                            .placeholder(when: self.string_Email.isEmpty) {
                                ZStack {
                                    Text(verbatim: " Email ")
                                        .padding(15)
                                        .font(Font.custom(Consts.Fonts.Regular, size: 14))
                                        .foregroundColor(Consts.Colors.black)
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
                                self.focusState = .Email
                            }
                            .padding(.bottom, 20)
                        
                        VStack {
                            if self.tecniqueManager.fake_email != "" {
                                Button(action: {
                                    showAlert2 = true
                                    self.tecniqueManager.fake_email = ""
                                }) {
                                    Text("Открепить")
                                        .font(Font.custom(Consts.Fonts.Regular, size: 24))
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
                            } else {
                                Button(action: {
                                    showAlert = true
                                    self.tecniqueManager.fake_email = self.string_Email
                                }) {
                                    Text("Прикрепить")
                                        .font(Font.custom(Consts.Fonts.Regular, size: 24))
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
                            
                        }
                    }
                } else if CabinetManager.shared.flag_openCabinet {
                    VStack {
                        Text("\(self.cabinetManager.selectTech.name ?? "error")")
                            .font(Font.custom(Consts.Fonts.Regular, size: 20))
                            .foregroundStyle(Consts.Colors.black)
                        Text("\(self.cabinetManager.selectTech.type ?? "error")")
                            .font(Font.custom(Consts.Fonts.Regular, size: 20))
                            .foregroundStyle(Consts.Colors.black)
                    }
                } else {
                
                }
            }
            .padding()
        }
        .onAppear {
            TecniqueManager.shared.flag_openTech = false
            CabinetManager.shared.flag_openCabinet = false
            
            nfcReader.startScanning()
        }
        .alert("Устройство зареплено за прользователем \(self.string_Email)", isPresented: $showAlert) {
                   Button("ок") {
                       self.showAlert = false
                   }
        } message: {
            Text("")
        }
        .onAppear {
            TecniqueManager.shared.flag_openTech = false
            CabinetManager.shared.flag_openCabinet = false
            
            nfcReader.startScanning()
        }
        .alert("Устройство откреплено", isPresented: $showAlert2) {
                   Button("ок") {
                       self.showAlert2 = false
                   }
        } message: {
            Text("")
        }
    
    }
}

