//
//  Constants.swift
//  Metka2
//
//  Created by Vladislav Andreev on 22.11.2024.
//

import Foundation
import SwiftUI

public class Consts {
    
    /// Цвета
    public struct Colors {
        
        /// красный ошибка
        public static let error: Color = Color.red
        
        /// черный
        public static let black: Color = Color.black
        
        /// Gray_17
        public static let Gray_17: Color = Color("Gray_17")
        
        /// Gray_C9
        public static let Gray_C9: Color = Color("Gray_C9")
        
        /// Green_11
        public static let Green_11: Color = Color("Green_11")
        
        /// Green_51
        public static let Green_51: Color = Color("Green_51")
        
        
    }
    /// Изображения
    public struct Images {
        
        /// иконка профиля неативная
        public static let ic_profile_NoActive: Image = Image("profile_NoActive");
        
        /// иконка профиля активная
        public static let ic_profile_active: Image = Image("profile_active");
        
        /// иконка карты неативная
        public static let ic_map_NoActive: Image = Image("ic_map_NoActive");
        
        /// иконка карты  активная
        public static let ic_map_active: Image = Image("ic_map_active");
        
        /// иконка поиска неативная
        public static let ic_search_active: Image = Image("ic_search_active");
        
        /// иконка поиска активная
        public static let ic_search_NoActive: Image = Image("ic_search_NoActive");
        
        public static let Logo: Image = Image("Logo");
        
        public static let avatar: Image = Image("avatar");
        
    }
    
    public struct Fonts {
        
        public static let UltraLight: String = "MullerUltraLight";
        
        public static let Thin: String = "MullerThin";
        
        public static let Regular: String = "MullerRegular";
        
        public static let Medium: String = "MullerMedium";
        
        public static let Light: String = "MullerLight";
        
        public static let ExtraBold: String = "MullerExtraBold";
        
        public static let Bold: String = "MullerBold";
    }
}
