//
//  Metka2App.swift
//  Metka2
//
//  Created by Vladislav Andreev on 22.11.2024.
//

import SwiftUI

@main
struct Metka2App: App {
    @StateObject private var envNav = Env_Nav() // Создание объекта Env_Nav

    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(envNav) // Передача объекта в окружение
        }
    }
}
