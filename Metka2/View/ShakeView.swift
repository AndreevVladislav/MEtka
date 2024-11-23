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
    
    var body: some View {
        ZStack {
            Consts.Colors.Gray_C9
                .ignoresSafeArea()
            VStack(spacing: 20) {
                Text("NFC Считыватель")
                    .font(.largeTitle)
                    .padding()
                
                Text(nfcReader.message.isEmpty ? "Нет данных" : "Данные с метки: \(nfcReader.message)")
                    .padding()
                    .multilineTextAlignment(.center)
                
                Button("Начать сканирование") {
                    nfcReader.startScanning()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding()
        }
    }
}

