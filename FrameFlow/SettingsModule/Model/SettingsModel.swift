//
//  SettingsModel.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 12/31/24.
//

import SwiftUI

enum Theme: String, CaseIterable {
    case systemDefault = "Default"
    case light = "Light"
    case dark = "Dark"
    
    internal var name: String {
        switch self {
        case .systemDefault:
            Texts.Settings.Appearance.system
        case .light:
            Texts.Settings.Appearance.light
        case .dark:
            Texts.Settings.Appearance.dark
        }
    }
    
    internal func color(_ scheme: ColorScheme) -> Color {
        switch self {
        case .systemDefault:
            scheme == .light ? Color.orange : Color.blue
        case .light:
            Color.orange
        case .dark:
            Color.blue
        }
    }
    
    internal var userInterfaceStyle: UIUserInterfaceStyle {
            switch self {
            case .systemDefault:
                return .unspecified
            case .light:
                return .light
            case .dark:
                return .dark
            }
        }
    
    internal var colorScheme: ColorScheme? {
        switch self {
        case .systemDefault:
            nil
        case .light:
            ColorScheme.light
        case .dark:
            ColorScheme.dark
        }
    }
}
