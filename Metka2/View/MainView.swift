//
//  MainView.swift
//  Metka2
//
//  Created by Vladislav Andreev on 22.11.2024.
//

import Foundation
import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var env_Nav: Env_Nav
    
    @State private var flag_showLogin = false
    
    @State private var flag_showShakeView = false
    
    private let apiUtils = ApiUtils()
    
    var body: some View {
        ZStack {
            VStack {
                // Контент в зависимости от активного таба
                Group {
                    if env_Nav.Tab_Selection == 0 {
                        ProfileView()
                    } else if env_Nav.Tab_Selection == 1 {
                        MapView()
                    } else if env_Nav.Tab_Selection == 2 {
                        SearchView()
                    } else if env_Nav.Tab_Selection == 3 {
                        MyTechnique()
                    } else if env_Nav.Tab_Selection == 4 {
                        MyOffice()
                    } else if env_Nav.Tab_Selection == 5 {
                        ShakeView()
                    } else if env_Nav.Tab_Selection == 6 {
                        MyTechnique()
                    } else if env_Nav.Tab_Selection == 7 {
                        AdminkaView()
                    } else if env_Nav.Tab_Selection == 8 {
                        NewProfileView()
                    } else if env_Nav.Tab_Selection == 9 {
                        NewTecniqueView()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                
            }
            VStack {
                Spacer()
                // Навигационный бар
                VStack {
                    UC_Navigation()
                        .frame(height: 48)
                }
                .background(Consts.Colors.Gray_C9)
            }
            
        }
        .onAppear {
            self.env_Nav.Tab_Selection = 0 // Устанавливаем начальный таб
            self.flag_showShakeView = false
           
           
        }
        .background(Consts.Colors.Gray_C9)
        .fullScreenCover(isPresented: $flag_showLogin) {
            LoginView()
        }
        .sheet(isPresented: $flag_showShakeView) {
            ShakeView()
        }
        .modifier(ShakeGestureHandler {
            flag_showShakeView = true
        })
                  
        
    }
}

