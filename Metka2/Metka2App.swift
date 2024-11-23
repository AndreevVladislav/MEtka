//
//  Metka2App.swift
//  Metka2
//
//  Created by Vladislav Andreev on 22.11.2024.
//

import SwiftUI
import FirebaseCore

@main
struct Metka2App: App {
    @StateObject private var envNav = Env_Nav() // Создание объекта Env_Nav
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(envNav) // Передача объекта в окружение
        }
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}


