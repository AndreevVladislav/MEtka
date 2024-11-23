//
//  LoadingView.swift
//  Metka2
//
//  Created by Vladislav Andreev on 23.11.2024.
//

import Foundation
import SwiftUI
import Lottie

struct LoadingView: View {
    
    @State private var flag_PresentMain = false
    
    @State private var flag_PresentLogin = false
    
    var body: some View {
        ZStack {
            Consts.Colors.Gray_C9
                .ignoresSafeArea()
            LottieView(animation: .named("Animation"))
                .playbackMode(.playing(.toProgress(1, loopMode: .playOnce)))
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                if let data = UserDefaults.standard.data(forKey: "UserInfo") {
                    do {
                        let decoder = JSONDecoder()
                        let userInfo = try decoder.decode(UserInfo.self, from: data)
                        
                        UserInfoManager.shared.clientID = userInfo.clientID
                        UserInfoManager.shared.avatar = userInfo.avatar
                        UserInfoManager.shared.email = userInfo.email
                        UserInfoManager.shared.position = userInfo.position
                        UserInfoManager.shared.grade = userInfo.grade
                        UserInfoManager.shared.cabinetID = userInfo.cabinetID
                        UserInfoManager.shared.fio = userInfo.fio
                        UserInfoManager.shared.officeID = userInfo.officeID
                        UserInfoManager.shared.flag_isAdmin = userInfo.flag_isAdmin
                        
                        flag_PresentMain = true
                        
                    } catch {
                        flag_PresentLogin = true
                    }
                } else {
                    flag_PresentLogin = true
                }

            }
        }
        .fullScreenCover(isPresented: $flag_PresentLogin) {
            LoginView()
        }
        .fullScreenCover(isPresented: $flag_PresentMain) {
            MainView()
        }
    }
}

#Preview {
    LoadingView()
}
