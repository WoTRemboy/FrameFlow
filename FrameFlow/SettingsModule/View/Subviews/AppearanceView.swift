//
//  AppearanceView.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 12/31/24.
//

import SwiftUI

/// A view providing theme selection options (e.g., light, dark, or system default).
///
/// Users can pick a theme to override or follow the system’s appearance.
struct AppearanceView: View {
    
    // MARK: - Properties
    
    /// The current color scheme from the environment (used to display accent colors correctly).
    @Environment(\.colorScheme) private var scheme
    /// The shared settings view model that manages the user’s theme preference.
    @EnvironmentObject private var viewModel: SettingsViewModel
    
    // MARK: - Body
    
    /// The main content of the appearance settings, rendered in a navigation stack.
    internal var body: some View {
        NavigationStack {
            themePicker
            .scrollIndicators(.hidden)
            .navigationTitle(Texts.Settings.Appearance.title)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    // MARK: - Theme Picker
    
    /// A form presenting all available `Theme` options, allowing the user to select one.
    private var themePicker: some View {
        Form {
            ForEach(Theme.allCases, id: \.self) { theme in
                Button {
                    viewModel.changeTheme(theme: theme)
                } label: {
                    LinkRow(title: theme.name, check: theme == viewModel.userTheme)
                }
            }
        }
    }
}

// MARK: - Preview

#Preview {
    AppearanceView()
        .environmentObject(SettingsViewModel(speed: 0.1))
}
