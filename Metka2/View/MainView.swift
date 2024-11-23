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
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                Spacer()
                // Навигационный бар
                UC_Navigation()
                    .frame(height: 48)
            }
        }
        .onAppear {
            self.env_Nav.Tab_Selection = 0 // Устанавливаем начальный таб
            self.flag_showLogin = false
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

