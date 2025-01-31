//
//  SettingsModel.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 12/31/24.
//

import SwiftUI

/// Represents the available application themes (system default, light, and dark).
///
/// Changing the theme updates the app’s UI style accordingly.
enum Theme: String, CaseIterable {
    /// The system default theme, allowing iOS to manage light or dark mode automatically.
    case systemDefault = "Default"
    /// The light theme, forcing a bright UI regardless of system preferences.
    case light = "Light"
    /// The dark theme, forcing a dimmed UI regardless of system preferences.
    case dark = "Dark"
    
    /// A localized string name for each theme to be displayed in the UI.
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
    
    /// Determines a representative color for the theme based on the current `ColorScheme`.
    /// - Parameter scheme: The current `ColorScheme` (light or dark).
    /// - Returns: A `Color` used as a highlight or accent for the theme.
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
    
    /// Maps the theme to the corresponding `UIUserInterfaceStyle`.
    ///
    /// Used when needs to override the entire app's appearance programmatically.
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
    
    /// Maps the theme to a SwiftUI `ColorScheme`, if applicable.
    ///
    /// - Returns: The corresponding `ColorScheme` for the theme, or `nil` if using system default.
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
