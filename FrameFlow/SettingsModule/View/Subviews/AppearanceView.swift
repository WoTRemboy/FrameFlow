//
//  AppearanceView.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 12/31/24.
//

import SwiftUI

struct AppearanceView: View {
    
    @Environment(\.colorScheme) private var scheme
    @EnvironmentObject private var viewModel: SettingsViewModel
    
    internal var body: some View {
        NavigationStack {
            themePicker
            .scrollIndicators(.hidden)
            .navigationTitle(Texts.Settings.Appearance.title)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
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

#Preview {
    AppearanceView()
        .environmentObject(SettingsViewModel(speed: 0.1))
}
