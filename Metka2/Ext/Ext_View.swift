//
//  Ext_View.swift
//  Metka2
//
//  Created by Vladislav Andreev on 23.11.2024.
//

import Foundation
import SwiftUI

extension View {
    
    /// Кастомный плейсхолдер
    /// - Parameters:
    ///   - shouldShow: True - Плейсхолдер отображён
    ///   - alignment: Выравнивание
    ///   - placeholder: Плейсхолдер
    /// - Returns: Поле с плейсхолдером
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
