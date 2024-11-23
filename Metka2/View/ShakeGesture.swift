//
//  ShakeGesture.swift
//  Metka2
//
//  Created by Vladislav Andreev on 23.11.2024.
//

import Foundation
import SwiftUI
import UIKit

struct ShakeGestureHandler: ViewModifier {
    let onShake: () -> Void
    
    func body(content: Content) -> some View {
        content
            .background(ShakeDetector(onShake: onShake))
    }
}

struct ShakeDetector: UIViewControllerRepresentable {
    var onShake: () -> Void
    
    func makeUIViewController(context: Context) -> ShakeHostingController {
        let controller = ShakeHostingController()
        controller.onShake = onShake
        return controller
    }
    
    func updateUIViewController(_ uiViewController: ShakeHostingController, context: Context) {}

    /// Реализация нового метода для протокола `UIViewControllerRepresentable`
    func sizeThatFits(_ proposal: ProposedViewSize, uiViewController: ShakeHostingController, context: Context) -> CGSize? {
        return nil // Возвращаем `nil`, чтобы использовать размер по умолчанию
    }
}

class ShakeHostingController: UIViewController {
    var onShake: (() -> Void)?
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            onShake?()
        }
    }
}

