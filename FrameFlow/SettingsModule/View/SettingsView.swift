//
//  SettingsView.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 12/31/24.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject private var viewModel: SettingsViewModel
    
    internal var body: some View {
        NavigationStack {
            ZStack {
                Form {
                    aboutAppSection
                    content
                    application
                    contact
                }
                
                // Overlay for adjusting animation speed
                if viewModel.showingSpeedOverlay {
                    speedSlider
                }
            }
            .scrollIndicators(.hidden)
            .navigationTitle(Texts.Settings.title)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private var aboutAppSection: some View {
        Section(Texts.Settings.about) {
            HStack(spacing: 16) {
                Image.Settings.about
                    .resizable()
                    .frame(width: 60, height: 60)
                    .clipShape(.buttonBorder)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(Texts.Settings.appName)
                        .font(.title())
                        .foregroundStyle(Color.LabelColors.labelPrimary)
                    
                    Text(viewModel.version)
                        .font(.subhead())
                        .foregroundStyle(Color.LabelColors.labelSecondary)
                }
                Spacer()
            }
        }
    }
    
    private var content: some View {
        Section(Texts.Settings.content) {
            Button {
                viewModel.showSpeedOverlayToggle()
            } label: {
                LinkRow(title: Texts.Settings.speed,
                        image: Image.Settings.speed,
                        details: String(format: "%.2f", viewModel.animationSpeed),
                        chevron: true)
            }
        }
    }
    
    /// An overlay to adjust animation speed with a tap-to-dismiss background.
    private var speedSlider: some View {
        ZStack {
            Color.black.opacity(0.4)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        viewModel.showSpeedOverlayToggle()
                    }
                }
            VStack {
                Spacer()
                SpeedSliderOverlay()
                Spacer()
            }
        }
        .zIndex(1)
    }
    
    private var application: some View {
        Section(Texts.Settings.application) {
            Button {
                viewModel.showLanguageAlertToggle()
            } label: {
                LinkRow(title: Texts.Settings.Language.title, image: Image.Settings.language, details: Texts.Settings.Language.details, chevron: true)
            }
            .alert(isPresented: $viewModel.showingLanguageAlert) {
                Alert(
                    title: Text(Texts.Settings.Language.alertTitle),
                    message: Text(Texts.Settings.Language.alertContent),
                    primaryButton: .default(Text(Texts.Settings.title)) {
                        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
                        UIApplication.shared.open(url)
                    },
                    secondaryButton: .cancel(Text(Texts.Settings.cancel))
                )
            }
            
            NavigationLink(destination: AppearanceView().environmentObject(viewModel)) {
                LinkRow(title: Texts.Settings.Appearance.title, image: Image.Settings.appearance, details: viewModel.userTheme.name)
            }
        }
    }
    
    private var contact: some View {
        Section(Texts.Settings.contact) {
            Link(destination: URL(string: "mailto:\(Texts.Settings.emailContent)")!, label: {
                LinkRow(title: Texts.Settings.emailTitle, image: Image.Settings.email, details: Texts.Settings.emailContent, chevron: true)
            })
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(SettingsViewModel(speed: 0.1))
}
