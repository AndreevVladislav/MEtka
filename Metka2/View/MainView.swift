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
            }
        }
        .onAppear {
            self.env_Nav.Tab_Selection = 0 // Устанавливаем начальный таб
            self.flag_showLogin = true
        }
        .background(Consts.Colors.background)
        .fullScreenCover(isPresented: $flag_showLogin) {
            LoginView()
        }
    }
}

