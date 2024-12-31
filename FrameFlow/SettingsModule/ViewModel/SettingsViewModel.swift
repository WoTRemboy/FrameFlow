//
//  SettingsViewModel.swift
//  FrameFlow
//
//  Created by Roman Tverdokhleb on 12/31/24.
//

import Foundation
import SwiftUI

final class SettingsViewModel: ObservableObject {

    @Published internal var showingLanguageAlert: Bool = false
    @Published internal var showingSpeedOverlay: Bool = false
    
    @Published private(set) var version: String = String()
    @Published internal var speed: Double
    
    @AppStorage(Texts.UserDefaults.animationSpeed) var animationSpeed: Double = 0.1
    @AppStorage(Texts.UserDefaults.theme) var userTheme: Theme = .systemDefault
    
    init(speed: Double) {
        self.speed = speed
        versionDetect()
    }
    
    internal func showSpeedOverlayToggle() {
        withAnimation(.easeInOut(duration: 0.2)) {
            showingSpeedOverlay.toggle()
        }
    }
    
    internal func showLanguageAlertToggle() {
        showingLanguageAlert.toggle()
    }
    
    internal func setSpeed(to value: Double) {
        withAnimation(.easeInOut(duration: 0.2)) {
            animationSpeed = value
        }
    }
    
    internal func changeTheme(theme: Theme) {
        self.userTheme = theme
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                if let window = windowScene.windows.first(where: { $0.isKeyWindow }) {
                    UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
                        window.overrideUserInterfaceStyle = theme.userInterfaceStyle
                    })
                }
            }
        }
    }
    
    private func versionDetect() {
        if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String,
           let buildVersion = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
            version = "\(appVersion) \(Texts.Settings.release) \(buildVersion)"
        }
    }
}
