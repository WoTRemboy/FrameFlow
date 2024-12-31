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
            Form {
                aboutAppSection
                content
                application
                contact
            }
            .onAppear {
                viewModel.dataUpdate()
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
            LinkRow(title: Texts.Settings.speed, image: Image.Settings.speed, details: "0.1", chevron: true)
        }
    }
    
    private var application: some View {
        Section(Texts.Settings.application) {
            LinkRow(title: Texts.Settings.language, image: Image.Settings.language, details: Texts.Settings.languageContent, chevron: true)
            
            LinkRow(title: Texts.Settings.Appearance.title, image: Image.Settings.appearance, details: "System", chevron: true)
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
        .environmentObject(SettingsViewModel())
}
