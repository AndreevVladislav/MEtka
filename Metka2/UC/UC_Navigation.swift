//
//  UC_Navigation.swift
//  Metka2
//
//  Created by Vladislav Andreev on 22.11.2024.
//

import Foundation
import SwiftUI

struct UC_Navigation: View {
    @EnvironmentObject var env_Nav: Env_Nav
    
    var body: some View {
        HStack {
            // Профиль
            Button(action: {
                env_Nav.Tab_Selection = 0 // Изменяем активный таб
            }) {
                VStack(spacing: 3) {
                    Group {
                        if env_Nav.Tab_Selection == 0 {
                            Consts.Images.ic_profile_active
                                .resizable()
                                .scaledToFit()
                        } else {
                            Consts.Images.ic_profile_NoActive
                                .resizable()
                                .scaledToFit()
                        }
                    }
                    .frame(width: 24, height: 24)
                }
            }
            .frame(maxWidth: .infinity)
            
            // Карта
            Button(action: {
                env_Nav.Tab_Selection = 1 // Изменяем активный таб
            }) {
                VStack(spacing: 3) {
                    Group {
                        if env_Nav.Tab_Selection == 1 {
                            Consts.Images.ic_map_active
                                .resizable()
                                .scaledToFit()
                        } else {
                            Consts.Images.ic_map_NoActive
                                .resizable()
                                .scaledToFit()
                        }
                    }
                    .frame(width: 24, height: 24)
                }
            }
            .frame(maxWidth: .infinity)
//            
//            // Редактирование карты
            Button(action: {
                env_Nav.Tab_Selection = 2 // Изменяем активный таб
            }) {
                VStack(spacing: 3) {
                    Group {
                        if env_Nav.Tab_Selection == 2 {
                            Consts.Images.ic_search_active
                                .resizable()
                                .scaledToFit()
                        } else {
                            Consts.Images.ic_search_NoActive
                                .resizable()
                                .scaledToFit()
                        }
                    }
                    .frame(width: 24, height: 24)
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
}
